/* 
 * MBalloc.c分析
 * ext4_mb_generate_buddy
 * ext4_mb_mark_free_simple
 * ext4_mb_init
 */

/*
 *  根据bitmap的数据生成buddy数据
 * mb_find_next_bit(void *addr, int max, int start)
 *   从start位开始搜索下一个“1”的位置，并返回该位置。例如搜索从低位到高位，0X04的下一个“1”为2
 * ffs(0x4) = 3 返回一个“1”的位置
 *
 */
static void ext4_mb_generate_buddy(struct super_block *sb,
				void *buddy, void *bitmap, ext4_group_t group)
{
	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
	unsigned short max = EXT4_BLOCKS_PER_GROUP(sb);
	unsigned short i = 0;
	unsigned short first;
	unsigned short len;
	unsigned free = 0;
	unsigned fragments = 0;
	unsigned long long period = get_cycles();
	/* initialize buddy from bitmap which is aggregation
	 * of on-disk bitmap and preallocations */
	i = mb_find_next_zero_bit(bitmap, max, 0);
	/* 搜索bitmap，从第0位找到第一个空闲的位置 */
	grp->bb_first_free = i;
	while (i < max) {
		fragments++; /* 该块组的碎片数 */
		first = i;
		i = mb_find_next_bit(bitmap, max, i); /* 搜索一个大的空闲块，并将其放入buddy中 */
		len = i - first;
		free += len;
		if (len > 1)
			ext4_mb_mark_free_simple(sb, buddy, first, len, grp);
		else
			grp->bb_counters[0]++;
		if (i < max)
			i = mb_find_next_zero_bit(bitmap, max, i);
	}
	grp->bb_fragments = fragments;

	if (free != grp->bb_free) {
		ext4_grp_locked_error(sb, group,  __func__,
			"EXT4-fs: group %u: %u blocks in bitmap, %u in gd",
			group, free, grp->bb_free);
		/*
		 * If we intent to continue, we consider group descritor
		 * corrupt and update bb_free using bitmap value
		 */
		grp->bb_free = free;
	}

	clear_bit(EXT4_GROUP_INFO_NEED_INIT_BIT, &(grp->bb_state));

	period = get_cycles() - period;
	spin_lock(&EXT4_SB(sb)->s_bal_lock);
	EXT4_SB(sb)->s_mb_buddies_generated++;
	EXT4_SB(sb)->s_mb_generation_time += period;
	spin_unlock(&EXT4_SB(sb)->s_bal_lock);
}

/**
 * ffs:返回fisrt “1”的位置(低位)
 * fls:返回last “1”的位置(高位)
 */
static void ext4_mb_mark_free_simple(struct super_block *sb,
				void *buddy, ext4_grpblk_t first, ext4_grpblk_t len,
					struct ext4_group_info *grp)
{
	struct ext4_sb_info *sbi = EXT4_SB(sb);
	ext4_grpblk_t min;
	ext4_grpblk_t max;
	ext4_grpblk_t chunk;
	unsigned short border;

	BUG_ON(len > EXT4_BLOCKS_PER_GROUP(sb));

	border = 2 << sb->s_blocksize_bits;

	while (len > 0) {
		/* find how many blocks can be covered since this position */
		max = ffs(first | border) - 1;

		/* find how many blocks of power 2 we need to mark */
		min = fls(len) - 1;

		if (max < min)
			min = max;
		chunk = 1 << min;

		/* mark multiblock chunks only */
		grp->bb_counters[min]++;
		if (min > 0)
			mb_clear_bit(first >> min,
				     buddy + sbi->s_mb_offsets[min]); /* 参考ext4_mb_init */
		/* sbi->s_mb_offsets[min] 存放的各个buddy的偏移量
		 * 例如2^1的偏移量为0,个数为4096个(8192= 2 * 4096 = 4 * 2048)
		 * 注：2^0不在buddy中，使用bitmap buffer就行
		 *
		 * first >> min计算在该buddy中的位置
		 * 使用命令查看块设备EXT4状态：cat /proc/fs/ext4/<sda1>/mb_groups |more
		 */
		len -= chunk;
		first += chunk;
	}
}

