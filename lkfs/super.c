/*
 * linux/fs/lkfs/super.c
 * 
 * Disk struct(V1):
 * blocksize = 1024 maxsize = 1024 * 1024 = 1MiB
 * [boot block 0 ][super block 1][inode table block 2 .. 33][data block 34 .. 1023]
 * 
 * (V2)
 * [boot block0][super block1][blockbitmap n ][inodebitmap n/4] [inodetable bitmap] [data blocks...]
 *
 * blocksize =1024
 * disksize = 64MiB
 * block bitmap count = 64MiB/1024/8/1024= disksize/8M = 8(blocks)
 * inode bitmap count = disksize /32M =2(blocks)
 * inode table block count = 2 * 1024 *128 /1024 = 256(blocks)
 *
 * Copyright (C) 2012 Hu Yugui(yugui.hu@hotmail.com)
 */

#include <linux/module.h>
#include <linux/string.h>
#include <linux/fs.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/blkdev.h>
#include <linux/parser.h>
#include <linux/random.h>
#include <linux/buffer_head.h>
#include <linux/exportfs.h>
#include <linux/vfs.h>
#include <linux/seq_file.h>
#include <linux/mount.h>
#include <linux/log2.h>
#include <linux/quotaops.h>
#include <asm/uaccess.h>
#include "lkfs.h"

static void init_once(void *foo)
{
	struct lkfs_inode_info *ei = (struct lkfs_inode_info *) foo;
	inode_init_once(&ei->vfs_inode);
}

static struct kmem_cache * lkfs_inode_cachep;
static int init_inodecache(void)
{
	lkfs_inode_cachep = kmem_cache_create("lkfs_inode_cache",
					     sizeof(struct lkfs_inode_info),
					     0, (SLAB_RECLAIM_ACCOUNT|
						SLAB_MEM_SPREAD),
					     init_once);
	if (lkfs_inode_cachep == NULL)
		return -ENOMEM;
	return 0;
}

static void destroy_inodecache(void)
{
	kmem_cache_destroy(lkfs_inode_cachep);
}

static struct inode *lkfs_alloc_inode(struct super_block *sb)
{
	struct lkfs_inode_info *ei;
	ei = (struct lkfs_inode_info *)kmem_cache_alloc(lkfs_inode_cachep, GFP_KERNEL);
	if (!ei)
		return NULL;
	ei->vfs_inode.i_version = 1;
	return &ei->vfs_inode;
}

static void lkfs_destroy_inode(struct inode *inode)
{
	kmem_cache_free(lkfs_inode_cachep, LKFS_I(inode));
}

static int lkfs_statfs (struct dentry * dentry, struct kstatfs * buf)
{
	struct super_block *sb = dentry->d_sb;
	struct lkfs_sb_info *sbi = LKFS_SB(sb);
	struct lkfs_super_block *es = sbi->s_es;

	buf->f_type = LKFS_SUPER_MAGIC;
	buf->f_bsize = sb->s_blocksize;
	buf->f_blocks = le32_to_cpu(es->s_blocks_count);
	buf->f_bfree = le32_to_cpu(es->s_free_blocks_count);
	buf->f_bavail = buf->f_bfree;

	buf->f_files = le32_to_cpu(es->s_inodes_count);
	buf->f_ffree = le32_to_cpu(es->s_free_inodes_count );
	buf->f_namelen = LKFS_NAME_LEN;

	return 0;
}

static void lkfs_sync_super(struct super_block *sb, int wait)
{
	mark_buffer_dirty(LKFS_SB(sb)->s_sbh);
	if (wait)
		sync_dirty_buffer(LKFS_SB(sb)->s_sbh); /* update superblock */
	sb->s_dirt = 0;
}

void lkfs_write_super(struct super_block *sb)
{
	lkfs_sync_super(sb, 1);
}

static void lkfs_put_super (struct super_block * sb)
{
	struct lkfs_sb_info *sbi = LKFS_SB(sb);

	if (sb->s_dirt)
		lkfs_write_super(sb);

	if (!(sb->s_flags & MS_RDONLY)) {
		lkfs_sync_super(sb, 1);
	}

	brelse (sbi->s_sbh);
	sb->s_fs_info = NULL;
	kfree(sbi);
	lkfs_debug("umount lkfs\n");
}

static const struct super_operations lkfs_sops = {
	.alloc_inode	= lkfs_alloc_inode,
	.destroy_inode	= lkfs_destroy_inode,
	.delete_inode   = lkfs_delete_inode,
	.write_inode	= lkfs_write_inode,
	.put_super		= lkfs_put_super,
	.write_super	= lkfs_write_super,
/*	.sync_fs	= lkfs_sync_fs,*/
	.statfs		= lkfs_statfs,
	/*.remount_fs	= lkfs_remount,*/
};

