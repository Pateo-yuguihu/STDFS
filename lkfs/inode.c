#include <linux/time.h>
#include <linux/highuid.h>
#include <linux/pagemap.h>
#include <linux/quotaops.h>
#include <linux/module.h>
#include <linux/writeback.h>
#include <linux/buffer_head.h>
#include <linux/mpage.h>
#include <linux/fiemap.h>
#include <linux/namei.h>
#include <asm-generic/bitops/le.h>
#include "lkfs.h"

static int lkfs_new_blocks(struct inode *inode)
{
	int block_no = 0;
	struct super_block *sb = inode->i_sb;
	struct lkfs_super_block *es = LKFS_SB(sb)->s_es;
	struct lkfs_sb_info * sbi = LKFS_SB(sb);
	int i = 0;
	
	for (i = 0; i < es->s_block_bitmap_count; i++) {
		block_no = generic_find_next_zero_le_bit((unsigned long *)sbi->s_sbb[i]->b_data, LKFS_BLOCKS_PER_BITMAP, 0);
		if(block_no != LKFS_BLOCKS_PER_BITMAP)
			break;
	}

	if ((i * LKFS_BLOCKS_PER_BITMAP + block_no) > es->s_blocks_count)  {
		lkfs_debug("can't find free blocks\n");
		return 0;
		
	} /* else
		lkfs_debug("find free block number:%d\n", block_no + i * LKFS_BLOCKS_PER_BITMAP); */
	
	generic___test_and_set_le_bit(block_no, (unsigned long *)sbi->s_sbb[i]->b_data);
	es->s_free_blocks_count--;
	mark_buffer_dirty(LKFS_SB(sb)->s_sbh);
	//sync_dirty_buffer(LKFS_SB(sb)->s_sbh); /* sync super block */

	mark_buffer_dirty(LKFS_SB(sb)->s_sbb[i]);
	//sync_dirty_buffer(LKFS_SB(sb)->s_sbb[i]); /* sync super block */

	/* LKFS_I(inode)->i_data[iblock] = block_no + LKFS_BLOCKS_PER_BITMAP * i; */
	
	return block_no + LKFS_BLOCKS_PER_BITMAP * i;
}

static int lkfs_new_ind_blocks(struct inode *inode, struct buffer_head *bh, sector_t iblock)
{
	int block_no = 0;
	struct super_block *sb = inode->i_sb;
	struct lkfs_super_block *es = LKFS_SB(sb)->s_es;
	struct lkfs_sb_info * sbi = LKFS_SB(sb);
	int i = 0;
	
	for (i = 0; i < es->s_block_bitmap_count; i++) {
		block_no = generic_find_next_zero_le_bit((unsigned long *)sbi->s_sbb[i]->b_data, LKFS_BLOCKS_PER_BITMAP, 0);
		if(block_no != LKFS_BLOCKS_PER_BITMAP)
			break;
	}

	if ((i * LKFS_BLOCKS_PER_BITMAP + block_no) > es->s_blocks_count)  {
		lkfs_debug("can't find free blocks\n");
		return 0;
		
	} /* else
		lkfs_debug("find free ind block number:%d\n", block_no + i * LKFS_BLOCKS_PER_BITMAP); */
	
	generic___test_and_set_le_bit(block_no, (unsigned long *)sbi->s_sbb[i]->b_data);
	es->s_free_blocks_count--;
	mark_buffer_dirty(LKFS_SB(sb)->s_sbh);
	//sync_dirty_buffer(LKFS_SB(sb)->s_sbh); /* sync super block */

	mark_buffer_dirty(LKFS_SB(sb)->s_sbb[i]);
	//sync_dirty_buffer(LKFS_SB(sb)->s_sbb[i]); /* sync super block */

	*(int *)(bh->b_data + (iblock << 2)) = block_no + LKFS_BLOCKS_PER_BITMAP * i;
	mark_buffer_dirty(bh);
	//sync_dirty_buffer(bh);
	
	return block_no + LKFS_BLOCKS_PER_BITMAP * i;
}