int ext4_mb_init(struct super_block *sb, int needs_recovery)
{
	struct ext4_sb_info *sbi = EXT4_SB(sb);
	unsigned i, j;
	unsigned offset;
	unsigned max;
	int ret;

	i = (sb->s_blocksize_bits + 2) * sizeof(unsigned short);

	sbi->s_mb_offsets = kmalloc(i, GFP_KERNEL);
	if (sbi->s_mb_offsets == NULL) {
		return -ENOMEM;
	}

	i = (sb->s_blocksize_bits + 2) * sizeof(unsigned int);
	sbi->s_mb_maxs = kmalloc(i, GFP_KERNEL);
	if (sbi->s_mb_maxs == NULL) {
		kfree(sbi->s_mb_maxs);
		return -ENOMEM;
	}

	/* order 0 is regular bitmap */
	sbi->s_mb_maxs[0] = sb->s_blocksize << 3;
	sbi->s_mb_offsets[0] = 0;

	i = 1;
	offset = 0;
	max = sb->s_blocksize << 2;
	/* buddy 偏移量初始化：2^0, 2^1, 2^2 ... 2^(sb->s_blocksize_bits + 1)
	 * 
	 * sb->s_blocksize:1024, sb->s_blocksize_bits:10
	 * sbi->s_mb_offsets[1] = 0, sbi->s_mb_maxs[1] = 4096
	 * sbi->s_mb_offsets[2] = 512, sbi->s_mb_maxs[2] = 2048
	 * sbi->s_mb_offsets[3] = 768, sbi->s_mb_maxs[3] = 1024
	 * sbi->s_mb_offsets[4] = 896, sbi->s_mb_maxs[4] = 512
	 * sbi->s_mb_offsets[5] = 960, sbi->s_mb_maxs[5] = 256
	 * sbi->s_mb_offsets[6] = 992, sbi->s_mb_maxs[6] = 128
	 * sbi->s_mb_offsets[7] = 1008, sbi->s_mb_maxs[7] = 64
	 * sbi->s_mb_offsets[8] = 1016, sbi->s_mb_maxs[8] = 32
	 * sbi->s_mb_offsets[9] = 1020, sbi->s_mb_maxs[9] = 16
	 * sbi->s_mb_offsets[10] = 1022, sbi->s_mb_maxs[10] = 8
	 * sbi->s_mb_offsets[11] = 1023, sbi->s_mb_maxs[11] = 4
	 */
	do {
		sbi->s_mb_offsets[i] = offset;
		sbi->s_mb_maxs[i] = max;
		offset += 1 << (sb->s_blocksize_bits - i);
		max = max >> 1;
		i++;
	} while (i <= sb->s_blocksize_bits + 1);

	/* init file for buddy data */
	ret = ext4_mb_init_backend(sb);
	if (ret != 0) {
		kfree(sbi->s_mb_offsets);
		kfree(sbi->s_mb_maxs);
		return ret;
	}

	spin_lock_init(&sbi->s_md_lock);
	spin_lock_init(&sbi->s_bal_lock);

	sbi->s_mb_max_to_scan = MB_DEFAULT_MAX_TO_SCAN;
	sbi->s_mb_min_to_scan = MB_DEFAULT_MIN_TO_SCAN;
	sbi->s_mb_stats = MB_DEFAULT_STATS;
	sbi->s_mb_stream_request = MB_DEFAULT_STREAM_THRESHOLD;
	sbi->s_mb_order2_reqs = MB_DEFAULT_ORDER2_REQS;
	sbi->s_mb_history_filter = EXT4_MB_HISTORY_DEFAULT;
	sbi->s_mb_group_prealloc = MB_DEFAULT_GROUP_PREALLOC;

	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
	if (sbi->s_locality_groups == NULL) {
		kfree(sbi->s_mb_offsets);
		kfree(sbi->s_mb_maxs);
		return -ENOMEM;
	}
	for_each_possible_cpu(i) {
		struct ext4_locality_group *lg;
		lg = per_cpu_ptr(sbi->s_locality_groups, i);
		mutex_init(&lg->lg_mutex);
		for (j = 0; j < PREALLOC_TB_SIZE; j++)
			INIT_LIST_HEAD(&lg->lg_prealloc_list[j]);
		spin_lock_init(&lg->lg_prealloc_lock);
	}

	ext4_mb_init_per_dev_proc(sb);
	ext4_mb_history_init(sb);

	if (sbi->s_journal)
		sbi->s_journal->j_commit_callback = release_blocks_on_commit;

	printk(KERN_INFO "EXT4-fs: mballoc enabled\n");
	return 0;
}

