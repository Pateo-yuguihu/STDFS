/*
* mklkfs.c
* yugui.hu@hotmail.com
* 
* about lake file system:
* 	just a study file system used to learn linux filesystem architecture.
* 
* Disk struct:
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
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <unistd.h>
#include <stdarg.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <sys/wait.h>
#include <linux/types.h>
#include <errno.h>
#include <time.h>
#include "mklkfs.h"

#define LKFS_BLOCK_SIZE 1024
char *block_bitmap;
char *inode_bitmap;

/*
* Function to create new directory block template.
*/
char *create_new_dir_block_template(int pinode, int cinode)
{
	static char buf[1024];
	struct lkfs_dir_entry_2 *dir_entry;

	memset(buf, 0, LKFS_BLOCK_SIZE);

	dir_entry = (struct lkfs_dir_entry_2 *)buf;
	dir_entry->inode = cinode;
	dir_entry->name_len= 1;
	strcat(dir_entry->name, ".");
	dir_entry->rec_len = 12;
	
	dir_entry = (struct lkfs_dir_entry_2 *)(buf + 12);
	dir_entry->inode = pinode;
	dir_entry->name_len = 2;
	strcat(dir_entry->name, "..");
	dir_entry->rec_len = LKFS_BLOCK_SIZE - 12;
	
	return buf;
}

int open_device(const char *device, register int flags)
{
	const char *this = "open_device:";
	register int fd = 0;

	if ((fd = open(device, flags)) < 0) {
		printf("\n%s 'open' error: %s.", this, strerror(errno));
		return -1;
	}

	return fd;
}

int close_device(register int fd)
{
	const char *this = "close_device:";

	if (close(fd) != 0) {
		printf("\n%s 'close' error: %s.", this, strerror(errno));
		return -1;
	}

	return 0;
}

int write_block(int fd, int blkno, const void *blk_buf)
{
	const char *this = "write_block:";
	off_t noffset = 0;
	ssize_t wrote = 0;

	if (lseek(fd, (off_t) 0, SEEK_SET) != 0) {
		printf("\n%s 'lseek' error: %s.", this, strerror(errno));
		return -1;
	}

	noffset = blkno * LKFS_BLOCK_SIZE;
	if (lseek(fd, noffset, SEEK_SET) != noffset) {
		printf("\n%s 'lseek' error: %s.", this, strerror(errno));
		return -1;
	}

	wrote = write(fd, blk_buf, LKFS_BLOCK_SIZE);
	if (wrote != LKFS_BLOCK_SIZE) {
		printf("\n%s 'write' error: %s.", this, strerror(errno));
		return -1;
	}

	return 0;
}

int read_block(register int fd, int blkno, void *blk_buf)
{
	const char *this = "read_block:";
	off_t noffset = 0;
	ssize_t actual = 0;

	if (lseek(fd, (off_t) 0, SEEK_SET) != 0) {
		printf("\n%s 'lseek' error: %s.", this, strerror(errno));
		return -1;
	}

	noffset = blkno * LKFS_BLOCK_SIZE;
	if (lseek(fd, noffset, SEEK_SET) != noffset) {
		printf("\n%s 'lseek' error: %s.", this, strerror(errno));
		return -1;
	}

	actual = read(fd, blk_buf, LKFS_BLOCK_SIZE);
	if (actual != LKFS_BLOCK_SIZE) {
		printf("\n%s 'read' error: %s.", this, strerror(errno));
		return -1;
	}

	return 0;
}

int nwrite_block(int fd, int blkno, const void *blk_buf, int blocknr)
{
	const char *this = "nwrite_block:";
	off_t noffset = 0;
	ssize_t wrote = 0;

	if (lseek(fd, (off_t) 0, SEEK_SET) != 0) {
		printf("\n%s 'lseek' error: %s.", this, strerror(errno));
		return -1;
	}

	noffset = blkno * LKFS_BLOCK_SIZE;
	if (lseek(fd, noffset, SEEK_SET) != noffset) {
		printf("\n%s 'lseek' error: %s.", this, strerror(errno));
		return -1;
	}

	wrote = write(fd, blk_buf, LKFS_BLOCK_SIZE * blocknr);
	if (wrote != LKFS_BLOCK_SIZE * blocknr) {
		printf("\n%s 'write' error: %s.", this, strerror(errno));
		return -1;
	}

	return 0;
}

