#ifndef _MKLKFS_H_
#define _MKLKFS_H_

/*
 * Structure of a directory entry
 */
#define LKFS_NAME_LEN 255
struct lkfs_dir_entry_2 {
	__le32	inode;			/* Inode number */
	__le16	rec_len;		/* Directory entry length */
	__u8	name_len;		/* Name length */
	__u8	file_type;
	char	name[LKFS_NAME_LEN];	/* File name */
};

/*
 * LKFS directory file types.  Only the low 3 bits are used.  The
 * other bits are reserved for now.
 */
enum {
	LKFS_FT_UNKNOWN		= 0,
	LKFS_FT_REG_FILE	= 1,
	LKFS_FT_DIR		= 2,
	LKFS_FT_CHRDEV		= 3,
	LKFS_FT_BLKDEV		= 4,
	LKFS_FT_FIFO		= 5,
	LKFS_FT_SOCK		= 6,
	LKFS_FT_SYMLINK		= 7,
	LKFS_FT_MAX
};

/*
 * Constants relative to the data blocks
 */
#define	LKFS_NDIR_BLOCKS		21
#define	LKFS_IND_BLOCK			LKFS_NDIR_BLOCKS
#define	LKFS_DIND_BLOCK			(LKFS_IND_BLOCK + 1)
#define	LKFS_N_BLOCKS			(LKFS_DIND_BLOCK + 1)

/*
 * Structure of an inode on the disk
 */
struct lkfs_inode {
	__le16	i_mode;		/* File mode */
	__le16	i_uid;		/* Low 16 bits of Owner Uid */
	__le32	i_size;		/* Size in bytes */
	__le32	i_atime;	/* Access time */
	__le32	i_ctime;	/* Creation time */
	__le32	i_mtime;	/* Modification time */
	__le32	i_dtime;	/* Deletion Time */
	__le16	i_gid;		/* Low 16 bits of Group Id */
	__le16	i_links_count;	/* Links count */
	__le32	i_blocks;	/* Blocks count */
	__le32	i_flags;	/* File flags */
	__le32	i_block[LKFS_N_BLOCKS];/* Pointers to blocks */
};


#define LKFS_GOOD_OLD_INODE_SIZE 128
#define LKFS_SUPER_MAGIC	0x8309
#define LKFS_INODE_PER_SB_BIT 3
#define LKFS_INODE_PER_SB 8
#define LKFS_INODE_SIZE 128
/*
 * Special inode numbers
 */
#define	LKFS_BAD_INO		 1	/* Bad blocks inode */
#define LKFS_ROOT_INO		 2	/* Root inode */
#define LKFS_BOOT_LOADER_INO	 5	/* Boot loader inode */
#define LKFS_UNDEL_DIR_INO	 6	/* Undelete directory inode */
#define LKFS_GOOD_OLD_FIRST_INO	11


/*
 * Structure of the super block
 */
struct lkfs_super_block {
	__le32	s_inodes_count;		/* Inodes count */
	__le32	s_blocks_count;		/* Blocks count */
	__le32	s_free_blocks_count;	/* Free blocks count */
	__le32	s_free_inodes_count;	/* Free inodes count */
	__le32	s_log_block_size;	/* Block size */
	__le32	s_mtime;		/* Mount time */
	__le32	s_wtime;		/* Write time */
	__le16	s_mnt_count;		/* Mount count */
	__le16	s_max_mnt_count;	/* Maximal mount count */
	__le16	s_magic;		/* Magic signature */
	__le16	s_state;		/* File system state */
	__le32	s_first_ino; 		/* First non-reserved inode */
	__le16   s_inode_size; 		/* size of inode structure */
	__u8	s_uuid[16];		/* 128-bit uuid for volume */
	char	s_volume_name[16]; 	/* volume name */
	char blockbitmap[128];	/* block bitmap: 8 * 128 = 1024 */
	char inodebitmap[32];  /* inode bitmap : 8 * 32 = 256 */
};


#endif
