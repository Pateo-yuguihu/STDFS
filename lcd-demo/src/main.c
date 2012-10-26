/*
 * A quick test program to test the LCD on the dev board mentioned in 
 * the readme. Also blinks an LED and does some floating point calcs for 
 * fun and testing :D.
 * 
 * If this helps you do something cool let me know!
 */

#include "stm32f10x.h"
#include "stm32f10x_rcc.h"
#include "stm32f10x_gpio.h"
#include "stm32f10x_usart.h"
#include <string.h>

GPIO_InitTypeDef GPIO_InitStructure;
USART_InitTypeDef USART_InitStructure;

void Delay(__IO uint32_t nCount);
void NVIC_Configration(void);
void EXTI_Configuration(void);
void FSMC_LCD_Init(void);
void GUI_Text(u16 x, u16 y, u8 *str, u16 len,u16 Color, u16 bkColor);
void LCD_Disp(u16 x, u16 y, u8 *str, u16 Color, u16 bkColor);
void LCD_Init(void);
void xprintf (const char* str, ...);

void lcd_rst(void){
	GPIO_ResetBits(GPIOE, GPIO_Pin_1);
    Delay(0xFFF);					   
    GPIO_SetBits(GPIOE, GPIO_Pin_1 );		 	 
	Delay(0xFFF);	
}

void Delay(__IO uint32_t nCount)
{
  for(; nCount != 0; nCount--);
}

void Uart_Init(void)
{
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;				/* USART1 TX 	*/
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
	GPIO_Init(GPIOA, &GPIO_InitStructure);
	
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;	         	/* USART1 RX 	*/
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

  	USART_InitStructure.USART_BaudRate = 9600;
 	USART_InitStructure.USART_WordLength = USART_WordLength_8b;
  	USART_InitStructure.USART_StopBits = USART_StopBits_1;
  	USART_InitStructure.USART_Parity = USART_Parity_No;
  	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
 	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;

  	/* Configure USART1 */
  	USART_Init(USART1, &USART_InitStructure);
	
    /* Enable the USART1 */
 	USART_Cmd(USART1, ENABLE);

}

void Bike_GPIO_Init(void)
{
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6|GPIO_Pin_7;			//D1 & D2
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_Init(GPIOC, &GPIO_InitStructure);					 
  
  //GPIO_InitStructure.GPIO_Pin = GPIO_Pin_13 |GPIO_Pin_6;		//D3 & D4	
  //GPIO_Init(GPIOD, &GPIO_InitStructure);

  //GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0;	//SPEAKER
  //GPIO_Init(GPIOE, &GPIO_InitStructure);
  
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1 ;	/* TFT-RESET */
  GPIO_Init(GPIOE, &GPIO_InitStructure);  	
  
  /*
   * TFT-Interface:D0~D7 D8~15 WR RD
   */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 | GPIO_Pin_1 | GPIO_Pin_4 | GPIO_Pin_5 |
                                GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10 | GPIO_Pin_14 | 
                                GPIO_Pin_15;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
  GPIO_Init(GPIOD, &GPIO_InitStructure);

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7 | GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10 | 
                                GPIO_Pin_11 | GPIO_Pin_12 | GPIO_Pin_13 | GPIO_Pin_14 | 
                                GPIO_Pin_15;
  GPIO_Init(GPIOE, &GPIO_InitStructure);	//fsmc 

  /* TFT-CS configuration */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7; 
  GPIO_Init(GPIOD, &GPIO_InitStructure);	//fsmc
  
  /* TFT-RS */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11;
  GPIO_Init(GPIOD, &GPIO_InitStructure);	//fsmc 
	
  /* TFT-RST */
  GPIO_SetBits(GPIOD, GPIO_Pin_7);			//CS=1 
  GPIO_SetBits(GPIOD, GPIO_Pin_14| GPIO_Pin_15 |GPIO_Pin_0 | GPIO_Pin_1);  //µÍ8Î»	 
  GPIO_SetBits(GPIOE, GPIO_Pin_7 | GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10); //µÍ8Î»  
  GPIO_ResetBits(GPIOE, GPIO_Pin_1);		//RESET=0
  GPIO_SetBits(GPIOD, GPIO_Pin_4);		    //RD=1
  GPIO_SetBits(GPIOD, GPIO_Pin_5);			//WR=1

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1;				    
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_Init(GPIOC, &GPIO_InitStructure);	
}

void put_char(char ch)
{
  	USART_SendData(USART1, (unsigned char) ch);
  	while (!(USART1->SR & USART_FLAG_TXE));
}

void printstr(char *str)
{
	int len = strlen(str);
	int i;
	for(i = 0; i < len; i++) {
		put_char(*str++);
	}
}


void test()
{
	printstr("jhah!\n\r");
}

struct sys_init{
	char *name;
	void (*setup)(void);
};

#define module_init(func,_name)			\
struct sys_init module_##func	\
 __attribute__((used, __section__(".module"))) = {	\
	.setup		= func,		\
	.name		= _name, \
}

extern struct sys_init _module_start[];
extern struct sys_init _module_end[];
module_init(test, "Just test code!\n\r");
//module_init(NULL, "Hardware fault!!!\n\r");

void init_module()
{
	struct sys_init *p;
	for (p = _module_start; p < _module_end; p++) {
		p->setup();
		printstr(p->name);
	}
}

void HardFault_Handler(void)
{
	printstr("HardFault Handler\n");
	while(1);
}

int main(int argc, char *argv[])
{
	//LCD_Configuration();
	//LCD_Initialization();
	GPIO_InitTypeDef GPIO_InitStructure;
	u32 delay;

  	RCC_APB2PeriphClockCmd( RCC_APB2Periph_USART1 |RCC_APB2Periph_GPIOA | RCC_APB2Periph_GPIOB |
                         RCC_APB2Periph_GPIOC | RCC_APB2Periph_GPIOD |
                         RCC_APB2Periph_GPIOE | RCC_APB2Periph_AFIO, ENABLE);

  	Bike_GPIO_Init();
  	Uart_Init();
	
	/* Configure PC12 to mode: slow rise-time, pushpull output */
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_2;//GPIO No. 0
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;;//slow rise time
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;// push-pull output
	GPIO_Init(GPIOA,&GPIO_InitStructure);//GPIOA init

	//LCD_Test();
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6|GPIO_Pin_7;			//D1 & D2
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOC, &GPIO_InitStructure);
	  /* Configure FSMC Bank1 NOR/PSRAM */
  	FSMC_LCD_Init();
  	LCD_Init();
  	
  	GUI_Text(0, 0, (u8 *)"********BIKE SPEED PROJECT******", strlen("********BIKE SPEED PROJECT******"),0, 0xFFFF);
  	LCD_Disp(0, 16, (u8 *)"[yugui.hu]", 0xF800, 0xFFFF);

	while(1)
	{
		delay = 500000;
		init_module();
		xprintf("Hello!%d\n\r", 123456);
		while(delay)
		{
			delay--;
		}
		GPIO_SetBits(GPIOC, GPIO_Pin_6);
		/* delay --> blah */
		delay = 500000;
		while(delay)
		{
			delay--;
		}
		GPIO_ResetBits(GPIOC, GPIO_Pin_6);
	}
}
