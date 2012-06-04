/*
 *  linux/fs/lkfs/dir.c
 */

#include "lkfs.h"
#include <linux/buffer_head.h>
#include <linux/pagemap.h>
#include <linux/swap.h>

/*
 * p is at least 6 bytes before the end of page
 */
static inline struct lkfs_dir_entry_2 *lkfs_next_entry(struct lkfs_dir_entry_2 *p)
{
	return (struct lkfs_dir_entry_2 *)((char *)p + p->rec_len);
}

static inline void lkfs_put_page(struct page *page)
{
	kunmap(page);
	page_cache_release(page);
}

static struct page * lkfs_get_page(struct inode *dir, unsigned long n,
				   int quiet)
{
	struct address_space *mapping = dir->i_mapping;
	struct page *page = read_mapping_page(mapping, n, NULL);
	if (!IS_ERR(page)) {
		kmap(page);
		/*if (!PageChecked(page))
			ext2_check_page(page, quiet);
		if (PageError(page))
			goto fail;*/
	}
	return page;

fail:
	lkfs_put_page(page);
	return ERR_PTR(-EIO);
}

/*
 * Return the offset into page `page_nr' of the last valid
 * byte in that page, plus one.
 */
static unsigned
lkfs_last_byte(struct inode *inode, unsigned long page_nr)
{
	unsigned last_byte = inode->i_size;

	last_byte -= page_nr << PAGE_CACHE_SHIFT;
	if (last_byte > PAGE_CACHE_SIZE)
		last_byte = PAGE_CACHE_SIZE;
	return last_byte;
}

static inline int lkfs_match (int len, const char * const name,
					struct lkfs_dir_entry_2 * de)
{
	if (len != de->name_len)
		return 0;
	if (!de->inode)
		return 0;
	return !memcmp(name, de->name, len);
}

static inline unsigned long dir_pages(struct inode *inode)
{
	return (inode->i_size+PAGE_CACHE_SIZE-1)>>PAGE_CACHE_SHIFT;
}


int lkfs_add_link (struct dentry *dentry, struct inode *inode)
{
	struct inode *dir = dentry->d_parent->d_inode; /* parent inode */
	const char *name = dentry->d_name.name;
	int namelen = dentry->d_name.len;
	unsigned chunk_size = 1024;
	unsigned reclen = 12;
	unsigned short rec_len, name_len;
	struct page *page = NULL;
	struct lkfs_dir_entry_2 * de;
	unsigned long npages = dir_pages(dir);
	unsigned long n;
	char *kaddr;
	loff_t pos;
	int err;

	/*
	 * We take care of directory expansion in the same loop.
	 * This code plays outside i_size, so it locks the page
	 * to protect that region.
	 */
	for (n = 0; n <= npages; n++) {
		char *dir_end;

		page = lkfs_get_page(dir, n, 0);
		err = PTR_ERR(page);
		if (IS_ERR(page))
			goto out;
		lock_page(page);
		kaddr = page_address(page);
		dir_end = kaddr + lkfs_last_byte(dir, n);
		de = (struct lkfs_dir_entry_2 *)kaddr;
		kaddr += PAGE_CACHE_SIZE - reclen;
		while ((char *)de <= kaddr) {
			lkfs_debug("name:%s, name_len:%d, inode:%d\n",
				de->name, de->name_len, de->inode);
			if ((char *)de == dir_end) {
				/* We hit i_size */
				name_len = 0;
				rec_len = chunk_size;
				de->rec_len = 1024;
				de->inode = 0;
				goto got_it;
			}
			if (de->rec_len == 0) {
				lkfs_debug("zero-length directory entry");
				err = -EIO;
				goto out_unlock;
			}
			err = -EEXIST;
			if (lkfs_match (namelen, name, de))
				goto out_unlock;
			name_len = LKFS_DIR_REC_LEN(de->name_len);
			rec_len = de->rec_len;
			
			if (!de->inode && rec_len >= reclen)
				goto got_it;
			if (rec_len >= name_len + reclen) {
				lkfs_debug("rec_len:%d, name_len:%d, reclen:%d\n",
					rec_len, name_len, reclen);
				goto got_it;
			}	
			de = (struct lkfs_dir_entry_2 *) ((char *) de + rec_len);
		}
		unlock_page(page);
		lkfs_put_page(page);
	}
	BUG();
	return -EINVAL;
got_it:
	#if 1
	pos = page_offset(page) +
		(char*)de - (char*)page_address(page);
	err = __lkfs_write_begin(NULL, page->mapping, pos, rec_len, 0,
							&page, NULL);
	if (err)
		goto out_unlock;
	if (de->inode) {
		struct lkfs_dir_entry_2 *de1 = (struct lkfs_dir_entry_2 *) ((char *) de + name_len);
		de1->rec_len = (rec_len - name_len);
		de->rec_len = (name_len);
		de = de1;
	}
	de->name_len = namelen;
	memcpy(de->name, name, namelen);
	de->inode = cpu_to_le32(inode->i_ino);
	//ext2_set_de_type (de, inode);
	//err = ext2_commit_chunk(page, pos, rec_len);
	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
	//EXT2_I(dir)->i_flags &= ~EXT2_BTREE_FL;
	mark_inode_dirty(dir);
	/* OFFSET_CACHE */
out_put:
	lkfs_put_page(page);
out:
	return err;
out_unlock:
	unlock_page(page);
	goto out_put;
#endif
}

static int lkfs_readdir (struct file * filp, void * dirent, filldir_t filldir)
{
	loff_t pos = filp->f_pos;
	struct inode *inode = filp->f_path.dentry->d_inode;
	struct super_block *sb = inode->i_sb;
	unsigned int offset = pos & 1023;
	unsigned long n = pos >> 10;
	unsigned long nblocks;
	
	unsigned char *types = NULL;
	int need_revalidate = filp->f_version != inode->i_version;
	struct buffer_head *bh;
	nblocks = (inode->i_size + 1023) >> 10;
	
	for ( ; n < nblocks; n++, offset = 0) {
		lkfs_debug("n = %d, offset = %d\n", n, offset);
		struct lkfs_dir_entry_2 *de;
		bh = sb_bread(sb, LKFS_I(inode)->i_data[n]);
		de = (struct lkfs_dir_entry_2 *)(bh->b_data + offset);
		int de_offset = offset;
		
		for ( ;de_offset <= 1012; de = lkfs_next_entry(de)) {
			if (de->rec_len == 0) {
				lkfs_debug("zero-length directory entry");
				brelse(bh);
				return -EIO;
			}
			if (de->inode) {
				int over;
				unsigned char d_type = DT_UNKNOWN;
				//lkfs_debug("de->name = %a, de->name_len = %u\n", de->name, de->name_len);

				over = filldir(dirent, de->name, de->name_len,
						filp->f_pos, le32_to_cpu(de->inode), d_type);
				if (over) {
					brelse(bh);
					return 0;
				}
			}
			de_offset += de->rec_len;
			filp->f_pos += de->rec_len;
		}
	}
	if (!bh)
		brelse(bh);
	return 0;
}

const struct file_operations lkfs_dir_operations = {
	.llseek		= generic_file_llseek,
	.read		= generic_read_dir,
	.readdir	= lkfs_readdir,
	/* .fsync		= lkfs_fsync, */
};