static int lkfs_get_blocks(struct inode *inode,
			   sector_t iblock, unsigned long maxblocks,
			   struct buffer_head *bh_result,
			   int create)
{
	int offsets[3] = {0}, n = 0;
	int new_block = 0, indblock = 0, dindblock = 0, find_block;
	struct buffer_head *bh, *dind_bh;
	struct lkfs_inode_info *lkfs_inode = LKFS_I(inode);

	if (iblock < 0) {
		lkfs_debug("warning:block < 0");
	} else if (iblock < LKFS_NDIR_BLOCKS) {
		offsets[n++] = iblock;

		if (lkfs_inode->i_data[iblock] != 0)
			map_bh(bh_result, inode->i_sb, lkfs_inode->i_data[iblock]);
		else {
			new_block = lkfs_new_blocks(inode);
			if (!new_block) {
				lkfs_debug("can't get a new block\n");
				return -1;
			}
			lkfs_inode->i_data[iblock] = new_block;
			map_bh(bh_result, inode->i_sb, lkfs_inode->i_data[iblock]);
		}

	} else if ( (iblock -= LKFS_NDIR_BLOCKS) < 256) { /* 256 = 1024 / 4 */
		offsets[n++] = LKFS_IND_BLOCK;
		offsets[n++] = iblock;
		
		if (lkfs_inode->i_data[LKFS_IND_BLOCK] != 0) {
			bh = sb_bread(inode->i_sb, lkfs_inode->i_data[LKFS_IND_BLOCK]);
			indblock = *(int *)(bh->b_data + (iblock << 2));
			
			if (indblock != 0) {
				map_bh(bh_result, inode->i_sb, indblock);
			} else {
				find_block = lkfs_new_ind_blocks(inode, bh, offsets[1]);
				map_bh(bh_result, inode->i_sb, find_block);
			}	
		} else {
			new_block = lkfs_new_blocks(inode);
			lkfs_inode->i_data[LKFS_IND_BLOCK] = new_block;
			bh = sb_bread(inode->i_sb, lkfs_inode->i_data[LKFS_IND_BLOCK]);
			memset(bh->b_data, 0, inode->i_sb->s_blocksize);
			find_block = lkfs_new_ind_blocks(inode, bh, offsets[1]);
			map_bh(bh_result, inode->i_sb, find_block);
		}
		
	} else if ((iblock -= 256) < 65536) { /* 256 ^2 */
		offsets[n++] = LKFS_DIND_BLOCK;
		offsets[n++] = iblock >> 8;
		offsets[n++] = iblock & 0xff;

		if (lkfs_inode->i_data[LKFS_DIND_BLOCK] != 0) {
			bh = sb_bread(inode->i_sb, lkfs_inode->i_data[LKFS_DIND_BLOCK]);
			indblock = *(int *)(bh->b_data + (offsets[1] << 2));
			if (indblock != 0) {
				dind_bh = sb_bread(inode->i_sb, indblock);
				
				dindblock = *(sector_t *)(dind_bh->b_data + (offsets[2] << 2));
				if (dindblock != 0) {
					map_bh(bh_result, inode->i_sb, dindblock);
				} else {
					/*                                                                new_block          indblock
					lkfs_inode->i_data[LKFS_DIND_BLOCK]  --> |--------|        |--------|        ***data block
				                                                                	  |              | --> |              |        {    }
				                                                                	  | indblock |        | dinblock  | --> {    }
				                                                                   	        ...                  ...
				                                                               	  |              |        |              |        {    }
				                                                                	  ----------         ---------
					NOTE: *** is block which need create
					*/
					find_block = lkfs_new_ind_blocks(inode, dind_bh, offsets[2]);
					map_bh(bh_result, inode->i_sb, find_block);
				}	
					
			} else {
				/*                                                                new_block         ***indblock
				lkfs_inode->i_data[LKFS_DIND_BLOCK]  --> |--------|        |--------|        ***data block
				                                                                 |              | --> |              |        {    }
				                                                                 | indblock |        | dinblock  | --> {    }
				                                                                        ...                  ...
				                                                                 |              |        |              |        {    }
				                                                                 ----------         ---------
				NOTE: *** is block which need create
				*/

				indblock = lkfs_new_ind_blocks(inode, bh, offsets[1]);
				dind_bh = sb_bread(inode->i_sb, indblock);
				memset(dind_bh->b_data, 0, inode->i_sb->s_blocksize);
				dindblock = lkfs_new_ind_blocks(inode, dind_bh, offsets[2]);

				map_bh(bh_result, inode->i_sb, dindblock);
			}	
			
		} else {
			/*                                                                     ***new_block    ***indblock
				lkfs_inode->i_data[LKFS_DIND_BLOCK]  --> |--------|        |--------|     ***data block
				                                                                 |              | --> |              |        {    }
				                                                                 | indblock |        | dinblock  | --> {    }
				                                                                        ...                  ...
				                                                                 |              |        |              |        {    }
				                                                                 ----------         ---------
			NOTE: *** is block which need create
			*/
			new_block = lkfs_new_blocks(inode);
			lkfs_inode->i_data[LKFS_DIND_BLOCK] = new_block;

			bh = sb_bread(inode->i_sb, new_block);
			memset(bh->b_data, 0, inode->i_sb->s_blocksize);
			indblock = lkfs_new_ind_blocks(inode, bh, offsets[1]);

			dind_bh = sb_bread(inode->i_sb, indblock);
			memset(dind_bh->b_data, 0, inode->i_sb->s_blocksize);
			dindblock = lkfs_new_ind_blocks(inode, dind_bh, offsets[2]);
			
			map_bh(bh_result, inode->i_sb, dindblock);
		}
	} else {
		lkfs_debug("block is too big\n");
	}

	if (!bh)
		brelse(bh);

	if(!dind_bh)
		brelse(dind_bh);
	
	return 1;
}

