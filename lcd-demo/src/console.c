/*
 * Author: Hu Yugui <yugui.hu@hotmail.com>
 * Project for Breshless DC motor
 */
#include "ili9320.h"
#include <stdio.h>
#include <string.h>
#include "init.h"
#include <stdarg.h>
#include "stm32f10x.h"
#include "stm32f10x_rcc.h"
#include "stm32f10x_gpio.h"
#include "stm32f10x_usart.h"

static int cur_line = 0, cur_row = 0;
#define FONT_WIDTH 	8
#define FONT_HEIGHT 16
#define MAX_LINE	15
#define MAX_ROW 	40

void clear_fullscreen()
{
	int i = 0;
	for (i = 1; i < 15; i++) {
		GUI_Text(0, i * FONT_HEIGHT,	/* clean line */
			(u8 *)"                                        ",
			0,
			0xFFFF);
	}
}

void lcd_printf(char *format, ...)
{
	char str[64];
	int i;
	va_list args;

	va_start(args, format);
	vsprintf(str, format, args);
	cur_row = 0;
	for (i = 0; i < strlen(str); i++) {
		if (str[i] == '\n') {
			cur_row = 0;
			cur_line++;
			if (cur_line == MAX_LINE) {
				cur_line = 1;
				clear_fullscreen();
			}
			continue;
		} else if (str[i] == '\r') {
			cur_row = 0;
			GUI_Text(cur_row, cur_line * FONT_HEIGHT,	/* clean line */
				(u8 *)"                                        ",
				0,
				0xFFFF);
			continue;
		}

		ili9320_PutChar(cur_row * FONT_WIDTH,
			cur_line * FONT_HEIGHT,str[i],0, 0xFFFF);
		cur_row++;
		if (cur_row == MAX_ROW)
			xprintf("Warning:more than 40 chars in a line!\n");
	}
	va_end(args);
}

extern OS_EVENT *uart_receive_sem;
void USART1_IRQHandler(void)
{
	//OSIntEnter();
	
	OS_CPU_SR cpu_sr = 0;
	OS_ENTER_CRITICAL();
	if(USART_GetFlagStatus(USART1,USART_IT_RXNE)==SET)
	{
		OSSemPost(uart_receive_sem);
		//chr = USART_ReceiveData(USART1);
		/* USART_SendData(USART1,i);	// TC: send complete flag
		 while(USART_GetFlagStatus(USART1, USART_FLAG_TC) == RESET)
		{
		} */
	}

	if(USART_GetITStatus(USART1, USART_IT_RXNE) != RESET)
	{
		/* Clear the USART1 Receive interrupt */
		USART_ClearITPendingBit(USART1, USART_IT_RXNE);
	}
	//OSIntExit();
	OS_EXIT_CRITICAL();
}

extern commandlist_t __commandlist_start[];
extern commandlist_t __commandlist_end[];
/* the first command */

#define STATE_WHITESPACE (0)
#define STATE_WORD (1)
static void parse_args(char *cmdline, int *argc, char **argv)
{
	char *c;
	int state = STATE_WHITESPACE;
	int i;

	*argc = 0;

	if(strlen(cmdline) == 0)
		return;

	/* convert all tabs into single spaces */
	c = cmdline;
	while(*c != '\0') {
		if(*c == '\t')
			*c = ' ';

		c++;
	}

	c = cmdline;
	i = 0;

	/* now find all words on the command line */
	while(*c != '\0') {
		if(state == STATE_WHITESPACE) {
			if(*c != ' ') {
				argv[i] = c;
				i++;
				state = STATE_WORD;
			}
		} else { /* state == STATE_WORD */
			if(*c == ' ') {
				*c = '\0';
				state = STATE_WHITESPACE;
			}
		}

		c++;
	}

	*argc = i;
}

static int get_num_command_matches(char *cmdline)
{
	commandlist_t *cmd;
	int len;
	int num_matches = 0;

	len = strlen(cmdline);

	for(cmd = __commandlist_start; cmd <  __commandlist_end; cmd++) {
		if(cmd->magic != COMMAND_MAGIC) {
			xprintf("command magic failed at 0x%08x\n",
				 (unsigned int)cmd);

			return -1;
		}

		if(strncmp(cmd->name, cmdline, len) == 0)
			num_matches++;
	}

	return num_matches;
}

int parse_command(char *cmdline)
{
	commandlist_t *cmd;
	int argc, num_commands, len;
	char *argv[MAX_ARGS];

	parse_args(cmdline, &argc, argv);

	/* only whitespace */
	if(argc == 0)
		return 0;

	num_commands = get_num_command_matches(argv[0]);
	/* error */
	if(num_commands < 0)
		return num_commands;

	/* no command matches */
	if(num_commands == 0)
		return -1;

	/* ambiguous command */
	if(num_commands > 1)
		return -1;

	len = strlen(argv[0]);

	/* single command, go for it */
	for(cmd = __commandlist_start; cmd < __commandlist_end; cmd++) {
		if(cmd->magic != COMMAND_MAGIC) {
			xprintf("command magic failed at 0x%08x\n",
				 (unsigned int)cmd);

			return -1;
		}
		
		if(strncmp(cmd->name, argv[0], len) == 0) {
			/* call function */
			return cmd->callback(argc, argv);
		}
	}

	return -1;
}

/* help command */
static int help(int argc, char *argv[])
{
	commandlist_t *cmd;

	/* help on a command? */
	if(argc >= 2) {
		for(cmd = __commandlist_start; cmd < __commandlist_end; cmd++) {
			if(strncmp(cmd->name, argv[1],
				   MAX_COMMANDLINE_LENGTH) == 0) {
				xprintf("Help for %s:\n\nUsage: %s\n",
				       argv[1], cmd->help);
				return 0;
			}
		}

		return -1;
	}

	xprintf("The following commands are supported:\n");
	for(cmd = __commandlist_start; cmd < __commandlist_end; cmd++) {
		xprintf("* %s\n", cmd->name);
	}
	xprintf("Use \"help command\" to get help on a specific command\n");
	return 0;
}

static char helphelp[] = "help [command]\n"
"Get help on [command], "
"or a list of supported commands if a command is omitted.\n";

__commandlist(help, "help", helphelp);
