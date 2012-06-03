/*
 * linux/fs/lkfs/super.c
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
	ei = (struct ext2_inode_info *)kmem_cache_alloc(lkfs_inode_cachep, GFP_KERNEL);
	if (!ei)
		return NULL;
	ei->vfs_inode.i_version = 1;
	return &ei->vfs_inode;
}

static void lkfs_destroy_inode(struct inode *inode)
{
	kmem_cache_free(lkfs_inode_cachep, LKFS_I(inode));
}

static const struct super_operations lkfs_sops = {
	.alloc_inode	= lkfs_alloc_inode,
	.destroy_inode	= lkfs_destroy_inode,
	/*.write_inode	= lkfs_write_inode,
	.put_super	= lkfs_put_super,
	.write_super	= lkfs_write_super,
	.sync_fs	= lkfs_sync_fs,
	.statfs		= lkfs_statfs,
	.remount_fs	= lkfs_remount,*/
};

static int lkfs_fill_super(struct super_block *sb, void *data, int silent)
{
}

static int lkfs_get_sb(struct file_system_type *fs_type,
	int flags, const char *dev_name, void *data, struct vfsmount *mnt)
{
	return get_sb_bdev(fs_type, flags, dev_name, data, lkfs_fill_super, mnt);
}

static struct file_system_type lkfs_fs_type = {
	.owner		= THIS_MODULE,
	.name		= "lkfs",
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