int set_bit(int bit_nr, void *addr)
{
	int mask, retval;
	unsigned char *ADDR = (unsigned char *)addr;

	ADDR += bit_nr >> 3;
	mask = 1 << (bit_nr & 0x07);
	retval = (mask & *ADDR) != 0;
	*ADDR |= mask;

	return retval;
}

int clear_bit(int bit_nr, void *addr)
{
	int mask, retval;
	unsigned char *ADDR = (unsigned char *)addr;

	ADDR += bit_nr >> 3;
	mask = 1 << (bit_nr & 0x07);
	retval = (mask & *ADDR) != 0;
	*ADDR &= ~mask;

	return retval;
}

/*
* Function to write root inode
*/
int write_inode(int fd, struct lkfs_super_block *sb,
		int ino, struct lkfs_inode *inode)
{
	const char *this = "write_inode:";
	char blk_buf[LKFS_BLOCK_SIZE];
	char *ptr;
	
	memset(blk_buf, 0, LKFS_BLOCK_SIZE);

	ptr = (char *)(blk_buf + (LKFS_ROOT_INO - 1)* LKFS_INODE_SIZE);
	memcpy((struct lkfs_inode *)ptr, inode, LKFS_INODE_SIZE);
	
	printf("%s, %d\n", __func__, 2 + sb->s_block_bitmap_count + sb->s_inode_bitmap_count);
	
	if (write_block(fd, 2 + sb->s_block_bitmap_count + sb->s_inode_bitmap_count, blk_buf) < 0) {
		printf("\n%s Error while writing the block %d.", this,
			2 + sb->s_block_bitmap_count + sb->s_inode_bitmap_count);
		return -1;
	}

	return 0;
}

/*
* Function to create '/' directory
*/
int create_root_directory(int fd, struct lkfs_super_block *sb)
{
	const char *this = "create_root_directory:";
	struct lkfs_inode pinode;
	char *blk_ptr = NULL;

	blk_ptr = create_new_dir_block_template(LKFS_ROOT_INO, LKFS_ROOT_INO);

	memset(&pinode, 0, LKFS_INODE_SIZE);
	pinode.i_uid = getuid();
	pinode.i_gid = getgid();
	pinode.i_mode = S_IFDIR | 0755;
	printf("\nimode: 0x%x, %d\n", pinode.i_mode, pinode.i_mode);
	pinode.i_atime = time(NULL);
	pinode.i_ctime = time(NULL);
	pinode.i_mtime = time(NULL);
	pinode.i_links_count = 2;
	pinode.i_size = LKFS_BLOCK_SIZE;
	pinode.i_blocks = LKFS_BLOCK_SIZE / 512;
	pinode.i_block[0] = 2 + sb->s_block_bitmap_count + sb->s_inode_bitmap_count + sb->s_inode_table_count;

	printf("%s, %d\n", __func__, pinode.i_block[0]);
	/* write root dir */
	if (write_block(fd, pinode.i_block[0], blk_ptr) < 0) {
		printf("\n%s Error while writing the block %d.", this, 34);
		return -1;
	}

	/* write root inode */
	if (write_inode(fd, sb, LKFS_ROOT_INO, &pinode) < 0) {
		printf("\n%s Error while writing the inode %d.", this, LKFS_ROOT_INO);
		return -1;
	} 
	return 0;
}

enum {
	BLOCK_BITMAP = 0,
	INODE_BITMAP = 1
};

