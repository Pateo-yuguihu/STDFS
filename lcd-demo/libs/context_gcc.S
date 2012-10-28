/*
 * Author: Hu Yugui <yugui.hu@hotmail.com>
 * Project for Breshless DC motor
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
 	.equ NVIC_INT_CTRL,     0xE000ED04      /* Interrupt control state register.      */
 	.equ NVIC_SYSPRI14,     0xE000ED22      /* System priority register (priority 14).*/
 	.equ NVIC_PENDSV_PRI,         0xFF      /* PendSV priority value (lowest).        */
 	.equ NVIC_PENDSVSET,    0x10000000      /* Value to trigger PendSV exception.     */
	.extern  _eusrstack

	.global HardFault_Handler
	.type HardFault_Handler, %function
HardFault_Handler:
    /* get current context */
    MRS     R0, PSP                 /* get fault thread stack pointer */
    MOV 	R1, R11
    PUSH    {LR}
    BL      dump_stack
    POP     {LR}
    ORR     LR, LR, #0x04
    BX      LR

	.global set_user_mode
	.type set_user_mode, %function
set_user_mode:
	LDR     R0, =_eusrstack
	MSR     PSP, R0
	mov 	R0, #3
	MSR		CONTROL,R0
	BX 		lr
