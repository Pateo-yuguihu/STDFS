#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <errno.h>
#include <sys/stat.h>

#define LIST_LONG       (1 << 0)
#define LIST_ALL        (1 << 1)
#define LIST_RECURSIVE  (1 << 2)
int filecount = 0;
FILE *fp;

struct file_list {
	int f_no;
	char f_name[1024];
	struct file_list *next, *prev;
};
struct file_list *cp;

static void INIT_LIST_HEAD(struct file_list *list)
{
	list->next = list;
	list->prev = list;
}

static void __list_add(struct file_list *new, struct file_list *prev, struct file_list *next)
{
	next->prev = new;
	new->next = next;
	new->prev = prev;
	prev->next = new;
}

static void list_add(struct file_list *new, struct file_list *head)
{
	__list_add(new, head, head->next);
}

static void __list_del(struct file_list * prev, struct file_list * next)
{
	next->prev = prev;
	prev->next = next;
}

static void list_del(struct file_list *entry)
{
	__list_del(entry->prev, entry->next);
}

#define list_for_each(pos, head) \
	for (pos = (head)->next; pos != (head); pos = pos->next)

static int list_empty(struct file_list *head)
{
	return head->next == head;
}

static int list_dir(const char *name, int flags)
{
	char tmp[4096];
	DIR *d;
	struct dirent *de;
	int err = 0;
	struct stat s;

	d = opendir(name);
	if(d == 0) {
		fprintf(stderr, "opendir failed, %s\n", strerror(errno));
		return -1;
	}

	while((de = readdir(d)) != 0) {
		if(de->d_name[0] == '.' && (flags & LIST_ALL) == 0) 
			continue;

		if (!strcmp(name, "/")) 
			sprintf(tmp, "/%s", de->d_name);
		else 
			sprintf(tmp, "%s/%s", name, de->d_name);
		/*
		 * If the name ends in a '/', use stat() so we treat it like a
		 * directory even if it's a symlink.
		 */
		if (tmp[strlen(tmp)-1] == '/')
			err = stat(tmp, &s);
		else
			err = lstat(tmp, &s);

		if (err < 0) {
			perror(tmp);
			closedir(d);
			return -1;
		}

		if (S_ISDIR(s.st_mode)) {
			list_dir(tmp, flags);
		} else if (S_ISREG(s.st_mode)) {
			filecount++;
			compare(tmp);
		}	

	}

	closedir(d);
	return 0;
}

int compare(char *new)
{
	int found = 0;
	char line[1024];
	int len = strlen(new);
	struct file_list *pos = cp->next, *tmp;

	while(pos != cp) {

		if (((strlen(pos->f_name) -1) == len) &&
			(strncmp(new, pos->f_name, len) == 0)) {
				found = 1;
				tmp  = pos->next;
				list_del(pos);
				free(pos);
				pos = tmp;

				break;
		}
		pos = pos->next;
	}
	
	if (found == 0)
		printf("++++%s\n", new);
}

int loadfile(struct file_list * head)
{
	struct file_list *p;
	int no = 0;
	char line[1024];

	while(fgets(line, sizeof(line), fp)) {
		p = (struct file_list *)malloc(sizeof(struct file_list));
		strncpy(p->f_name, line, strlen(line));
		p->f_no = no++;
		list_add(p, head);
	}
	return no;
}

void list_delete_file(struct file_list * head)
{
	struct file_list * pos;
	list_for_each(pos, head) {
			printf("----%s", pos->f_name);
	}	
}

void free_list(struct file_list * head)
{
#if 1
	struct file_list *pos = head->next, *tmp;
	//if (list_empty(head)) {
	//	free(head);
	//	return;
	//}
	
	while(pos != head) {
			tmp  = pos->next;
			list_del(pos);
			free(pos);
			pos = tmp;
	}
#endif
}

int main(int argc, char *argv[])
{
	int len = 0;
	if (!(fp = fopen(argv[2], "r"))) {
			return -1;
	}
	
	struct file_list head;
	INIT_LIST_HEAD(&head);
	len = loadfile(&head);

	cp = &head;
	list_dir(argv[1], LIST_RECURSIVE);
	list_delete_file(&head);
	printf("new file count:%d, old file count:%d\n", filecount, len);

	free_list(&head);
	fclose(fp);
	return 0;
}