/*
* Core function that actually creates the filesystem.
*/
int create_lkfs(const char *device, int total_blocks)
{
	struct lkfs_super_block sb;
	int rc = 0, fd = 0;
	char blk_buf[LKFS_BLOCK_SIZE];
	char filesystem_name[32] = "Luck V2 file system";
	
	if ((fd = open_device(device, O_RDWR)) < 0) {
		printf("\nError while opening the device %s.", device);
		return -1;
	}

	memset(&sb, 0, sizeof(struct lkfs_super_block));
	
	sb.s_blocks_count = total_blocks;
	sb.s_inodes_count = (sb.s_blocks_count + 3) >> 2;
	sb.s_magic = LKFS_SUPER_MAGIC;
	sb.s_block_size = LKFS_BLOCK_SIZE;
	sb.s_inode_size = LKFS_INODE_SIZE;
	sb.s_block_bitmap_count = (sb.s_blocks_count + 8191) >> 13;
	sb.s_inode_bitmap_count = (sb.s_inodes_count + 8191) >> 13;
	sb.s_inode_table_count = (sb.s_inodes_count  + 7) >> 3;

	sb.s_free_blocks_count =
		total_blocks - sb.s_block_bitmap_count - sb.s_inode_bitmap_count - sb.s_inode_table_count - 2 - 1;
	/* bootblock + superblock + blockbitmap + inodebitmap + inode table  + rootdir */
	sb.s_free_inodes_count = sb.s_inodes_count - 11;

	printf("filesystem name:%s\n"
			"s_blocks_count: %d\n"
			"s_inodes_count:%d\n"
			"s_magic:0x%x\n"
			"s_block_size:%d\n"
			"s_inode_size:%d\n"
			"s_block_bitmap_count:%d\n"
			"s_inode_bitmap_count:%d\n"
			"s_inode_table_count:%d\n"
			"s_free_blocks_count:%d\n"
			"s_free_inodes_count:%d\n",
			filesystem_name,
			sb.s_blocks_count,
			sb.s_inodes_count,
			sb.s_magic,
			sb.s_block_size,
			sb.s_inode_size,
			sb.s_block_bitmap_count,
			sb.s_inode_bitmap_count,
			sb.s_inode_table_count,
			sb.s_free_blocks_count,
			sb.s_free_inodes_count);
	
	strncpy(sb.s_volume_name, filesystem_name, strlen(filesystem_name));
	
	int i = 0;
	/* clear block bitmap */
	block_bitmap = (char *)malloc(sb.s_block_bitmap_count * 1024);
	memset(block_bitmap, 0, sb.s_block_bitmap_count * 1024);
	for (i = 0; i < (sb.s_blocks_count - sb.s_free_blocks_count); i++) {
		set_bit(i, block_bitmap); /* mark block used */
	}
	nwrite_block(fd, 2, block_bitmap, sb.s_block_bitmap_count);

	/* clear inode bitmap */
	inode_bitmap = (char *)malloc(sb.s_inode_bitmap_count * 1024);
	memset(inode_bitmap, 0, sb.s_inode_bitmap_count * 1024);
	
	for (i = 0; i < 11; i++) {
		set_bit(i, inode_bitmap); /* mark block used */
	}
	nwrite_block(fd, 2 + sb.s_block_bitmap_count, inode_bitmap, sb.s_inode_bitmap_count);
	
	create_root_directory(fd, &sb);
	memset(blk_buf, 0, LKFS_BLOCK_SIZE);
	memcpy(blk_buf, &sb, sizeof(struct lkfs_super_block));
	if (write_block(fd, 1, blk_buf) != 0) {
		printf("\nError while writing the superblock.");
		rc = -1;
		goto error_exit;
	}

 error_exit:
	if (close_device(fd) != 0)
		rc = -1;

	return 0;
}

int main(int argc, char *argv[])
{
	int blockcount = 0;
	struct stat sb;

	if (stat(argv[1], &sb) == -1) {
		perror("stat");
		exit(EXIT_FAILURE);
	}

	printf("File type:");
	switch (sb.st_mode & S_IFMT) {
		case S_IFBLK:
			printf("block device\n");
			break;
		case S_IFCHR:
			printf("character device\n");
			break;
		case S_IFDIR:
			printf("directory\n");
			break;
		case S_IFIFO:
			printf("FIFO/pipe\n");
			break;
		case S_IFLNK:
			printf("symlink\n");
			break;
		case S_IFREG:
			printf("regular file\n");
			break;
		case S_IFSOCK:
			printf("socket\n");
			break;
		default:
			printf("unknown?\n");
			break;
	}
	blockcount = sb.st_size >> 10;
	printf("File size:%lld bytes, block numbers:%d\n",
		(long long) sb.st_size, blockcount);

	if (create_lkfs(argv[1], blockcount) != 0)
		goto error_exit;

	exit(0);

 error_exit:
	printf("\nCannot create filesystem on this device.\n");
	exit(1);
}

