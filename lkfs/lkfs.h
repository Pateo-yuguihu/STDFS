#include <linux/fs.h>
#ifndef _LKFS_H_
#define _LKFS_H_
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
 * lake file system inode data in memory
 */
struct lkfs_inode_info {
	__le32	i_data[LKFS_N_BLOCKS];
	struct inode	vfs_inode;
	int i_state;
};
#define LKFS_STATE_NEW			0x00000001 /* inode is newly created */

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
#define LKFS_BLOCKS_PER_BITMAP 8192
#define LKFS_INODES_PER_BITMAP 8192

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
		__le32	s_inodes_count; 		/* Inodes count */
		__le32	s_blocks_count; 		/* Blocks count */
		__le32	s_free_blocks_count;	/* Free blocks count */
		__le32	s_free_inodes_count;	/* Free inodes count */
		__le32	s_block_bitmap_count;
		__le32	s_inode_bitmap_count;
		__le32	s_inode_table_count;
		__le32	s_mtime;			/* Mount time */
		__le32	s_wtime;			/* Write time */
		__le16	s_mnt_count;		/* Mount count */
		__le16	s_magic;			/* Magic signature */
		__le16	s_state;			/* File system state */
		__le32	s_first_ino;		/* First non-reserved inode */
		__le16	s_inode_size;		/* size of inode structure */
		__le16	s_block_size;		/* size of block */
		char	s_volume_name[32];	/* volume name */
	};

/*
 * lkfs-fs super-block data in memory
 */
struct lkfs_sb_info {
	struct buffer_head * s_sbh;	/* Buffer containing the super block */
	struct buffer_head **s_sbb; /* buffer containing the block bitmap */
	struct buffer_head **s_sib; /* buffer containing the inode bitmap */
	int block_bitmap_offset;
	int inode_bitmap_offset;
	int inode_table_offset;
	struct lkfs_super_block * s_es;	/* Pointer to the super block in the buffer */
	int s_inode_size;
};

#define LKFS_DIR_PAD		 	4
#define LKFS_DIR_ROUND 			(LKFS_DIR_PAD - 1)
#define LKFS_DIR_REC_LEN(name_len)	(((name_len) + 8 + LKFS_DIR_ROUND) & \
					 ~LKFS_DIR_ROUND)

#define LKFS_DEBUG
/*
 * Debug code
 */
#ifdef LKFS_DEBUG
#define lkfs_debug(f, a...)	do { \
						printk ("LKFS-fs(%d,%s)", __LINE__, __func__); \
				  		printk (f, ## a); \
					} while(0)
#else
#define lkfs_debug(f, a...)	/**/
#endif

static inline struct lkfs_inode_info *LKFS_I(struct inode *inode)
{
	return container_of(inode, struct lkfs_inode_info, vfs_inode);
}

static inline struct lkfs_sb_info *LKFS_SB(struct super_block *sb)
{
	return sb->s_fs_info;
}
/* super.c */
extern const struct address_space_operations lkfs_aops;

/* inode.c */
struct inode *lkfs_iget (struct super_block *, unsigned long);
int lkfs_write_inode (struct inode *, struct writeback_control *);
int lkfs_sync_inode (struct inode *);
int lkfs_get_block(struct inode *inode, sector_t iblock, struct buffer_head *bh_result, int create);
int lkfs_setattr (struct dentry *, struct iattr *);
void lkfs_delete_inode (struct inode * inode);

/*lkfs/file.c*/
extern const struct file_operations lkfs_file_operations;
extern const struct inode_operations lkfs_file_inode_operations;
int lkfs_fsync(struct file *file, int datasync);

/*lkfs/namei.c*/
extern const struct inode_operations lkfs_dir_inode_operations;
extern const struct inode_operations lkfs_special_inode_operations;

/*lkfs/dir.c*/
extern const struct file_operations lkfs_dir_operations;
int lkfs_add_link (struct dentry *dentry, struct inode *inode);
int lkfs_make_empty(struct inode *inode, struct inode *parent);
int __lkfs_write_begin(struct file *file, struct address_space *mapping,
		loff_t pos, unsigned len, unsigned flags,
		struct page **pagep, void **fsdata);
struct lkfs_dir_entry_2 *lkfs_find_entry (struct inode * dir,
			struct qstr *child, struct page ** res_page);
int lkfs_delete_entry (struct lkfs_dir_entry_2 * dir, struct page * page );
ino_t lkfs_inode_by_name(struct inode *dir, struct qstr *child);

/*lkfs/ialloc.c*/
struct inode *lkfs_new_inode(struct inode *dir, int mode);
void lkfs_free_inode (struct inode * inode);

#endif
