/*
* mklkfs.c
* yugui.hu@hotmail.com
* 
* about lake file system:
* 	just a study file system used to learn linux filesystem architecture.
* 
* Disk struct:
* [boot block 0 ][super block 1][inode table block 2 .. 33][data block 34 .. 1023]
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
/*
* Function to create new directory block template.
*/
char *create_new_dir_block_template(ushort pinode, ushort cinode)
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

int write_block(register int fd, ushort blkno, const void *blk_buf)
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

int read_block(register int fd, ushort blkno, void *blk_buf)
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

int set_bit(ushort bit_nr, void *addr)
{
	int mask, retval;
	unsigned char *ADDR = (unsigned char *)addr;

	ADDR += bit_nr >> 3;
	mask = 1 << (bit_nr & 0x07);
	retval = (mask & *ADDR) != 0;
	*ADDR |= mask;

	return retval;
}

int clear_bit(ushort bit_nr, void *addr)
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
int write_inode(register int fd, struct lkfs_super_block *sb,
		ushort ino, struct lkfs_inode *inode)
{
	const char *this = "write_inode:";
	char blk_buf[LKFS_BLOCK_SIZE];
	char *ptr;
	
	memset(blk_buf, 0, LKFS_BLOCK_SIZE);

	ptr = (char *)(blk_buf + (LKFS_ROOT_INO - 1)* LKFS_INODE_SIZE);
	memcpy((struct lkfs_inode *)ptr, inode, LKFS_INODE_SIZE);

	if (write_block(fd, 2, &blk_buf) < 0) {
		printf("\n%s Error while writing the block %d.", this, 2);
		return -1;
	}

	return 0;
}

/*
* Function to create '/' directory
*/
int create_root_directory(register int fd, struct lkfs_super_block *sb)
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
	pinode.i_block[0] = 34;

	/* write root dir */
	if (write_block(fd, 34, blk_ptr) < 0) {
		printf("\n%s Error while writing the block %d.", this, 34);
		return -1;
	}

	/* write root inode */
	if (write_inode(fd, sb, LKFS_ROOT_INO, &pinode) < 0) {
		printf("\n%s Error while writing the inode %d.", this, LKFS_ROOT_INO);
		return -1;
	}
	sb->s_free_blocks_count -= 35;
	sb->s_free_inodes_count -= 10;
	return 0;
}

/*
* Core function that actually creates the filesystem.
*/
int create_lkfs(const char *device, ushort total_blocks)
{
	struct lkfs_super_block sb;
	register int rc = 0, fd = 0;
	char blk_buf[LKFS_BLOCK_SIZE];

	if ((fd = open_device(device, O_RDWR)) < 0) {
		printf("\nError while opening the device %s.", device);
		return -1;
	}

	memset(&sb, 0, sizeof(struct lkfs_super_block));
	sb.s_blocks_count = total_blocks;
	sb.s_magic = 0x8309;
	strncpy(sb.s_volume_name, "LK file system", 14);
	sb.s_free_blocks_count = total_blocks;
	sb.s_free_inodes_count = total_blocks / 4;
	/* set block bitmap */
	int i = 0;
	for (i = 0; i < 35; i++) {
		set_bit(i, sb.blockbitmap); /* mark block used */
	}

	for (i = 0; i < 11; i++) { /* mark inode used */
		set_bit(i, sb.inodebitmap);
	}
	
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
	ulong tb = 0;
	
	if (create_lkfs(argv[1], (ushort) 1024) != 0)
		goto error_exit;

	exit(0);

 error_exit:
	printf("\nCannot create filesystem on this device.\n");
	exit(1);
}

