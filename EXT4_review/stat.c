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
static int listdir(const char *name, int flags)
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
			listdir(tmp, flags);
		} else if (S_ISREG(s.st_mode)) {
			filecount++;
			printf("%s\n", tmp);
			//compare(tmp);
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
	
	fseek(fp, 0, SEEK_SET);
	while(fgets(line, sizeof(line), fp)) {
		if (strncmp(new, line, len) != 0)
			continue;
		else {
			found = 1;
			break;
		}
	}

	if (found == 0)
		printf("+++%s\n", new);
}

int main(int argc, char *argv[])
{	
	listdir(argv[1], LIST_RECURSIVE);
	//printf("filecount:%d\n", filecount);

	return 0;
}