int lkfs_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create)
{
	unsigned max_blocks = bh_result->b_size >> inode->i_blkbits;
	int ret = lkfs_get_blocks(inode, iblock, max_blocks,
			      bh_result, create);
	if (ret > 0) {
		bh_result->b_size = (ret << inode->i_blkbits);
		ret = 0;
	}
	return ret;
}

static int lkfs_readpage(struct file *file, struct page *page)
{
	return mpage_readpage(page, lkfs_get_block);
}

static int
lkfs_readpages(struct file *file, struct address_space *mapping,
		struct list_head *pages, unsigned nr_pages)
{
	return mpage_readpages(mapping, pages, nr_pages, lkfs_get_block);
}

static int lkfs_writepage(struct page *page, struct writeback_control *wbc)
{
	return block_write_full_page(page, lkfs_get_block, wbc);
}

static int lkfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
{
	return mpage_writepages(mapping, wbc, lkfs_get_block);
}

static int lkfs_write_end(struct file *file, struct address_space *mapping,
			loff_t pos, unsigned len, unsigned copied,
			struct page *page, void *fsdata)
{
	int ret;

	ret = generic_write_end(file, mapping, pos, len, copied, page, fsdata);
	return ret;
}

static sector_t lkfs_bmap(struct address_space *mapping, sector_t block)
{
	return generic_block_bmap(mapping, block, lkfs_get_block);
}

int lkfs_setattr(struct dentry *dentry, struct iattr *iattr)
{
	struct inode *inode = dentry->d_inode;
	int error;

	error = inode_change_ok(inode, iattr);
	if (error)
		return error;

	generic_setattr(inode, iattr);
	mark_inode_dirty(inode);
	error = lkfs_sync_inode(inode);
	return error;
}

static int
lkfs_write_begin(struct file *file, struct address_space *mapping,
		loff_t pos, unsigned len, unsigned flags,
		struct page **pagep, void **fsdata)
{
	int ret;
	*pagep = NULL;
	ret = __lkfs_write_begin(file, mapping, pos, len, flags, pagep, fsdata);
	return ret;
}

const struct address_space_operations lkfs_aops = {
	.readpage		= lkfs_readpage,
	.readpages		= lkfs_readpages,
	.writepage		= lkfs_writepage,
	.sync_page		= block_sync_page,
	.write_begin	= lkfs_write_begin,
	.write_end		= lkfs_write_end,
	.bmap			= lkfs_bmap,
/*	.direct_IO		= ext2_direct_IO,*/
	.writepages		= lkfs_writepages,
	.migratepage		= buffer_migrate_page,
	.is_partially_uptodate	= block_is_partially_uptodate,
	.error_remove_page	= generic_error_remove_page,
};

