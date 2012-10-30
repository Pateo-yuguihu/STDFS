/*
 * Author: Hu Yugui <yugui.hu@hotmail.com>
 * Project for Breshless DC motor
 */
#define SBRK_VERBOSE 1
#include <errno.h>
#include <stdlib.h> /* abort */
#include <sys/types.h>
#include <sys/stat.h>

#include "init.h"
#include "stm32f10x.h"

#undef errno
extern int errno;

int _kill(int pid, int sig)
{
	pid = pid; sig = sig; /* avoid warnings */
	errno = EINVAL;
	return -1;
}

void _exit(int status)
{
	xprintf("_exit called with parameter %d\n", status);
	while(1) {;}
}

int _getpid(void)
{
	return 1;
}

extern int _eusrstack, _estack; /* Defined by the linker */
static char *heap_end;

char* get_heap_end(void)
{
	return (char*)heap_end;
}

char* get_stack_top(void)
{
	return (char*) __get_MSP();
}

caddr_t _sbrk (int incr)
{
	char *prev_heap_end;
#if SBRK_VERBOSE
	xprintf("_sbrk called with incr %d\n", incr);
#endif
	if (heap_end == 0) {
		heap_end = (caddr_t)(&_eusrstack + 1);
}
	prev_heap_end = heap_end;
#if 1
	if (heap_end + incr > get_stack_top()) {
		xprintf("Heap and stack collision\n");
		abort();
	}
#endif
	heap_end += incr;
	return (caddr_t) prev_heap_end;
}

int _close(int file)
{
	file = file; /* avoid warning */
	return -1;
}

int _fstat(int file, struct stat *st)
{
	file = file; /* avoid warning */
	st->st_mode = S_IFCHR;
	return 0;
}

int _isatty(int file)
{
	file = file; /* avoid warning */
	return 1;
}

int _lseek(int file, int ptr, int dir) {
	file = file; /* avoid warning */
	ptr = ptr; /* avoid warning */
	dir = dir; /* avoid warning */
	return 0;
}

int _read(int file, char *ptr, int len)
{
	file = file; /* avoid warning */
	ptr = ptr; /* avoid warning */
	len = len; /* avoid warning */
	return 0;
}

int _write(int file, char *ptr, int len)
{
	int todo;
	file = file; /* avoid warning */
	for (todo = 0; todo < len; todo++) {
		xputc(*ptr++);
	}
	return len;
}