/*
 * Main entry point into mballoc to allocate blocks
 * it tries to use preallocation first, then falls back
 * to usual allocation
 */
ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
				 struct ext4_allocation_request *ar, int *errp)
{
	int freed;
	struct ext4_allocation_context *ac = NULL;
	struct ext4_sb_info *sbi;
	struct super_block *sb;
	ext4_fsblk_t block = 0;
	unsigned int inquota;
	unsigned int reserv_blks = 0;

	sb = ar->inode->i_sb;
	sbi = EXT4_SB(sb);

	printk( "dev %s flags %u len %u ino %lu "
		   "lblk %llu goal %llu lleft %llu lright %llu "
		   "pleft %llu pright %llu ",
		   sb->s_id, ar->flags, ar->len,
		   ar->inode ? ar->inode->i_ino : 0,
		   (unsigned long long) ar->logical,
		   (unsigned long long) ar->goal,  /* 预测的目标block */
		   (unsigned long long) ar->lleft,
		   (unsigned long long) ar->lright,
		   (unsigned long long) ar->pleft,
		   (unsigned long long) ar->pright);

	/* 当mount -o nodelalloc 时，i_delalloc_reserved_flag为false */
	if (!EXT4_I(ar->inode)->i_delalloc_reserved_flag) {
		/*
		 * With delalloc we already reserved the blocks
		 */
		while (ar->len && ext4_claim_free_blocks(sbi, ar->len)) {
			/* let others to free the space */
			yield();
			ar->len = ar->len >> 1;
		}
		if (!ar->len) {
			*errp = -ENOSPC;
			return 0;
		}
		reserv_blks = ar->len;
	}
	while (ar->len && DQUOT_ALLOC_BLOCK(ar->inode, ar->len)) {
		ar->flags |= EXT4_MB_HINT_NOPREALLOC;
		ar->len--;
	}
	if (ar->len == 0) {
		*errp = -EDQUOT;
		goto out3;
	}
	inquota = ar->len;

	if (EXT4_I(ar->inode)->i_delalloc_reserved_flag)
		ar->flags |= EXT4_MB_DELALLOC_RESERVED;

	ac = kmem_cache_alloc(ext4_ac_cachep, GFP_NOFS);
	if (!ac) {
		ar->len = 0;
		*errp = -ENOMEM;
		goto out1;
	}
	/* 初始化ac的orgin & goal ext4_free_extent */
	*errp = ext4_mb_initialize_context(ac, ar);
	if (*errp) {
		ar->len = 0;
		goto out2;
	}

	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
	if (!ext4_mb_use_preallocated(ac)) {
		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
		ext4_mb_normalize_request(ac, ar);
repeat:
		/* allocate space in core */
		ext4_mb_regular_allocator(ac); /* 实际的去分配空间 */

		/* as we've just preallocated more space than
		 * user requested orinally, we store allocated
		 * space in a special descriptor */
		if (ac->ac_status == AC_STATUS_FOUND &&
				ac->ac_o_ex.fe_len < ac->ac_b_ex.fe_len)
			ext4_mb_new_preallocation(ac);
	}
	if (likely(ac->ac_status == AC_STATUS_FOUND)) {
		*errp = ext4_mb_mark_diskspace_used(ac, handle, reserv_blks);
		if (*errp ==  -EAGAIN) {
			/*
			 * drop the reference that we took
			 * in ext4_mb_use_best_found
			 */
			ext4_mb_release_context(ac);
			ac->ac_b_ex.fe_group = 0;
			ac->ac_b_ex.fe_start = 0;
			ac->ac_b_ex.fe_len = 0;
			ac->ac_status = AC_STATUS_CONTINUE;
			goto repeat;
		} else if (*errp) {
			ac->ac_b_ex.fe_len = 0;
			ar->len = 0;
			ext4_mb_show_ac(ac);
		} else {
			block = ext4_grp_offs_to_block(sb, &ac->ac_b_ex);
			ar->len = ac->ac_b_ex.fe_len;
		}
	} else {
		freed  = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
		if (freed)
			goto repeat;
		*errp = -ENOSPC;
		ac->ac_b_ex.fe_len = 0;
		ar->len = 0;
		ext4_mb_show_ac(ac);
	}

