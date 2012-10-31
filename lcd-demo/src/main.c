/*
 * Author: Hu Yugui <yugui.hu@hotmail.com>
 * Project for Breshless DC motor
 */
#include "stm32f10x.h"
#include "stm32f10x_rcc.h"
#include "stm32f10x_gpio.h"
#include "stm32f10x_usart.h"
#include <string.h>
#include "init.h"
#include <ucos_ii.h>
#include  <app_cfg.h>
#include <cpu.h>
#include <lib_def.h>
#include "ili9320.h"
#include <stdio.h>

extern struct sys_init _module_start[], _core_start[], _core_end[];
extern struct sys_init _module_end[];
extern int _etext;
const struct sys_func_map  __attribute__((weak)) func_map[];

void Delay(__IO uint32_t nCount);
void FSMC_LCD_Init(void);
void LCD_Init(void);

void lcd_rst(void){
	GPIO_ResetBits(GPIOE, GPIO_Pin_1);
	Delay(0xFFF);					   
	GPIO_SetBits(GPIOE, GPIO_Pin_1 );		 	 
	Delay(0xFFF);	
}

static OS_STK app_start_stk[APP_TASK_START_STK_SIZE];
static OS_STK app_monitor_stk[APP_TASK_MONITOR_STK_SIZE];
static OS_STK app_led_stk[APP_TASK_LED_STK_SIZE];

static void app_monitor(void *p_arg)
{
	OS_TCB *ptcb;
	OS_CPU_SR cpu_sr = 0;

	while(1) {
		info("app_monitor\n");
		OSTimeDly(8000);

		OS_ENTER_CRITICAL();
		ptcb = OSTCBList;
		while (ptcb->OSTCBPrio != OS_TASK_IDLE_PRIO) {	 /* Go through all TCBs in TCB list */
			lcd_printf("[%13s]prio:%2d StkUsed:%d%%\n",
			ptcb->OSTCBTaskName, ptcb->OSTCBPrio, ptcb->OSTCBStkUsed  *100 / (ptcb->OSTCBStkSize * sizeof(OS_STK)));
		ptcb = ptcb->OSTCBNext;	/* Point at next TCB in TCB list */
		}
		OS_EXIT_CRITICAL();
	}
}

void panic()
{
	int *p = NULL;
	if (OSTime > 50000)
		*p = 1234;
}

static void app_led(void *p_arg)
{
	int sp_used = 0;
	info("app_led start...\n");
	while(1) {
		GPIO_SetBits(GPIOC, GPIO_Pin_6);
		OSTimeDly(1000);
		GPIO_ResetBits(GPIOC, GPIO_Pin_6);
		OSTimeDly(1000);
		lcd_printf("[%ds]CPU usage:%d%%\n", OSTime / 1000, OSCPUUsage);
		/* panic();*/
	}
}
static void app_start(void *p_arg)
{
	CPU_INT08U os_err;
	SysTick_Config(SystemFrequency/1000);
	OSStatInit();	/* stat task init */
	os_err = OSTaskCreateExt((void (*)(void *)) app_monitor,
			(void *) 0,
			(OS_STK *) & app_monitor_stk[APP_TASK_MONITOR_STK_SIZE - 1], 
			(INT8U) APP_TASK_MONITOR_PRIO, /* high priority */
			0,
			(OS_STK *) & app_monitor_stk[0],
			APP_TASK_MONITOR_STK_SIZE,
			(void *)0,
			OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);

	OSTaskNameSet(APP_TASK_MONITOR_PRIO, (CPU_INT08U *)"app_monitor", &os_err);

	os_err = OSTaskCreateExt((void (*)(void *)) app_led,
			(void *) 0,
			(OS_STK *) & app_led_stk[APP_TASK_LED_STK_SIZE - 1], 
			(INT8U) APP_TASK_LED_PRIO,
			0,
			(OS_STK *) & app_led_stk[0],
			APP_TASK_LED_STK_SIZE,
			(void *)0,
			OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);

	OSTaskNameSet(APP_TASK_LED_PRIO, (CPU_INT08U *)"app_led", &os_err);

	while(1) {
		info("app_start\n");
		OSTimeDly(1000);
	}
}

void Delay(__IO uint32_t nCount)
{
	for(; nCount != 0; nCount--);
}

void find_symbol(int addr)
{
	int i = 0;
	if (addr < 0x0800000 && addr > (int)&_etext)
		xprintf("Invalid symbol!");

	while(strncmp("_etext", func_map[i].name, 6) != 0) { /* end of text segment */
		if ((func_map[i].addr <= addr) && (func_map[i + 1].addr > addr)) {
			xprintf("address:0x%x: function:%s\n", func_map[i].addr, func_map[i].name);
			break;
		}
		i++;
	}
}

