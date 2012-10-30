/*
 * Author: Hu Yugui <yugui.hu@hotmail.com>
 * Project for Breshless DC motor
 */
#include "ili9320.h"
#include <stdio.h>
#include <string.h>
#include "init.h"
#include <stdarg.h>

static int cur_line = 0, cur_row = 0;
#define FONT_WIDTH 	8
#define FONT_HEIGHT 16
#define MAX_LINE	15
#define MAX_ROW 	40

void lcd_printf(char *format, ...)
{
	char str[40];
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
				cur_line = 0;
				ili9320_Clear(0xFFFF); /* clear fullscreen */
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