	ext4_mb_release_context(ac);

out2:
	kmem_cache_free(ext4_ac_cachep, ac);
out1:
	if (ar->len < inquota)
		DQUOT_FREE_BLOCK(ar->inode, inquota - ar->len);
out3:
	if (!ar->len) {
		if (!EXT4_I(ar->inode)->i_delalloc_reserved_flag)
			/* release all the reserved blocks if non delalloc */
			percpu_counter_sub(&sbi->s_dirtyblocks_counter,
						reserv_blks);
	}

	trace_mark(ext4_allocate_blocks,
		   "dev %s block %llu flags %u len %u ino %lu "
		   "logical %llu goal %llu lleft %llu lright %llu "
		   "pleft %llu pright %llu ",
		   sb->s_id, (unsigned long long) block,
		   ar->flags, ar->len, ar->inode ? ar->inode->i_ino : 0,
		   (unsigned long long) ar->logical,
		   (unsigned long long) ar->goal,
		   (unsigned long long) ar->lleft,
		   (unsigned long long) ar->lright,
		   (unsigned long long) ar->pleft,
		   (unsigned long long) ar->pright);

	return block;
}

static noinline_for_stack int
ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
{
	ext4_group_t group;
	ext4_group_t i;
	int cr;
	int err = 0;
	int bsbits;
	struct ext4_sb_info *sbi;
	struct super_block *sb;
	struct ext4_buddy e4b;
	loff_t size, isize;

	sb = ac->ac_sb;
	sbi = EXT4_SB(sb);
	BUG_ON(ac->ac_status == AC_STATUS_FOUND);

	/* first, try the goal */
	err = ext4_mb_find_by_goal(ac, &e4b); 
	if (err || ac->ac_status == AC_STATUS_FOUND) {
		printk("ext4_mb_find_by_goal\n");
		goto out;
	}	

	if (unlikely(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
		goto out;

	/*
	 * ac->ac2_order is set only if the fe_len is a power of 2
	 * if ac2_order is set we also set criteria to 0 so that we
	 * try exact allocation using buddy.
	 */
	i = fls(ac->ac_g_ex.fe_len);
	ac->ac_2order = 0;
	/*
	 * We search using buddy data only if the order of the request
	 * is greater than equal to the sbi_s_mb_order2_reqs
	 * You can tune it via /proc/fs/ext4/<partition>/order2_req
	 */
	if (i >= sbi->s_mb_order2_reqs) {
		/*
		 * This should tell if fe_len is exactly power of 2
		 */
		if ((ac->ac_g_ex.fe_len & (~(1 << (i - 1)))) == 0)
			ac->ac_2order = i - 1;
	}

	bsbits = ac->ac_sb->s_blocksize_bits;
	/* if stream allocation is enabled, use global goal */
	size = ac->ac_o_ex.fe_logical + ac->ac_o_ex.fe_len;
	isize = i_size_read(ac->ac_inode) >> bsbits;
	if (size < isize)
		size = isize;

	if (size < sbi->s_mb_stream_request &&
			(ac->ac_flags & EXT4_MB_HINT_DATA)) {
		/* TBD: may be hot point */
		spin_lock(&sbi->s_md_lock);
		ac->ac_g_ex.fe_group = sbi->s_mb_last_group;
		ac->ac_g_ex.fe_start = sbi->s_mb_last_start;
		spin_unlock(&sbi->s_md_lock);
	}
	/* Let's just scan groups to find more-less suitable blocks */
	cr = ac->ac_2order ? 0 : 1;
	/*
	 * cr == 0 try to get exact allocation,
	 * cr == 3  try to get anything
	 */
repeat:
	for (; cr < 4 && ac->ac_status == AC_STATUS_CONTINUE; cr++) {
		ac->ac_criteria = cr;
		/*
		 * searching for the right group start
		 * from the goal value specified
		 */
		group = ac->ac_g_ex.fe_group;

		for (i = 0; i < EXT4_SB(sb)->s_groups_count; group++, i++) {
			struct ext4_group_info *grp;
			struct ext4_group_desc *desc;

			if (group == EXT4_SB(sb)->s_groups_count)
				group = 0;

			/* quick check to skip empty groups */
			grp = ext4_get_group_info(sb, group);
			if (grp->bb_free == 0)
				continue;

			/*
			 * if the group is already init we check whether it is
			 * a good group and if not we don't load the buddy
			 */
			if (EXT4_MB_GRP_NEED_INIT(grp)) {
				/*
				 * we need full data about the group
				 * to make a good selection
				 */
				err = ext4_mb_init_group(sb, group); 
				/* 初始化块组的buddy cache(block bitmap & buddy bitmap)*/
				if (err)
					goto out;
			}

			/*
			 * If the particular group doesn't satisfy our
			 * criteria we continue with the next group
			 */
			if (!ext4_mb_good_group(ac, group, cr))
				continue;
			/* 将buddy cache 赋值为struct ext4_buddy e4b */
			err = ext4_mb_load_buddy(sb, group, &e4b);
			if (err)
				goto out;

			ext4_lock_group(sb, group);
			if (!ext4_mb_good_group(ac, group, cr)) {
				/* someone did allocation from this group */
				ext4_unlock_group(sb, group);
				ext4_mb_release_desc(&e4b);
				continue;
			}

			ac->ac_groups_scanned++;
			desc = ext4_get_group_desc(sb, group, NULL);
			if (cr == 0 || (desc->bg_flags &
					cpu_to_le16(EXT4_BG_BLOCK_UNINIT) &&
					ac->ac_2order != 0))
				ext4_mb_simple_scan_group(ac, &e4b);
			else if (cr == 1 &&
					ac->ac_g_ex.fe_len == sbi->s_stripe)
				ext4_mb_scan_aligned(ac, &e4b);
			else
				ext4_mb_complex_scan_group(ac, &e4b);

			ext4_unlock_group(sb, group);
			ext4_mb_release_desc(&e4b);

			if (ac->ac_status != AC_STATUS_CONTINUE)
				break;
		}
	}

	if (ac->ac_b_ex.fe_len > 0 && ac->ac_status != AC_STATUS_FOUND &&
	    !(ac->ac_flags & EXT4_MB_HINT_FIRST)) {
		/*
		 * We've been searching too long. Let's try to allocate
		 * the best chunk we've found so far
		 */

		ext4_mb_try_best_found(ac, &e4b);
		if (ac->ac_status != AC_STATUS_FOUND) {
			/*
			 * Someone more lucky has already allocated it.
			 * The only thing we can do is just take first
			 * found block(s)
			printk(KERN_DEBUG "EXT4-fs: someone won our chunk\n");
			 */
			ac->ac_b_ex.fe_group = 0;
			ac->ac_b_ex.fe_start = 0;
			ac->ac_b_ex.fe_len = 0;
			ac->ac_status = AC_STATUS_CONTINUE;
			ac->ac_flags |= EXT4_MB_HINT_FIRST;
			cr = 3;
			atomic_inc(&sbi->s_mb_lost_chunks);
			goto repeat;
		}
	}
out:
	return err;
}
