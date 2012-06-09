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

	}
	return page;
}

static inline unsigned lkfs_chunk_size(struct inode *inode)
{
	return inode->i_sb->s_blocksize;
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

static int lkfs_commit_chunk(struct page *page, loff_t pos, unsigned len)
{
	struct address_space *mapping = page->mapping;
	struct inode *dir = mapping->host;
	int err = 0;

	dir->i_version++;
	block_write_end(NULL, mapping, pos, len, len, page, NULL);

	if (pos+len > dir->i_size) {
		i_size_write(dir, pos+len);
		mark_inode_dirty(dir);
	}

	err = write_one_page(page, 1);
	if (!err)
		err = lkfs_sync_inode(dir);


	return err;
}

int __lkfs_write_begin(struct file *file, struct address_space *mapping,
		loff_t pos, unsigned len, unsigned flags,
		struct page **pagep, void **fsdata)
{
	return block_write_begin_newtrunc(file, mapping, pos, len, flags,
					pagep, fsdata, lkfs_get_block);
}

int lkfs_add_link (struct dentry *dentry, struct inode *inode)
{
	struct inode *dir = dentry->d_parent->d_inode; /* parent inode */
	const char *name = dentry->d_name.name;
	int namelen = dentry->d_name.len;
	unsigned chunk_size = 1024;
	unsigned reclen = LKFS_DIR_REC_LEN(namelen);
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
	for (n = 0; n <= npages; n++) {  /* lkfs_get_page can allocate pages & blocks */
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
			/* lkfs_debug("name:%s, name_len:%d, inode:%d\n",
				de->name, de->name_len, de->inode);*/
			if ((char *)de == dir_end) {
				lkfs_debug("######need change inode isize#########\n");
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
	pos = page_offset(page) +
		(char*)de - (char*)page_address(page);
	err = __lkfs_write_begin(NULL, page->mapping, pos, rec_len, 0,
							&page, NULL);
	if (err)
		goto out_unlock;
	if (de->inode) {
		struct lkfs_dir_entry_2 *de1 = (struct lkfs_dir_entry_2 *) ((char *) de + name_len);
		de1->rec_len = (rec_len - name_len);
		de->rec_len = name_len;
		de = de1;
	}
	de->name_len = namelen;
	memcpy(de->name, name, namelen);
	de->inode = cpu_to_le32(inode->i_ino);
	
	err = lkfs_commit_chunk(page, pos, rec_len);
	dir->i_mtime = dir->i_ctime = CURRENT_TIME_SEC;
	/* dir->i_nlink++; */ /* don't need inc nlink number when create a file */
	mark_inode_dirty(dir);
	/* OFFSET_CACHE */
out_put:
	lkfs_put_page(page);
out:
	return err;
out_unlock:
	unlock_page(page);
	goto out_put;
}

/*
 * Set the first fragment of directory.
 */
int lkfs_make_empty(struct inode *inode, struct inode *parent)
{
	struct address_space *mapping = inode->i_mapping;
	struct page *page = grab_cache_page(mapping, 0);
	unsigned chunk_size = 1024;
	struct lkfs_dir_entry_2 * de;
	int err;
	void *kaddr;

	if (!page)
		return -ENOMEM;

	err = __lkfs_write_begin(NULL, page->mapping, 0, chunk_size, 0,
							&page, NULL);
	if (err) {
		unlock_page(page);
		goto fail;
	}
	kaddr = kmap_atomic(page, KM_USER0);
	memset(kaddr, 0, chunk_size);
	de = (struct lkfs_dir_entry_2 *)kaddr;
	de->name_len = 1;
	de->rec_len = LKFS_DIR_REC_LEN(1);
	memcpy (de->name, ".\0\0", 4);
	de->inode = cpu_to_le32(inode->i_ino);
	//ext2_set_de_type (de, inode);

	de = (struct lkfs_dir_entry_2 *)(kaddr + LKFS_DIR_REC_LEN(1));
	de->name_len = 2;
	de->rec_len = chunk_size - LKFS_DIR_REC_LEN(1);
	de->inode = cpu_to_le32(parent->i_ino);
	memcpy (de->name, "..\0", 4);
	kunmap_atomic(kaddr, KM_USER0);
	err = lkfs_commit_chunk(page, 0, chunk_size);
fail:
	page_cache_release(page);
	return err;
}

struct lkfs_dir_entry_2 *lkfs_find_entry (struct inode * dir,
			struct qstr *child, struct page ** res_page)
{
	const char *name = child->name;
	int namelen = child->len;
	unsigned reclen = LKFS_DIR_REC_LEN(namelen);
	unsigned long start, n;
	unsigned long npages = dir_pages(dir);
	struct page *page = NULL;
	struct lkfs_dir_entry_2 * de;
	int dir_has_error = 0;

	if (npages == 0)
		goto out;

	/* OFFSET_CACHE */
	*res_page = NULL;

	start = 0;
	n = start;
	do {
		char *kaddr;
		page = lkfs_get_page(dir, n, dir_has_error);
		if (!IS_ERR(page)) {
			kaddr = page_address(page);
			de = (struct lkfs_dir_entry_2 *) kaddr;
			kaddr += lkfs_last_byte(dir, n) - reclen;
			while ((char *) de <= kaddr) {
				if (de->rec_len == 0) {
					lkfs_debug("zero-length directory entry");
					lkfs_put_page(page);
					goto out;
				}
				if (lkfs_match (namelen, name, de)) {
					lkfs_debug("find\n");
					goto found;
				}	
				de = lkfs_next_entry(de);
			}
			lkfs_put_page(page);
		} else
			dir_has_error = 1;

		if (++n >= npages)
			n = 0;
		/* next page is past the blocks we've got */
		if (unlikely(n > (dir->i_blocks >> (PAGE_CACHE_SHIFT - 9)))) {
			lkfs_debug("dir %lu size %lld exceeds block count %llu",
				dir->i_ino, dir->i_size,
				(unsigned long long)dir->i_blocks);
			goto out;
		}
	} while (n != start);
out:
	return NULL;

found:
	*res_page = page;
	/*ei->i_dir_start_lookup = n;*/
	return de;
}

int lkfs_delete_entry (struct lkfs_dir_entry_2 * dir, struct page * page )
{
	struct address_space *mapping = page->mapping;
	struct inode *inode = mapping->host;
	char *kaddr = page_address(page);
	unsigned from = ((char*)dir - kaddr) & ~(lkfs_chunk_size(inode)-1); 
	/* & (~(2^10 -1)) */
	unsigned to = ((char *)dir - kaddr) + (dir->rec_len);
	loff_t pos;
	struct lkfs_dir_entry_2 * pde = NULL;
	struct lkfs_dir_entry_2 * de = (struct lkfs_dir_entry_2 *) (kaddr + from);
	int err;

	lkfs_debug("from:0x%x, to:0x%x, dir:0x%x, de:0x%x\n",
			from, to, (int)dir, (int)de);

	while ((char*)de < (char*)dir) {
		if (de->rec_len == 0) {
			lkfs_debug("zero-length directory entry");
			err = -EIO;
			goto out;
		}
		pde = de;
		de = lkfs_next_entry(de);
	}
	if (pde)
		from = (char*)pde - (char*)page_address(page);
	pos = page_offset(page) + from;
	lock_page(page);
	err = __lkfs_write_begin(NULL, page->mapping, pos, to - from, 0,
							&page, NULL);
	BUG_ON(err);
	if (pde)
		pde->rec_len = (to - from);
	dir->inode = 0;
	err = lkfs_commit_chunk(page, pos, to - from);
	inode->i_ctime = inode->i_mtime = CURRENT_TIME_SEC;
	/* EXT2_I(inode)->i_flags &= ~EXT2_BTREE_FL; */
	mark_inode_dirty(inode);
	lkfs_sync_inode(inode);
out:
	lkfs_put_page(page);
	return err;
}

static int lkfs_readdir (struct file * filp, void * dirent, filldir_t filldir)
{
	loff_t pos = filp->f_pos;
	struct inode *inode = filp->f_path.dentry->d_inode;
	unsigned int offset = pos & ~PAGE_CACHE_MASK;
	unsigned long n = pos >> PAGE_CACHE_SHIFT;
	unsigned long npages = dir_pages(inode);

	if (pos > inode->i_size - LKFS_DIR_REC_LEN(1))
		return 0;

	for ( ; n < npages; n++, offset = 0) {
		char *kaddr, *limit;
		struct lkfs_dir_entry_2 *de;
		struct page *page = lkfs_get_page(inode, n, 0);

		kaddr = page_address(page);
		
		de = (struct lkfs_dir_entry_2 *)(kaddr+offset);
		limit = kaddr + lkfs_last_byte(inode, n) - LKFS_DIR_REC_LEN(1);
		for ( ;(char*)de <= limit; de = lkfs_next_entry(de)) {
			if (de->rec_len == 0) {
				lkfs_debug("zero-length directory entry");
				lkfs_put_page(page);
				return -EIO;
			}
			if (de->inode) {
				int over;
				unsigned char d_type = DT_UNKNOWN;

				offset = (char *)de - kaddr;
				over = filldir(dirent, de->name, de->name_len,
						(n<<PAGE_CACHE_SHIFT) | offset,
						le32_to_cpu(de->inode), d_type);
				if (over) {
					lkfs_put_page(page);
					return 0;
				}
			}
			filp->f_pos += (de->rec_len);
		}
		lkfs_put_page(page);
	}
	return 0;
}

const struct file_operations lkfs_dir_operations = {
	.llseek		= generic_file_llseek,
	.read		= generic_read_dir,
	.readdir	= lkfs_readdir,
	.fsync		= lkfs_fsync,
};
