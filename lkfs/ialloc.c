/*
 *  linux/fs/lkfs/ialloc.c
 */

#include <linux/quotaops.h>
#include <linux/sched.h>
#include <linux/backing-dev.h>
#include <linux/buffer_head.h>
#include <linux/random.h>
#include <asm-generic/bitops/le.h>
#include "lkfs.h"

struct inode *lkfs_new_inode(struct inode *dir, int mode)
{
	struct super_block *sb;
	ino_t ino = 0;
	struct inode * inode;
	struct lkfs_super_block *es;
	struct lkfs_inode_info *ei;
	struct lkfs_sb_info *sbi;
	int err;
	int i = 0;
	
	sb = dir->i_sb;
	inode = new_inode(sb);
	if (!inode)
		return ERR_PTR(-ENOMEM);

	ei = LKFS_I(inode);
	sbi = LKFS_SB(sb);
	es = sbi->s_es;
	
	for (i = 0; i < es->s_inode_bitmap_count; i++) {
		ino = find_next_zero_bit((unsigned long *)sbi->s_sib[i]->b_data, LKFS_INODES_PER_BITMAP, 0);
		if (ino != LKFS_INODES_PER_BITMAP) {
			lkfs_debug("i:%d, ino:%ld\n", i, ino);
			break;
		}
	}
	if ((i * LKFS_INODES_PER_BITMAP + ino) >= es->s_inodes_count)
		goto fail_drop;
	
	generic___test_and_set_le_bit(ino, (unsigned long *)sbi->s_sib[i]->b_data);
	
	mark_buffer_dirty(sbi->s_sbh);
	//sync_dirty_buffer(sbi->s_sbh);

	ino = i * LKFS_INODES_PER_BITMAP + ino;
	sb->s_dirt = 1;
	inode_init_owner(inode, dir, mode);

	LKFS_I(inode)->i_state = LKFS_STATE_NEW;
	inode->i_ino = ino;
	inode->i_blocks = 0;
	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
	memset(ei->i_data, 0, sizeof(ei->i_data));
	es->s_free_inodes_count--;

	if (insert_inode_locked(inode) < 0) {
		err = -EINVAL;
		goto fail_drop;
	}
	
	mark_inode_dirty(inode);
	mark_buffer_dirty(sbi->s_sib[i]);
	//sync_dirty_buffer(sbi->s_sib[i]); /* sync inode bitmap buffer */
	return inode;

fail_drop:
	inode->i_flags |= S_NOQUOTA;
	inode->i_nlink = 0;
	unlock_new_inode(inode);
	iput(inode);
	return ERR_PTR(err);

}

void lkfs_free_inode (struct inode * inode)
{
	struct super_block * sb = inode->i_sb;
	unsigned long ino;
	struct lkfs_super_block * es;
	int block, offset;

	ino = inode->i_ino;
	lkfs_debug ("freeing inode %lu\n", ino);

	block = ino >> LKFS_BITS_PER_BLOCKS;
	offset = ino & (LKFS_INODES_PER_BITMAP - 1);

	es = LKFS_SB(sb)->s_es;

	/* Do this BEFORE marking the inode not in use or returning an error */
	clear_inode (inode);

	test_and_clear_bit(offset, (unsigned long *)LKFS_SB(sb)->s_sib[block]->b_data);
	es->s_free_inodes_count++;
	mark_buffer_dirty(LKFS_SB(sb)->s_sbh);
	mark_buffer_dirty(LKFS_SB(sb)->s_sib[block]);
}

