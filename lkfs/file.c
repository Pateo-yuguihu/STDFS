/*
 *  linux/fs/lkfs/file.c
 */

#include <linux/time.h>
#include <linux/pagemap.h>
#include <linux/quotaops.h>
#include "lkfs.h"

static int lkfs_release_file (struct inode * inode, struct file * filp)
{
	return 0;
}

int lkfs_fsync(struct file *file, int datasync)
{
	int ret;
	struct super_block *sb = file->f_mapping->host->i_sb;
	struct address_space *mapping = sb->s_bdev->bd_inode->i_mapping;

	ret = generic_file_fsync(file, datasync);
	return ret;
}

const struct file_operations lkfs_file_operations = {
	.llseek		= generic_file_llseek,
	.read		= do_sync_read,
	.write		= do_sync_write,
	.aio_read	= generic_file_aio_read,
	.aio_write	= generic_file_aio_write,

	.mmap		= generic_file_mmap,
	.open		= generic_file_open,
	.release	= lkfs_release_file,
	.fsync		= lkfs_fsync,
	.splice_read	= generic_file_splice_read,
	.splice_write	= generic_file_splice_write,
};

const struct inode_operations lkfs_file_inode_operations = {
	.setattr	= lkfs_setattr,
	//.fiemap		= lkfs_fiemap,
};

