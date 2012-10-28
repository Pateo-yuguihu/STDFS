/*
 * Author: Hu Yugui <yugui.hu@hotmail.com>
 * Project for Breshless DC motor
 */
#ifndef __INIT_H__
#define __INIT_H__

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
#endif
