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
	char chr;
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
}