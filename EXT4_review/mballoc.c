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
