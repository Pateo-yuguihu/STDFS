/*
*********************************************************************************************************
*                                              EXAMPLE CODE
*
*                          (c) Copyright 2003-2006; Micrium, Inc.; Weston, FL
*
*               All rights reserved.  Protected by international copyright laws.
*               Knowledge of the source code may NOT be used to develop a similar product.
*               Please help us continue to provide the Embedded community with the finest
*               software available.  Your honesty is greatly appreciated.
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*
*                                      APPLICATION CONFIGURATION
*
*                                     ST Microelectronics STM32
*                                              with the
*                                   STM3210B-LK1 Evaluation Board
*
* Filename      : app_cfg.h
* Version       : V1.10
* Programmer(s) : L.X.R
*********************************************************************************************************
*/

#ifndef  __APP_CFG_H__
#define  __APP_CFG_H__

/*
*********************************************************************************************************
*                                       MODULE ENABLE / DISABLE
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                              TASKS NAMES
*********************************************************************************************************
*/

/*
*********************************************************************************************************
*                                            TASK PRIORITIES
*********************************************************************************************************
*/

#define  APP_TASK_START_PRIO                              15
#define  APP_TASK_MONITOR_PRIO                            12
#define  APP_TASK_LED_PRIO                            	  11
#define  APP_TASK_U3RX_PRIO                                4
#define  OS_TASK_TMR_PRIO                                 60
/*
*********************************************************************************************************
*                                            TASK STACK SIZES
*                             Size of the task stacks (# of OS_STK entries)
*********************************************************************************************************
*/

#define  APP_TASK_START_STK_SIZE                         128
#define  APP_TASK_MONITOR_STK_SIZE                       128
#define  APP_TASK_LED_STK_SIZE                           128
#define  APP_TASK_U1TX_STK_SIZE                          128

/*
*********************************************************************************************************
*                                                  LIB
*********************************************************************************************************
*/

#define  uC_CFG_OPTIMIZE_ASM_EN                 DEF_ENABLED
#define  LIB_STR_CFG_FP_EN                      DEF_DISABLED
/*
*********************************************************************************************************
*                                                 MACRO'S
*********************************************************************************************************
*/
#define  UART1_FIFO_LENGTH   4
#define  UART2_FIFO_LENGTH   5
#define  UART3_FIFO_LENGTH   5
#define  UART2TX_FIFO_LENGTH 17
#define  UART3TX_FIFO_LENGTH 17

#endif
