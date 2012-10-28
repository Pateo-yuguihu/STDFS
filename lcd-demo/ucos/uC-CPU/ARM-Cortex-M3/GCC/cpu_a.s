/*********************************************************************************************************
;                                               uC/CPU
;                                    CPU CONFIGURATION & PORT LAYER
;
;                          (c) Copyright 2004-2008; Micrium, Inc.; Weston, FL
;
;               All rights reserved.  Protected by international copyright laws.
;
;               uC/CPU is provided in source form for FREE evaluation, for educational
;               use or peaceful research.  If you plan on using uC/CPU in a commercial
;               product you need to contact Micrium to properly license its use in your
;               product.  We provide ALL the source code for your convenience and to
;               help you experience uC/CPU.  The fact that the source code is provided
;               does NOT mean that you can use it without paying a licensing fee.
;
;               Knowledge of the source code may NOT be used to develop a similar product.
;
;               Please help us continue to provide the Embedded community with the finest
;               software available.  Your honesty is greatly appreciated.
;********************************************************************************************************


;********************************************************************************************************
;
;                                            CPU PORT FILE
;
;                                            ARM-Cortex-M3
;                                            GCC Compiler
;
; Filename      : cpu_a.asm
; Version       : V1.19
; Programmer(s) : L.X.R.
;********************************************************************************************************


;********************************************************************************************************
;                                           PUBLIC FUNCTIONS
;*******************************************************************************************************/

        .global  CPU_IntDis
        .global  CPU_IntEn

        .global  CPU_SR_Save
        .global  CPU_SR_Restore

        .global  CPU_CntLeadZeros
        .global  CPU_RevBits

        .global  CPU_WaitForInt
        .global  CPU_WaitForExcept


/********************************************************************************************************
;                                      CODE GENERATION DIRECTIVES
;*******************************************************************************************************/

//        RSEG CODE:CODE:NOROOT(2)
    .text
//    .code 32


/********************************************************************************************************
;                                    DISABLE and ENABLE INTERRUPTS
;
; Description: Disable/Enable interrupts.
;
; Prototypes : void  CPU_IntDis(void);
;              void  CPU_IntEn (void);
;*******************************************************************************************************/
        .func    CPU_IntDis
CPU_IntDis:
        CPSID   I
        BX      LR
        .endfunc

        .func    CPU_IntEn
CPU_IntEn:
        CPSIE   I
        BX      LR
        .endfunc
/********************************************************************************************************
;                                      CRITICAL SECTION FUNCTIONS
;
; Description : Disable/Enable interrupts by preserving the state of interrupts.  Generally speaking, the
;               state of the interrupt disable flag is stored in the local variable 'cpu_sr' & interrupts
;               are then disabled ('cpu_sr' is allocated in all functions that need to disable interrupts).
;               The previous interrupt state is restored by copying 'cpu_sr' into the CPU's status register.
;
; Prototypes  : CPU_SR  CPU_SR_Save   (void);
;               void    CPU_SR_Restore(CPU_SR cpu_sr);
;
; Note(s)     : (1) These functions are used in general like this:
;
;                   void  Task (void *p_arg)
;                   {
;                                                               /* Allocate storage for CPU status register //
;                   #if (CPU_CFG_CRITICAL_METHOD == CPU_CRITICAL_METHOD_STATUS_LOCAL)
;                       CPU_SR  cpu_sr;
;                   #endif
;
;                            :
;                            :
;                       CPU_CRITICAL_ENTER();                   /* cpu_sr = CPU_SR_Save();                  //
;                            :
;                            :
;                       CPU_CRITICAL_EXIT();                    /* CPU_SR_Restore(cpu_sr);                  //
;                            :
;                            :
;                   }
;*******************************************************************************************************/
        .func    CPU_SR_Save
CPU_SR_Save:
        MRS     R0, PRIMASK

        CPSID   I
        BX      LR
        .endfunc

        .func    CPU_SR_Restore
CPU_SR_Restore:
        MSR     PRIMASK, R0
        BX      LR
        .endfunc


/********************************************************************************************************
;                                         COUNT LEADING ZEROS
;
; Description : Counts the number of binary zero bits before the first binary one bit in the argument.
;               If the argument is zero, the value 32 is returned.
;
; Prototypes  : CPU_INT32U  CPU_CntLeadZeros (CPU_INT32U  val)
;
; Argument(s) : val     variable to count leading zeros
;*******************************************************************************************************/
        .func    CPU_CntLeadZeros
CPU_CntLeadZeros:
        CLZ     R0, R0
        BX      LR
        .endfunc


/********************************************************************************************************
;                                             REVERSE BITS
;
; Description : Reverses the bits in the argument.
;
; Prototypes  : CPU_INT32U  CPU_RevBits (CPU_INT32U  val)
;
; Argument(s) : val     variable to reverse
;*******************************************************************************************************/
        .func    CPU_RevBits
CPU_RevBits:
        RBIT    R0, R0
        BX      LR
        .endfunc


/********************************************************************************************************
;                                         WAIT FOR INTERRUPT
;
; Description : Enters sleep state, which will be exited when an interrupt is received.
;
; Prototypes  : void  CPU_WaitForInt (void)
;
; Argument(s) : none.
;*******************************************************************************************************/
        .func    CPU_WaitForInt
CPU_WaitForInt:
        WFI
        BX      LR
        .endfunc


/********************************************************************************************************
;                                         WAIT FOR EXCEPTION
;
; Description : Enters sleep state, which will be exited when an exception is received.
;
; Prototypes  : void  CPU_WaitForExcept (void)
;
; Argument(s) : none.
;*******************************************************************************************************/
        .func    CPU_WaitForExcept
CPU_WaitForExcept:
        WFE
        BX      LR
        .endfunc


/********************************************************************************************************
;                                     CPU ASSEMBLY PORT FILE END
;*******************************************************************************************************/

        .END

