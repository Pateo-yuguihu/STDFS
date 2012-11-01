#include <ucos_ii.h>
#include <init.h>
#include "stm32f10x.h"

/* ps command
 * List all of tasks
 */
static int ps(int argc, char *argv[])
{
	OS_TCB *ptcb;
	ptcb = OSTCBList;
	while (ptcb->OSTCBPrio != OS_TASK_IDLE_PRIO) {	 /* Go through all TCBs in TCB list */
		xprintf("[%16s] PRIO:%2d TimeDelay:%d STACK-SIZE:%d STACK-USAGE:%d%%\n",
			ptcb->OSTCBTaskName,
			ptcb->OSTCBPrio, 
			ptcb->OSTCBDly,
			ptcb->OSTCBStkSize,
			ptcb->OSTCBStkUsed  *100 / (ptcb->OSTCBStkSize * sizeof(OS_STK)));
		ptcb = ptcb->OSTCBNext;	/* Point at next TCB in TCB list */
	}
	return 0;
}

static char pshelp[] = "List all of tasks.\n";
__commandlist(ps, "ps", pshelp);

/* ps command
 * List all of tasks
 */
static int reset(int argc, char *argv[])
{
	__set_FAULTMASK(1);
	SCB->AIRCR = 0x05FA0004;
	return 0;
}

static char resethelp[] = "Reset system.\n";
__commandlist(reset, "reset", resethelp);