int lkfs_sync_inode(struct inode *inode)
{
	struct writeback_control wbc = {
		.sync_mode = WB_SYNC_ALL,
		.nr_to_write = 0,	/* sys_fsync did this */
	};
	return sync_inode(inode, &wbc);
}

static struct lkfs_inode *lkfs_get_inode(struct super_block *sb, ino_t ino,
					struct buffer_head **p)
{
	struct buffer_head * bh;
	unsigned long block;
	unsigned long offset;
	struct lkfs_sb_info *sbi = LKFS_SB(sb);

	block = ((ino - 1) >> LKFS_INODE_PER_SB_BIT) + sbi->inode_table_offset;
	offset = ((ino - 1) % LKFS_INODE_PER_SB) * LKFS_INODE_SIZE;
	lkfs_debug("block: %ld, offset:%ld\n", block, offset);
	if (!(bh = sb_bread(sb, block)))
		goto Eio;

	*p = bh;
	return (struct lkfs_inode *) (bh->b_data + offset);

	lkfs_debug("bad inode number: %lu", (unsigned long) ino);
	return ERR_PTR(-EINVAL);
Eio:
	lkfs_debug("unable to read inode block - inode=%lu, block=%lu",
		   (unsigned long) ino, block);

	return ERR_PTR(-EIO);
}

static int __lkfs_write_inode(struct inode *inode, int do_sync)
{
	struct lkfs_inode_info *ei = LKFS_I(inode);
	struct super_block *sb = inode->i_sb;
	ino_t ino = inode->i_ino;

	struct buffer_head * bh;
	struct lkfs_inode * raw_inode = lkfs_get_inode(sb, ino, &bh);
	int n;
	int err = 0;

	if (IS_ERR(raw_inode))
 		return -EIO;

	/* For fields not not tracking in the in-memory inode,
	 * initialise them to zero for new inodes. */
	if (ei->i_state & LKFS_STATE_NEW)
		memset(raw_inode, 0, 128);

	raw_inode->i_mode = cpu_to_le16(inode->i_mode);

	raw_inode->i_uid = cpu_to_le16(inode->i_uid);
	raw_inode->i_gid = cpu_to_le16(inode->i_gid);

	raw_inode->i_links_count = cpu_to_le16(inode->i_nlink);
	raw_inode->i_size = cpu_to_le32(inode->i_size);
	raw_inode->i_atime = cpu_to_le32(inode->i_atime.tv_sec);
	raw_inode->i_ctime = cpu_to_le32(inode->i_ctime.tv_sec);
	raw_inode->i_mtime = cpu_to_le32(inode->i_mtime.tv_sec);

	raw_inode->i_blocks = (cpu_to_le32(inode->i_size) + 511) >> 9;
	inode->i_blocks = (cpu_to_le32(inode->i_size) + 511) >> 9;

	for (n = 0; n < LKFS_N_BLOCKS; n++)
		raw_inode->i_block[n] = ei->i_data[n];
	mark_buffer_dirty(bh);
	
	//sync_dirty_buffer(bh);
	/* lkfs_debug("sync dirty buffer\n"); */
	if (buffer_req(bh) && !buffer_uptodate(bh)) {
		lkfs_debug("IO error syncing lkfs inode [%s:%08lx]\n",
			sb->s_id, (unsigned long) ino);
		err = -EIO;
	}

	ei->i_state  = 0;
	brelse (bh);
	return err;
}

int lkfs_write_inode(struct inode *inode, struct writeback_control *wbc)
{
	return __lkfs_write_inode(inode, wbc->sync_mode == WB_SYNC_ALL);
}

struct inode *lkfs_iget (struct super_block *sb, unsigned long ino)
{
	struct lkfs_inode_info *ei;
	struct buffer_head * bh;
	struct lkfs_inode *raw_inode;
	struct inode *inode;
	long ret = -EIO;
	int n;

	inode = iget_locked(sb, ino);
	if (!inode)
		return ERR_PTR(-ENOMEM);
	if (!(inode->i_state & I_NEW))
		return inode;

	ei = LKFS_I(inode);