static int lkfs_fill_super(struct super_block *sb, void *data, int silent)
{
	struct buffer_head * bh;
	struct lkfs_sb_info * sbi;
	struct lkfs_super_block * es;
	struct inode *root;
	unsigned long offset = 0;
	long ret = -EINVAL;
	int blocksize = BLOCK_SIZE;
	int i = 0;

	sbi = kzalloc(sizeof(struct lkfs_sb_info), GFP_KERNEL);
	if (!sbi)
		return -ENOMEM;

	sb->s_fs_info = sbi;

	blocksize = sb_min_blocksize(sb, BLOCK_SIZE);
	if (!blocksize) {
		lkfs_debug("error: unable to set blocksize\n");
		goto failed_sbi;
	}

	if (!(bh = sb_bread(sb, 1))) {
		lkfs_debug("error: unable to read superblock\n");
		goto failed_sbi;
	}
	sbi->s_sbh = bh; /* super block buffer head in memory */
	es = (struct lkfs_super_block *) (((char *)bh->b_data) + offset);
	sbi->s_es = es;
	sb->s_magic = le16_to_cpu(es->s_magic);
	lkfs_debug("lkfs id: %s\n", es->s_volume_name);
	if (sb->s_magic != LKFS_SUPER_MAGIC)
		goto cantfind_lkfs;

	
	sbi->s_inode_size = le16_to_cpu(es->s_inode_size);
	sb->s_maxbytes = es->s_free_blocks_count << BLOCK_SIZE_BITS;

	if (sb->s_blocksize != bh->b_size) {
			lkfs_debug("error: unsupported blocksize\n");
		goto failed_mount;
	} else
		lkfs_debug("block size:%ld\n", sb->s_blocksize);

	sbi->block_bitmap_offset = 2; /* bootblock + superblock */
	sbi->inode_bitmap_offset = sbi->block_bitmap_offset + es->s_block_bitmap_count;
	sbi->inode_table_offset = sbi->inode_bitmap_offset + es->s_inode_bitmap_count;

	lkfs_debug("bb_off: %d, ib_off: %d, it_off: %d\n",
		sbi->block_bitmap_offset,
		sbi->inode_bitmap_offset,
		sbi->inode_table_offset);
	
	sbi->s_sbb = kzalloc(es->s_block_bitmap_count * sizeof(struct buffer_head *), GFP_KERNEL);
	/*get block bitmap */
	for (i = 0; i < es->s_block_bitmap_count; i++) {
		if(!(sbi->s_sbb[i] = sb_bread(sb, sbi->block_bitmap_offset + i))) {
			lkfs_debug("Can not get block bitmap\n");
			goto failed_mount;
		}
	}	

	sbi->s_sib = kzalloc(es->s_inode_bitmap_count * sizeof(struct buffer_head *), GFP_KERNEL);
	/*get inode bitmap */
	for (i = 0; i < es->s_block_bitmap_count; i++) {
		if(!(sbi->s_sib[i] = sb_bread(sb, sbi->inode_bitmap_offset + i))) {
			lkfs_debug("Can not get inode bitmap\n");
			goto failed_mount;
		}
	}
	
	sb->s_op = &lkfs_sops;

	root = lkfs_iget(sb, LKFS_ROOT_INO);
	if (IS_ERR(root)) {
		ret = PTR_ERR(root);
		goto failed_mount;
	}
	if (!S_ISDIR(root->i_mode) || !root->i_blocks || !root->i_size) {
		iput(root);
		lkfs_debug("error: corrupt root inode, run lkfsck\n");
		goto failed_mount;
	}

	sb->s_root = d_alloc_root(root);
	if (!sb->s_root) {
		iput(root);
		lkfs_debug("error: get root inode failed\n");
		ret = -ENOMEM;
		goto failed_mount;
	}
	return 0;

cantfind_lkfs:
	lkfs_debug("error: can't find an lkfs filesystem on dev %s.\n", sb->s_id);
	goto failed_mount;
	
failed_mount:
	brelse(bh);
failed_sbi:
	sb->s_fs_info = NULL;
	kfree(sbi);
	return ret;
}

static int lkfs_get_sb(struct file_system_type *fs_type,
	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
{
	return get_sb_bdev(fs_type, flags, dev_name, data, lkfs_fill_super, mnt);
}

static struct file_system_type lkfs_fs_type = {
	.owner		= THIS_MODULE,
	.name		= "lkfs2",
	.get_sb		= lkfs_get_sb,
	.kill_sb	= kill_block_super,
	.fs_flags	= FS_REQUIRES_DEV,
};

static int __init init_lkfs_fs(void)
{
	int err = 0;
	err = init_inodecache();
	if (err)
		goto out;
        err = register_filesystem(&lkfs_fs_type);
	lkfs_debug("lkfs initialize...\n");
	lkfs_debug("super block size: %d\n", sizeof(struct lkfs_super_block));
	if (err)
		goto out;
	return 0;
out:
	destroy_inodecache();
	return err;
}

static void __exit exit_lkfs_fs(void)
{
	unregister_filesystem(&lkfs_fs_type);
	destroy_inodecache();
}

module_init(init_lkfs_fs)
module_exit(exit_lkfs_fs)
