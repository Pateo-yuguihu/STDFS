/*
 * Author: Hu Yugui <yugui.hu@hotmail.com>
 * Project for Breshless DC motor
 */
#ifndef __INIT_H__
#define __INIT_H__
#include <ucos_ii.h>

struct sys_init{
	char *name;
	void (*setup)(void);
};

struct sys_func_map {
	int addr;
	char *name;
};

#define module_init(func,_name)			\
struct sys_init module_##func	\
 __attribute__((used, __section__(".module"))) = {	\
	.setup		= func,		\
	.name		= _name, \
}

#define core_init(func,_name)			\
struct sys_init core_##func	\
 __attribute__((used, __section__(".core"))) = {	\
	.setup		= func,		\
	.name		= _name, \
}

void xprintf (const char* str, ...);
void xputc (char c);
void lcd_printf(char *format, ...);

#define info(format, arg...)\
	xprintf("[%d]" format, OSTime, ## arg);

typedef int(*commandfunc_t)(int, char *[]);

typedef struct commandlist {
        int magic;
        char *name;
        char *help;
        commandfunc_t callback;
} commandlist_t;

#define __command __attribute__((used, __section__(".commandlist")))

#define COMMAND_MAGIC (0x436d6420)      /* "Cmd " */

#define __commandlist(fn, nm, hlp) \
static commandlist_t __command_##fn __command = { \
        magic:    COMMAND_MAGIC, \
        name:     nm, \
        help:     hlp, \
        callback: fn }

#define MAX_COMMANDLINE_LENGTH (40)
#define MAX_ARGS (MAX_COMMANDLINE_LENGTH / 4)
int parse_command(char *cmdline);
#define CONSOLE_PROMPT "BLDM#"
#endif
