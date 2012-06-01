/*
 * Implement the manual drop-all-pagecache function
 */

#include <linux/kernel.h>
#include <linux/mm.h>
#include <linux/fs.h>
#include <linux/writeback.h>
#include <linux/sysctl.h>
#include <linux/gfp.h>
#include <linux/buffer_head.h>
#include <linux/pagevec.h>
/* A global variable is a bit ugly, but it keeps the code simple */
int sysctl_drop_caches;

static void drop_pagecache_sb(struct super_block *sb, void *unused)
{
	struct inode *inode, *toput_inode = NULL;

	spin_lock(&inode_lock);
	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
		if (inode->i_state & (I_FREEING|I_CLEAR|I_WILL_FREE|I_NEW))
			continue;
		if (inode->i_mapping->nrpages == 0)
			continue;
		__iget(inode);
		spin_unlock(&inode_lock);
		invalidate_mapping_pages(inode->i_mapping, 0, -1);
		iput(toput_inode);
		toput_inode = inode;
		spin_lock(&inode_lock);
	}
	spin_unlock(&inode_lock);
	iput(toput_inode);
}

static void drop_slab(void)
{
	int nr_objects;

	do {
		nr_objects = shrink_slab(1000, GFP_KERNEL, 1000);
	} while (nr_objects > 10);
}

static unsigned long clear_buffer(struct address_space *mapping,
				       pgoff_t start, pgoff_t end)
{
	struct pagevec pvec;
	pgoff_t next = start;
	unsigned long ret = 0;
	int i;
	struct buffer_head *bh, *head;
	pagevec_init(&pvec, 0);
	while (next <= end &&
			pagevec_lookup(&pvec, mapping, next, PAGEVEC_SIZE)) {
		//mem_cgroup_uncharge_start();
		for (i = 0; i < pagevec_count(&pvec); i++) {
			struct page *page = pvec.pages[i];
			pgoff_t index;
			int lock_failed;

			lock_failed = !trylock_page(page);

			/*
			 * We really shouldn't be looking at the ->index of an
			 * unlocked page.  But we're not allowed to lock these
			 * pages.  So we rely upon nobody altering the ->index
			 * of this (pinned-by-us) page.
			 */
			index = page->index;
			if (index > next)
				next = index;
			next++;
			if (lock_failed)
				continue;

			if (page_has_buffers(page)) {
				
				printk("find buffer\n");
				ret++;
				head = page_buffers(page);
				bh = head;
				do {
					clear_buffer_uptodate(bh);
					bh = bh->b_this_page;
				} while (bh != head);
			}	

			unlock_page(page);
			if (next > end)
				break;
		}
		pagevec_release(&pvec);
		//mem_cgroup_uncharge_end();
		cond_resched();
	}
	printk("buffer cache: %dKiB\n", 4 * ret);
	return ret;
}


int ext4_mb_discard_preallocations(struct super_block *sb, int needed);
static void drop_preallocation(struct super_block *sb, void *unused)
{
	int freed = 0;
	struct buffer_head *bh;
	
	printk("%s\n", sb->s_id);
	if (strncmp(sb->s_id, "loop0", 5) == 0) {
		printk("Begin to release preallocation blocks...\n");
		freed = ext4_mb_discard_preallocations(sb, 1024);
		printk("release blocks: %d\n", freed);
		bh = sb_bread(sb, 1);
		if (buffer_uptodate(bh))
			printk("buffer is uptodate\n");
		
		clear_buffer(sb->s_bdev->bd_inode->i_mapping, 0, -1);
		bh = sb_getblk(sb, 1);
		if (!bh)  {
			printk("can no find bh!\n");
			return;
		}
		
		if (buffer_uptodate(bh))
			printk("buffer is uptodate\n");
		else
			printk("buffer is invalidate\n");

		brelse(bh);
	}
}

int drop_caches_sysctl_handler(ctl_table *table, int write,
	void __user *buffer, size_t *length, loff_t *ppos)
{
	proc_dointvec_minmax(table, write, buffer, length, ppos);
	if (write) {
		if (sysctl_drop_caches & 1)
			iterate_supers(drop_pagecache_sb, NULL);
		if (sysctl_drop_caches & 2)
			drop_slab();
		if (sysctl_drop_caches & 4) {
			iterate_supers(drop_preallocation, NULL);
		}	
	}
	return 0;
}
