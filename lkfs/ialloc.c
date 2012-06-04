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
	struct buffer_head *bitmap_bh = NULL;
	struct buffer_head *bh2;
	int group, i;
	ino_t ino = 0;
	struct inode * inode;
	struct lkfs_super_block *es;
	struct lkfs_inode_info *ei;
	struct lkfs_sb_info *sbi;
	int err;

	sb = dir->i_sb;
	inode = new_inode(sb);
	if (!inode)
		return ERR_PTR(-ENOMEM);

	ei = LKFS_I(inode);
	sbi = LKFS_SB(sb);
	es = sbi->s_es;

	ino = generic_find_next_zero_le_bit((unsigned long *)es->inodebitmap, 256, dir->i_ino);
	lkfs_debug("find free inode number:%d\n", ino);
	generic___test_and_set_le_bit(ino, (unsigned long *)es->inodebitmap);
	
	mark_buffer_dirty(sbi->s_sbh);
	sync_dirty_buffer(sbi->s_sbh);

	ino += 1;
	sb->s_dirt = 1;
	inode_init_owner(inode, dir, mode);

	inode->i_ino = ino;
	inode->i_blocks = 0;
	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME_SEC;
	memset(ei->i_data, 0, sizeof(ei->i_data));
	es->s_free_inodes_count--;
	mark_inode_dirty(inode);
	return inode;
}