	raw_inode = lkfs_get_inode(inode->i_sb, ino, &bh);
	if (IS_ERR(raw_inode)) {
		ret = PTR_ERR(raw_inode);
 		goto bad_inode;
	}
	inode->i_mode = le16_to_cpu(raw_inode->i_mode);
	inode->i_uid = (uid_t)le16_to_cpu(raw_inode->i_uid);
	inode->i_gid = (gid_t)le16_to_cpu(raw_inode->i_gid);

	inode->i_nlink = le16_to_cpu(raw_inode->i_links_count);
	inode->i_size = le32_to_cpu(raw_inode->i_size);
	inode->i_atime.tv_sec = (signed)le32_to_cpu(raw_inode->i_atime);
	inode->i_ctime.tv_sec = (signed)le32_to_cpu(raw_inode->i_ctime);
	inode->i_mtime.tv_sec = (signed)le32_to_cpu(raw_inode->i_mtime);
	inode->i_atime.tv_nsec = inode->i_mtime.tv_nsec = inode->i_ctime.tv_nsec = 0;

	if (inode->i_ino == 2)
		inode->i_blocks = (1024) >> 9;
	else
		inode->i_blocks = (le32_to_cpu(inode->i_size)  + 511) >> 9;

	/*
	 * NOTE! The in-memory inode i_data array is in little-endian order
	 * even on big-endian machines: we do NOT byteswap the block numbers!
	 */
	for (n = 0; n < LKFS_N_BLOCKS; n++)
		ei->i_data[n] = raw_inode->i_block[n];

	if (S_ISREG(inode->i_mode)) {

		inode->i_op = &lkfs_file_inode_operations;
		inode->i_mapping->a_ops = &lkfs_aops;
		inode->i_fop = &lkfs_file_operations;
	} else if (S_ISDIR(inode->i_mode)) {
		inode->i_op = &lkfs_dir_inode_operations;
		inode->i_fop = &lkfs_dir_operations;
		inode->i_mapping->a_ops = &lkfs_aops;
	}
	brelse (bh);
	unlock_new_inode(inode);
	return inode;
	
bad_inode:
	iget_failed(inode);
	return ERR_PTR(ret);
}

void lkfs_free_block(struct inode *inode, int offset, int iblock)
{
	struct super_block *sb = inode->i_sb;
	struct lkfs_super_block *es = LKFS_SB(sb)->s_es;
	int block, nr;
	lkfs_debug("offset:%d, block:%d\n", offset, iblock);

	block = iblock >> 10;
	nr = iblock & (sb->s_blocksize - 1);
	
	test_and_clear_bit(nr, (unsigned long *)LKFS_SB(sb)->s_sbb[block]->b_data);
	es->s_free_blocks_count++;
	mark_buffer_dirty(LKFS_SB(sb)->s_sbh);
	//sync_dirty_buffer(LKFS_SB(sb)->s_sbh); /* sync super block */
	//sync_dirty_buffer(LKFS_SB(sb)->s_sbb[block]); 
	mark_buffer_dirty(LKFS_SB(sb)->s_sbb[block]);
	LKFS_I(inode)->i_data[offset] = 0;
}

static void __lkfs_truncate_blocks(struct inode *inode, loff_t offset)
{
	int nblocks = (inode->i_size + 1023) >> 10;
	int i = 0;

	lkfs_debug("nblocks :%d\n", nblocks);
	for (i = 0; i < nblocks; i++) {
		if (LKFS_I(inode)->i_data[i] != 0)
			lkfs_free_block(inode, i, LKFS_I(inode)->i_data[i]);
		else
			lkfs_debug("lkfs error: block number:%d\n", LKFS_I(inode)->i_data[i]);
	}
}

void lkfs_delete_inode (struct inode * inode)
{
	if (!is_bad_inode(inode))
		dquot_initialize(inode);
	truncate_inode_pages(&inode->i_data, 0);

	if (is_bad_inode(inode))
		goto no_delete;
	/* LKFS_I(inode)->i_dtime	= get_seconds(); */
	mark_inode_dirty(inode);
	__lkfs_write_inode(inode, inode_needs_sync(inode));

	/* inode->i_size = 0; */
	lkfs_debug("iput\n");
	if (inode->i_size)
		__lkfs_truncate_blocks(inode, 0);
	inode->i_size = 0;
	lkfs_free_inode (inode);
	
	return;
no_delete:
	clear_inode(inode);	/* We must guarantee clearing of inode... */
}