void Uart_Init(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;	/* USART1 TX 	*/
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;	/* USART1 RX 	*/
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
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

void stm32_gpio_init(void)
{
	GPIO_InitTypeDef GPIO_InitStructure;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6|GPIO_Pin_7;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOC, &GPIO_InitStructure);					 

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1 ;
	GPIO_Init(GPIOE, &GPIO_InitStructure);  	

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 | GPIO_Pin_1 | GPIO_Pin_4 | GPIO_Pin_5 |
		GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10 | GPIO_Pin_14 | 
		GPIO_Pin_15;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
	GPIO_Init(GPIOD, &GPIO_InitStructure);

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7 | GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10 | 
		GPIO_Pin_11 | GPIO_Pin_12 | GPIO_Pin_13 | GPIO_Pin_14 | 
		GPIO_Pin_15;
	GPIO_Init(GPIOE, &GPIO_InitStructure);

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7; 
	GPIO_Init(GPIOD, &GPIO_InitStructure);

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11;
	GPIO_Init(GPIOD, &GPIO_InitStructure);

	GPIO_SetBits(GPIOD, GPIO_Pin_7);
	GPIO_SetBits(GPIOD, GPIO_Pin_14| GPIO_Pin_15 |GPIO_Pin_0 | GPIO_Pin_1);
	GPIO_SetBits(GPIOE, GPIO_Pin_7 | GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10);
	GPIO_ResetBits(GPIOE, GPIO_Pin_1);
	GPIO_SetBits(GPIOD, GPIO_Pin_4);
	GPIO_SetBits(GPIOD, GPIO_Pin_5);
}
core_init(stm32_gpio_init, "gpio init\n");

void module_init_test()
{
	xprintf("breshless DC motor project\n");
}
module_init(module_init_test, "Module init test code\n");

//module_init(NULL, "Hardware fault!!!\n");

extern unsigned long _estack, _eusrstack;

void stm32_module_init()
{
	struct sys_init *p;
	for (p = _module_start; p < _module_end; p++) {
		p->setup();
		xprintf(p->name);
	}
}

void stm32_core_init()
{
	struct sys_init *p;
	for (p = _core_start; p < _core_end; p++) {
		p->setup();
		xprintf(p->name);
	}
}

void dump_stack(int sp, int fp)
{
	OS_TCB *ptcb;
	xprintf("======================================\n");
	xprintf("FP: 0x%x Stack dump: 0x%x - 0x%x\n", fp, sp, &_eusrstack);
	xprintf("R0   : 0x%8x\n", *(int *)(sp + 0));
	xprintf("R1   : 0x%8x\n", *(int *)(sp + 4));
	xprintf("R2   : 0x%8x\n", *(int *)(sp + 8));
	xprintf("R3   : 0x%8x\n", *(int *)(sp + 12));
	xprintf("R12  : 0x%8x\n", *(int *)(sp + 16));
	xprintf("LR   : 0x%8x\n", *(int *)(sp + 20));
	xprintf("PC   : 0x%8x\n", *(int *)(sp + 24));
	xprintf("xPSR : 0x%8x\n", *(int *)(sp + 28));
	find_symbol(*(int *)(sp + 20));
	if (OSRunning == OS_TRUE) {
		xprintf("Current Task Name:%s, prio:%d, STK:0x%x\n",
			OSTCBCur->OSTCBTaskName, OSTCBCur->OSTCBPrio, OSTCBCur->OSTCBStkPtr);

		xprintf("List all task:\n");
		ptcb = OSTCBList;
		while (ptcb->OSTCBPrio != OS_TASK_IDLE_PRIO) {	 /* Go through all TCBs in TCB list */
			xprintf("Current Task Name:%s, prio:%d, STK:0x%x, status:0x%x, Dly:%d\n",
			ptcb->OSTCBTaskName, ptcb->OSTCBPrio, ptcb->OSTCBStkPtr, ptcb->OSTCBStat,
			ptcb->OSTCBDly);
		ptcb = ptcb->OSTCBNext;	/* Point at next TCB in TCB list */
		}
	}
	xprintf("======================================\n");
	while(1);
}

int main(int argc, char *argv[])
{
	RCC_APB2PeriphClockCmd( RCC_APB2Periph_USART1 |RCC_APB2Periph_GPIOA | RCC_APB2Periph_GPIOB |
			RCC_APB2Periph_GPIOC | RCC_APB2Periph_GPIOD |
			RCC_APB2Periph_GPIOE | RCC_APB2Periph_AFIO, ENABLE);

	Uart_Init();
	stm32_core_init();
	xprintf("SystemCoreClock:%d\n", SystemFrequency);

	FSMC_LCD_Init();
	LCD_Init();

	lcd_printf("****BLDM %s %s****\n", __DATE__, __TIME__);
	OSInit();
	CPU_INT08U os_err = OSTaskCreateExt((void (*)(void *)) app_start,
						(void *)0,
						(OS_STK *) & app_start_stk[APP_TASK_START_STK_SIZE - 1],
						(INT8U) APP_TASK_START_PRIO,
						0,
						(OS_STK *) & app_start_stk[0],
						APP_TASK_START_STK_SIZE,
						(void *)0,
						OS_TASK_OPT_STK_CHK | OS_TASK_OPT_STK_CLR);
	/*
	CPU_INT08U os_err = OSTaskCreate((void (*)(void *)) app_start,
			(void *) 0,
			(OS_STK *) & app_start_stk[APP_TASK_START_STK_SIZE - 1], 
			(INT8U) APP_TASK_START_PRIO);
	*/
	if (os_err == OS_ERR_NONE)
		OSTaskNameSet(APP_TASK_START_PRIO, (CPU_INT08U *) "app_start", &os_err);

	OSStart();
	while(1)
	{
	}
}
