/*
 * File      : context_gcc.S
 * This file is part of RT-Thread RTOS
 * COPYRIGHT (C) 2009 - 2011, RT-Thread Development Team
 *
 * The license and distribution terms for this file may be
 * found in the file LICENSE in this distribution or at
 * http://www.rt-thread.org/license/LICENSE
 *
 * Change Logs:
 * Date         Author    Notes
 * 2009-10-11   Bernard   First version
 * 2010-12-29	onelife	  Modify for EFM32
 * 2011-06-17	onelife	  Merge all of the assembly source code into context_gcc.S
 * 2011-07-12	onelife	  Add interrupt context check function
 */
 
	.cpu 	cortex-m3
	.fpu 	softvfp
	.syntax	unified
	.thumb
	.text

	.equ	ICSR, 0xE000ED04 				/* interrupt control state register */
	.equ	PENDSVSET_BIT, 0x10000000 		/* value to trigger PendSV exception */
	
	.equ	SHPR3, 0xE000ED20 				/* system priority register (3) */
	.equ	PENDSV_PRI_LOWEST, 0x00FF0000 	/* PendSV priority value (lowest) */
	.extern  dump_stack

	.global HardFault_Handler
	.type HardFault_Handler, %function
HardFault_Handler:
    /* get current context */
    MRS     R0, PSP                 /* get fault thread stack pointer */
    PUSH    {LR}
    BL      dump_stack
    POP     {LR}

    ORR     LR, LR, #0x04
    BX      LR


