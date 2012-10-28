
main.elf:     file format elf32-littlearm


Disassembly of section .text:

08000000 <g_pfnVectors>:
 8000000:	ff ff 00 20 61 02 00 08 00 00 00 00 85 4b 00 08     ... a........K..
 8000010:	9d 02 00 08 9d 02 00 08 9d 02 00 08 00 00 00 00     ................
	...
 800002c:	9d 02 00 08 9d 02 00 08 00 00 00 00 9d 02 00 08     ................
 800003c:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 800004c:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 800005c:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 800006c:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 800007c:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 800008c:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 800009c:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 80000ac:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 80000bc:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 80000cc:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 80000dc:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 80000ec:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 80000fc:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 800010c:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 800011c:	9d 02 00 08 9d 02 00 08 9d 02 00 08 9d 02 00 08     ................
 800012c:	9d 02 00 08 00 00 00 00 00 00 00 00 00 00 00 00     ................
	...
 80001dc:	5f f8 e0 f1                                         _...

080001e0 <__Init_Data>:
	0, 0, 0,
	(intfunc)0xF1E0F85F    /* @0x1E0. This is for boot in RAM mode for STM32F10x High Density devices. */
};


void __Init_Data(void) {
 80001e0:	b480      	push	{r7}
 80001e2:	b083      	sub	sp, #12
 80001e4:	af00      	add	r7, sp, #0
	unsigned long *src, *dst;
	/* copy the data segment into ram */
	src = &_sidata;
 80001e6:	f245 33a0 	movw	r3, #21408	; 0x53a0
 80001ea:	f6c0 0300 	movt	r3, #2048	; 0x800
 80001ee:	607b      	str	r3, [r7, #4]
	dst = &_sdata;
 80001f0:	f240 0300 	movw	r3, #0
 80001f4:	f2c2 0300 	movt	r3, #8192	; 0x2000
 80001f8:	603b      	str	r3, [r7, #0]
	if (src != dst)
 80001fa:	687a      	ldr	r2, [r7, #4]
 80001fc:	683b      	ldr	r3, [r7, #0]
 80001fe:	429a      	cmp	r2, r3
 8000200:	d013      	beq.n	800022a <__Init_Data+0x4a>
		while(dst < &_edata)
 8000202:	e00b      	b.n	800021c <__Init_Data+0x3c>
			*(dst++) = *(src++);
 8000204:	687b      	ldr	r3, [r7, #4]
 8000206:	681a      	ldr	r2, [r3, #0]
 8000208:	683b      	ldr	r3, [r7, #0]
 800020a:	601a      	str	r2, [r3, #0]
 800020c:	683b      	ldr	r3, [r7, #0]
 800020e:	f103 0304 	add.w	r3, r3, #4
 8000212:	603b      	str	r3, [r7, #0]
 8000214:	687b      	ldr	r3, [r7, #4]
 8000216:	f103 0304 	add.w	r3, r3, #4
 800021a:	607b      	str	r3, [r7, #4]
	unsigned long *src, *dst;
	/* copy the data segment into ram */
	src = &_sidata;
	dst = &_sdata;
	if (src != dst)
		while(dst < &_edata)
 800021c:	683a      	ldr	r2, [r7, #0]
 800021e:	f240 0328 	movw	r3, #40	; 0x28
 8000222:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8000226:	429a      	cmp	r2, r3
 8000228:	d3ec      	bcc.n	8000204 <__Init_Data+0x24>
			*(dst++) = *(src++);
	/* zero the bss segment */
	dst = &_sbss;
 800022a:	f240 0328 	movw	r3, #40	; 0x28
 800022e:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8000232:	603b      	str	r3, [r7, #0]
	while(dst < &_ebss)
 8000234:	e007      	b.n	8000246 <__Init_Data+0x66>
		*(dst++) = 0;
 8000236:	683b      	ldr	r3, [r7, #0]
 8000238:	f04f 0200 	mov.w	r2, #0
 800023c:	601a      	str	r2, [r3, #0]
 800023e:	683b      	ldr	r3, [r7, #0]
 8000240:	f103 0304 	add.w	r3, r3, #4
 8000244:	603b      	str	r3, [r7, #0]
	if (src != dst)
		while(dst < &_edata)
			*(dst++) = *(src++);
	/* zero the bss segment */
	dst = &_sbss;
	while(dst < &_ebss)
 8000246:	683a      	ldr	r2, [r7, #0]
 8000248:	f240 0330 	movw	r3, #48	; 0x30
 800024c:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8000250:	429a      	cmp	r2, r3
 8000252:	d3f0      	bcc.n	8000236 <__Init_Data+0x56>
		*(dst++) = 0;
}
 8000254:	f107 070c 	add.w	r7, r7, #12
 8000258:	46bd      	mov	sp, r7
 800025a:	bc80      	pop	{r7}
 800025c:	4770      	bx	lr
 800025e:	bf00      	nop

08000260 <Reset_Handler>:

void set_user_mode();
void Reset_Handler(void) {
 8000260:	4668      	mov	r0, sp
 8000262:	f020 0107 	bic.w	r1, r0, #7
 8000266:	468d      	mov	sp, r1
 8000268:	b589      	push	{r0, r3, r7, lr}
 800026a:	af00      	add	r7, sp, #0
	__Init_Data(); /* Initialize memory, data and bss */
 800026c:	f7ff ffb8 	bl	80001e0 <__Init_Data>
	extern u32 _isr_vectors_offs; /* the offset to the vector table in ram */
	SCB->VTOR = 0x08000000 | ((u32)&_isr_vectors_offs & (u32)0x1FFFFF80); /* set interrupt vector table address */
 8000270:	f44f 436d 	mov.w	r3, #60672	; 0xed00
 8000274:	f2ce 0300 	movt	r3, #57344	; 0xe000
 8000278:	f240 0200 	movw	r2, #0
 800027c:	f2c0 0200 	movt	r2, #0
 8000280:	f022 4268 	bic.w	r2, r2, #3892314112	; 0xe8000000
 8000284:	f022 027f 	bic.w	r2, r2, #127	; 0x7f
 8000288:	f042 6200 	orr.w	r2, r2, #134217728	; 0x8000000
 800028c:	609a      	str	r2, [r3, #8]
	SystemInit(); /* configure the clock */
 800028e:	f001 ff79 	bl	8002184 <SystemInit>
	//userstack_enable();
	set_user_mode();
 8000292:	f004 fc82 	bl	8004b9a <set_user_mode>
	main(); /* start execution of the program */
 8000296:	f000 fa11 	bl	80006bc <main>
	while(1) {}
 800029a:	e7fe      	b.n	800029a <Reset_Handler+0x3a>

0800029c <Default_Handler>:
#pragma weak DMA2_Channel1_IRQHandler       = Default_Handler
#pragma weak DMA2_Channel2_IRQHandler       = Default_Handler
#pragma weak DMA2_Channel3_IRQHandler       = Default_Handler
#pragma weak DMA2_Channel4_5_IRQHandler     = Default_Handler

void Default_Handler(void){
 800029c:	b480      	push	{r7}
 800029e:	af00      	add	r7, sp, #0
	while(1) {}
 80002a0:	e7fe      	b.n	80002a0 <Default_Handler+0x4>
 80002a2:	bf00      	nop

080002a4 <lcd_rst>:
void FSMC_LCD_Init(void);
void GUI_Text(u16 x, u16 y, u8 *str, u16 len,u16 Color, u16 bkColor);
void LCD_Init(void);
void xprintf (const char* str, ...);

void lcd_rst(void){
 80002a4:	b580      	push	{r7, lr}
 80002a6:	af00      	add	r7, sp, #0
	GPIO_ResetBits(GPIOE, GPIO_Pin_1);
 80002a8:	f44f 50c0 	mov.w	r0, #6144	; 0x1800
 80002ac:	f2c4 0001 	movt	r0, #16385	; 0x4001
 80002b0:	f04f 0102 	mov.w	r1, #2
 80002b4:	f003 f908 	bl	80034c8 <GPIO_ResetBits>
    Delay(0xFFF);					   
 80002b8:	f640 70ff 	movw	r0, #4095	; 0xfff
 80002bc:	f000 f80e 	bl	80002dc <Delay>
    GPIO_SetBits(GPIOE, GPIO_Pin_1 );		 	 
 80002c0:	f44f 50c0 	mov.w	r0, #6144	; 0x1800
 80002c4:	f2c4 0001 	movt	r0, #16385	; 0x4001
 80002c8:	f04f 0102 	mov.w	r1, #2
 80002cc:	f003 f8ee 	bl	80034ac <GPIO_SetBits>
	Delay(0xFFF);	
 80002d0:	f640 70ff 	movw	r0, #4095	; 0xfff
 80002d4:	f000 f802 	bl	80002dc <Delay>
}
 80002d8:	bd80      	pop	{r7, pc}
 80002da:	bf00      	nop

080002dc <Delay>:

void Delay(__IO uint32_t nCount)
{
 80002dc:	b480      	push	{r7}
 80002de:	b083      	sub	sp, #12
 80002e0:	af00      	add	r7, sp, #0
 80002e2:	6078      	str	r0, [r7, #4]
  for(; nCount != 0; nCount--);
 80002e4:	e003      	b.n	80002ee <Delay+0x12>
 80002e6:	687b      	ldr	r3, [r7, #4]
 80002e8:	f103 33ff 	add.w	r3, r3, #4294967295
 80002ec:	607b      	str	r3, [r7, #4]
 80002ee:	687b      	ldr	r3, [r7, #4]
 80002f0:	2b00      	cmp	r3, #0
 80002f2:	d1f8      	bne.n	80002e6 <Delay+0xa>
}
 80002f4:	f107 070c 	add.w	r7, r7, #12
 80002f8:	46bd      	mov	sp, r7
 80002fa:	bc80      	pop	{r7}
 80002fc:	4770      	bx	lr
 80002fe:	bf00      	nop

08000300 <Uart_Init>:

void Uart_Init(void)
{
 8000300:	b580      	push	{r7, lr}
 8000302:	b086      	sub	sp, #24
 8000304:	af00      	add	r7, sp, #0
	GPIO_InitTypeDef GPIO_InitStructure;
	USART_InitTypeDef USART_InitStructure;
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;				/* USART1 TX 	*/
 8000306:	f44f 7300 	mov.w	r3, #512	; 0x200
 800030a:	82bb      	strh	r3, [r7, #20]
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
 800030c:	f04f 0318 	mov.w	r3, #24
 8000310:	75fb      	strb	r3, [r7, #23]
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
 8000312:	f04f 0303 	mov.w	r3, #3
 8000316:	75bb      	strb	r3, [r7, #22]
	GPIO_Init(GPIOA, &GPIO_InitStructure);
 8000318:	f107 0314 	add.w	r3, r7, #20
 800031c:	f44f 6000 	mov.w	r0, #2048	; 0x800
 8000320:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000324:	4619      	mov	r1, r3
 8000326:	f002 ff7b 	bl	8003220 <GPIO_Init>
	
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_10;	         	/* USART1 RX 	*/
 800032a:	f44f 6380 	mov.w	r3, #1024	; 0x400
 800032e:	82bb      	strh	r3, [r7, #20]
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
 8000330:	f04f 0304 	mov.w	r3, #4
 8000334:	75fb      	strb	r3, [r7, #23]
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
 8000336:	f04f 0303 	mov.w	r3, #3
 800033a:	75bb      	strb	r3, [r7, #22]
	GPIO_Init(GPIOA, &GPIO_InitStructure);
 800033c:	f107 0314 	add.w	r3, r7, #20
 8000340:	f44f 6000 	mov.w	r0, #2048	; 0x800
 8000344:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000348:	4619      	mov	r1, r3
 800034a:	f002 ff69 	bl	8003220 <GPIO_Init>

  	USART_InitStructure.USART_BaudRate = 9600;
 800034e:	f44f 5316 	mov.w	r3, #9600	; 0x2580
 8000352:	607b      	str	r3, [r7, #4]
 	USART_InitStructure.USART_WordLength = USART_WordLength_8b;
 8000354:	f04f 0300 	mov.w	r3, #0
 8000358:	813b      	strh	r3, [r7, #8]
  	USART_InitStructure.USART_StopBits = USART_StopBits_1;
 800035a:	f04f 0300 	mov.w	r3, #0
 800035e:	817b      	strh	r3, [r7, #10]
  	USART_InitStructure.USART_Parity = USART_Parity_No;
 8000360:	f04f 0300 	mov.w	r3, #0
 8000364:	81bb      	strh	r3, [r7, #12]
  	USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
 8000366:	f04f 0300 	mov.w	r3, #0
 800036a:	823b      	strh	r3, [r7, #16]
 	USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
 800036c:	f04f 030c 	mov.w	r3, #12
 8000370:	81fb      	strh	r3, [r7, #14]

  	/* Configure USART1 */
  	USART_Init(USART1, &USART_InitStructure);
 8000372:	f107 0304 	add.w	r3, r7, #4
 8000376:	f44f 5060 	mov.w	r0, #14336	; 0x3800
 800037a:	f2c4 0001 	movt	r0, #16385	; 0x4001
 800037e:	4619      	mov	r1, r3
 8000380:	f003 ff90 	bl	80042a4 <USART_Init>
	
    /* Enable the USART1 */
 	USART_Cmd(USART1, ENABLE);
 8000384:	f44f 5060 	mov.w	r0, #14336	; 0x3800
 8000388:	f2c4 0001 	movt	r0, #16385	; 0x4001
 800038c:	f04f 0101 	mov.w	r1, #1
 8000390:	f004 f8c6 	bl	8004520 <USART_Cmd>

}
 8000394:	f107 0718 	add.w	r7, r7, #24
 8000398:	46bd      	mov	sp, r7
 800039a:	bd80      	pop	{r7, pc}

0800039c <stm32_gpio_init>:

void stm32_gpio_init(void)
{
 800039c:	b580      	push	{r7, lr}
 800039e:	b082      	sub	sp, #8
 80003a0:	af00      	add	r7, sp, #0
  GPIO_InitTypeDef GPIO_InitStructure;
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6|GPIO_Pin_7;
 80003a2:	f04f 03c0 	mov.w	r3, #192	; 0xc0
 80003a6:	80bb      	strh	r3, [r7, #4]
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
 80003a8:	f04f 0310 	mov.w	r3, #16
 80003ac:	71fb      	strb	r3, [r7, #7]
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
 80003ae:	f04f 0303 	mov.w	r3, #3
 80003b2:	71bb      	strb	r3, [r7, #6]
  GPIO_Init(GPIOC, &GPIO_InitStructure);					 
 80003b4:	f107 0304 	add.w	r3, r7, #4
 80003b8:	f44f 5080 	mov.w	r0, #4096	; 0x1000
 80003bc:	f2c4 0001 	movt	r0, #16385	; 0x4001
 80003c0:	4619      	mov	r1, r3
 80003c2:	f002 ff2d 	bl	8003220 <GPIO_Init>
  
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_1 ;
 80003c6:	f04f 0302 	mov.w	r3, #2
 80003ca:	80bb      	strh	r3, [r7, #4]
  GPIO_Init(GPIOE, &GPIO_InitStructure);  	
 80003cc:	f107 0304 	add.w	r3, r7, #4
 80003d0:	f44f 50c0 	mov.w	r0, #6144	; 0x1800
 80003d4:	f2c4 0001 	movt	r0, #16385	; 0x4001
 80003d8:	4619      	mov	r1, r3
 80003da:	f002 ff21 	bl	8003220 <GPIO_Init>
  
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 | GPIO_Pin_1 | GPIO_Pin_4 | GPIO_Pin_5 |
 80003de:	f24c 7333 	movw	r3, #50995	; 0xc733
 80003e2:	80bb      	strh	r3, [r7, #4]
                                GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10 | GPIO_Pin_14 | 
                                GPIO_Pin_15;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
 80003e4:	f04f 0303 	mov.w	r3, #3
 80003e8:	71bb      	strb	r3, [r7, #6]
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF_PP;
 80003ea:	f04f 0318 	mov.w	r3, #24
 80003ee:	71fb      	strb	r3, [r7, #7]
  GPIO_Init(GPIOD, &GPIO_InitStructure);
 80003f0:	f107 0304 	add.w	r3, r7, #4
 80003f4:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 80003f8:	f2c4 0001 	movt	r0, #16385	; 0x4001
 80003fc:	4619      	mov	r1, r3
 80003fe:	f002 ff0f 	bl	8003220 <GPIO_Init>

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7 | GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10 | 
 8000402:	f64f 7380 	movw	r3, #65408	; 0xff80
 8000406:	80bb      	strh	r3, [r7, #4]
                                GPIO_Pin_11 | GPIO_Pin_12 | GPIO_Pin_13 | GPIO_Pin_14 | 
                                GPIO_Pin_15;
  GPIO_Init(GPIOE, &GPIO_InitStructure);
 8000408:	f107 0304 	add.w	r3, r7, #4
 800040c:	f44f 50c0 	mov.w	r0, #6144	; 0x1800
 8000410:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000414:	4619      	mov	r1, r3
 8000416:	f002 ff03 	bl	8003220 <GPIO_Init>

  /* TFT-CS configuration */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7; 
 800041a:	f04f 0380 	mov.w	r3, #128	; 0x80
 800041e:	80bb      	strh	r3, [r7, #4]
  GPIO_Init(GPIOD, &GPIO_InitStructure);
 8000420:	f107 0304 	add.w	r3, r7, #4
 8000424:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 8000428:	f2c4 0001 	movt	r0, #16385	; 0x4001
 800042c:	4619      	mov	r1, r3
 800042e:	f002 fef7 	bl	8003220 <GPIO_Init>
  
  /* TFT-RS */
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_11;
 8000432:	f44f 6300 	mov.w	r3, #2048	; 0x800
 8000436:	80bb      	strh	r3, [r7, #4]
  GPIO_Init(GPIOD, &GPIO_InitStructure);
 8000438:	f107 0304 	add.w	r3, r7, #4
 800043c:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 8000440:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000444:	4619      	mov	r1, r3
 8000446:	f002 feeb 	bl	8003220 <GPIO_Init>
	
  /* TFT-RST */
  GPIO_SetBits(GPIOD, GPIO_Pin_7);
 800044a:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 800044e:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000452:	f04f 0180 	mov.w	r1, #128	; 0x80
 8000456:	f003 f829 	bl	80034ac <GPIO_SetBits>
  GPIO_SetBits(GPIOD, GPIO_Pin_14| GPIO_Pin_15 |GPIO_Pin_0 | GPIO_Pin_1);
 800045a:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 800045e:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000462:	f24c 0103 	movw	r1, #49155	; 0xc003
 8000466:	f003 f821 	bl	80034ac <GPIO_SetBits>
  GPIO_SetBits(GPIOE, GPIO_Pin_7 | GPIO_Pin_8 | GPIO_Pin_9 | GPIO_Pin_10);
 800046a:	f44f 50c0 	mov.w	r0, #6144	; 0x1800
 800046e:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000472:	f44f 61f0 	mov.w	r1, #1920	; 0x780
 8000476:	f003 f819 	bl	80034ac <GPIO_SetBits>
  GPIO_ResetBits(GPIOE, GPIO_Pin_1);
 800047a:	f44f 50c0 	mov.w	r0, #6144	; 0x1800
 800047e:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000482:	f04f 0102 	mov.w	r1, #2
 8000486:	f003 f81f 	bl	80034c8 <GPIO_ResetBits>
  GPIO_SetBits(GPIOD, GPIO_Pin_4);
 800048a:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 800048e:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000492:	f04f 0110 	mov.w	r1, #16
 8000496:	f003 f809 	bl	80034ac <GPIO_SetBits>
  GPIO_SetBits(GPIOD, GPIO_Pin_5);
 800049a:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 800049e:	f2c4 0001 	movt	r0, #16385	; 0x4001
 80004a2:	f04f 0120 	mov.w	r1, #32
 80004a6:	f003 f801 	bl	80034ac <GPIO_SetBits>
}
 80004aa:	f107 0708 	add.w	r7, r7, #8
 80004ae:	46bd      	mov	sp, r7
 80004b0:	bd80      	pop	{r7, pc}
 80004b2:	bf00      	nop

080004b4 <module_init_test>:
core_init(stm32_gpio_init, "gpio init\n");

void module_init_test()
{
 80004b4:	b580      	push	{r7, lr}
 80004b6:	af00      	add	r7, sp, #0
	xprintf("breshless DC motor project\n");
 80004b8:	f644 30d4 	movw	r0, #19412	; 0x4bd4
 80004bc:	f6c0 0000 	movt	r0, #2048	; 0x800
 80004c0:	f001 fcee 	bl	8001ea0 <xprintf>
}
 80004c4:	bd80      	pop	{r7, pc}
 80004c6:	bf00      	nop

080004c8 <stm32_module_init>:
module_init(NULL, "Hardware fault!!!\n");

extern unsigned long _estack, _eusrstack;

void stm32_module_init()
{
 80004c8:	b580      	push	{r7, lr}
 80004ca:	b082      	sub	sp, #8
 80004cc:	af00      	add	r7, sp, #0
	struct sys_init *p;
	for (p = _module_start; p < _module_end; p++) {
 80004ce:	f644 33b8 	movw	r3, #19384	; 0x4bb8
 80004d2:	f6c0 0300 	movt	r3, #2048	; 0x800
 80004d6:	607b      	str	r3, [r7, #4]
 80004d8:	e00b      	b.n	80004f2 <stm32_module_init+0x2a>
		p->setup();
 80004da:	687b      	ldr	r3, [r7, #4]
 80004dc:	685b      	ldr	r3, [r3, #4]
 80004de:	4798      	blx	r3
		xprintf(p->name);
 80004e0:	687b      	ldr	r3, [r7, #4]
 80004e2:	681b      	ldr	r3, [r3, #0]
 80004e4:	4618      	mov	r0, r3
 80004e6:	f001 fcdb 	bl	8001ea0 <xprintf>
extern unsigned long _estack, _eusrstack;

void stm32_module_init()
{
	struct sys_init *p;
	for (p = _module_start; p < _module_end; p++) {
 80004ea:	687b      	ldr	r3, [r7, #4]
 80004ec:	f103 0308 	add.w	r3, r3, #8
 80004f0:	607b      	str	r3, [r7, #4]
 80004f2:	687a      	ldr	r2, [r7, #4]
 80004f4:	f644 33c8 	movw	r3, #19400	; 0x4bc8
 80004f8:	f6c0 0300 	movt	r3, #2048	; 0x800
 80004fc:	429a      	cmp	r2, r3
 80004fe:	d3ec      	bcc.n	80004da <stm32_module_init+0x12>
		p->setup();
		xprintf(p->name);
	}
}
 8000500:	f107 0708 	add.w	r7, r7, #8
 8000504:	46bd      	mov	sp, r7
 8000506:	bd80      	pop	{r7, pc}

08000508 <stm32_core_init>:

void stm32_core_init()
{
 8000508:	b580      	push	{r7, lr}
 800050a:	b082      	sub	sp, #8
 800050c:	af00      	add	r7, sp, #0
	struct sys_init *p;
	for (p = _core_start; p < _core_end; p++) {
 800050e:	f644 33b0 	movw	r3, #19376	; 0x4bb0
 8000512:	f6c0 0300 	movt	r3, #2048	; 0x800
 8000516:	607b      	str	r3, [r7, #4]
 8000518:	e00b      	b.n	8000532 <stm32_core_init+0x2a>
		p->setup();
 800051a:	687b      	ldr	r3, [r7, #4]
 800051c:	685b      	ldr	r3, [r3, #4]
 800051e:	4798      	blx	r3
		xprintf(p->name);
 8000520:	687b      	ldr	r3, [r7, #4]
 8000522:	681b      	ldr	r3, [r3, #0]
 8000524:	4618      	mov	r0, r3
 8000526:	f001 fcbb 	bl	8001ea0 <xprintf>
}

void stm32_core_init()
{
	struct sys_init *p;
	for (p = _core_start; p < _core_end; p++) {
 800052a:	687b      	ldr	r3, [r7, #4]
 800052c:	f103 0308 	add.w	r3, r3, #8
 8000530:	607b      	str	r3, [r7, #4]
 8000532:	687a      	ldr	r2, [r7, #4]
 8000534:	f644 33b8 	movw	r3, #19384	; 0x4bb8
 8000538:	f6c0 0300 	movt	r3, #2048	; 0x800
 800053c:	429a      	cmp	r2, r3
 800053e:	d3ec      	bcc.n	800051a <stm32_core_init+0x12>
		p->setup();
		xprintf(p->name);
	}
}
 8000540:	f107 0708 	add.w	r7, r7, #8
 8000544:	46bd      	mov	sp, r7
 8000546:	bd80      	pop	{r7, pc}

08000548 <dump_stack>:

void dump_stack(int sp, int fp)
{
 8000548:	b580      	push	{r7, lr}
 800054a:	b084      	sub	sp, #16
 800054c:	af00      	add	r7, sp, #0
 800054e:	6078      	str	r0, [r7, #4]
 8000550:	6039      	str	r1, [r7, #0]
	int i = 0;
 8000552:	f04f 0300 	mov.w	r3, #0
 8000556:	60fb      	str	r3, [r7, #12]
	xprintf("======================================\n");
 8000558:	f644 401c 	movw	r0, #19484	; 0x4c1c
 800055c:	f6c0 0000 	movt	r0, #2048	; 0x800
 8000560:	f001 fc9e 	bl	8001ea0 <xprintf>
	xprintf("FP: 0x%x Stack dump: 0x%x - 0x%x\n", fp, sp, &_eusrstack);
 8000564:	f644 4044 	movw	r0, #19524	; 0x4c44
 8000568:	f6c0 0000 	movt	r0, #2048	; 0x800
 800056c:	6839      	ldr	r1, [r7, #0]
 800056e:	687a      	ldr	r2, [r7, #4]
 8000570:	f241 0330 	movw	r3, #4144	; 0x1030
 8000574:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8000578:	f001 fc92 	bl	8001ea0 <xprintf>
	xprintf("R0   : 0x%8x\n", *(int *)(sp + 0));
 800057c:	687b      	ldr	r3, [r7, #4]
 800057e:	681b      	ldr	r3, [r3, #0]
 8000580:	f644 4068 	movw	r0, #19560	; 0x4c68
 8000584:	f6c0 0000 	movt	r0, #2048	; 0x800
 8000588:	4619      	mov	r1, r3
 800058a:	f001 fc89 	bl	8001ea0 <xprintf>
	xprintf("R1   : 0x%8x\n", *(int *)(sp + 4));
 800058e:	687b      	ldr	r3, [r7, #4]
 8000590:	f103 0304 	add.w	r3, r3, #4
 8000594:	681b      	ldr	r3, [r3, #0]
 8000596:	f644 4078 	movw	r0, #19576	; 0x4c78
 800059a:	f6c0 0000 	movt	r0, #2048	; 0x800
 800059e:	4619      	mov	r1, r3
 80005a0:	f001 fc7e 	bl	8001ea0 <xprintf>
	xprintf("R2   : 0x%8x\n", *(int *)(sp + 8));
 80005a4:	687b      	ldr	r3, [r7, #4]
 80005a6:	f103 0308 	add.w	r3, r3, #8
 80005aa:	681b      	ldr	r3, [r3, #0]
 80005ac:	f644 4088 	movw	r0, #19592	; 0x4c88
 80005b0:	f6c0 0000 	movt	r0, #2048	; 0x800
 80005b4:	4619      	mov	r1, r3
 80005b6:	f001 fc73 	bl	8001ea0 <xprintf>
	xprintf("R3   : 0x%8x\n", *(int *)(sp + 12));
 80005ba:	687b      	ldr	r3, [r7, #4]
 80005bc:	f103 030c 	add.w	r3, r3, #12
 80005c0:	681b      	ldr	r3, [r3, #0]
 80005c2:	f644 4098 	movw	r0, #19608	; 0x4c98
 80005c6:	f6c0 0000 	movt	r0, #2048	; 0x800
 80005ca:	4619      	mov	r1, r3
 80005cc:	f001 fc68 	bl	8001ea0 <xprintf>
	xprintf("R12  : 0x%8x\n", *(int *)(sp + 16));
 80005d0:	687b      	ldr	r3, [r7, #4]
 80005d2:	f103 0310 	add.w	r3, r3, #16
 80005d6:	681b      	ldr	r3, [r3, #0]
 80005d8:	f644 40a8 	movw	r0, #19624	; 0x4ca8
 80005dc:	f6c0 0000 	movt	r0, #2048	; 0x800
 80005e0:	4619      	mov	r1, r3
 80005e2:	f001 fc5d 	bl	8001ea0 <xprintf>
	xprintf("LR   : 0x%8x\n", *(int *)(sp + 20));
 80005e6:	687b      	ldr	r3, [r7, #4]
 80005e8:	f103 0314 	add.w	r3, r3, #20
 80005ec:	681b      	ldr	r3, [r3, #0]
 80005ee:	f644 40b8 	movw	r0, #19640	; 0x4cb8
 80005f2:	f6c0 0000 	movt	r0, #2048	; 0x800
 80005f6:	4619      	mov	r1, r3
 80005f8:	f001 fc52 	bl	8001ea0 <xprintf>
	xprintf("PC   : 0x%8x\n", *(int *)(sp + 24));
 80005fc:	687b      	ldr	r3, [r7, #4]
 80005fe:	f103 0318 	add.w	r3, r3, #24
 8000602:	681b      	ldr	r3, [r3, #0]
 8000604:	f644 40c8 	movw	r0, #19656	; 0x4cc8
 8000608:	f6c0 0000 	movt	r0, #2048	; 0x800
 800060c:	4619      	mov	r1, r3
 800060e:	f001 fc47 	bl	8001ea0 <xprintf>
	xprintf("xPSR : 0x%8x\n", *(int *)(sp + 28));
 8000612:	687b      	ldr	r3, [r7, #4]
 8000614:	f103 031c 	add.w	r3, r3, #28
 8000618:	681b      	ldr	r3, [r3, #0]
 800061a:	f644 40d8 	movw	r0, #19672	; 0x4cd8
 800061e:	f6c0 0000 	movt	r0, #2048	; 0x800
 8000622:	4619      	mov	r1, r3
 8000624:	f001 fc3c 	bl	8001ea0 <xprintf>
	xprintf("memory:\n");
 8000628:	f644 40e8 	movw	r0, #19688	; 0x4ce8
 800062c:	f6c0 0000 	movt	r0, #2048	; 0x800
 8000630:	f001 fc36 	bl	8001ea0 <xprintf>
	int address = sp & (0xFFFFFFE0);
 8000634:	687b      	ldr	r3, [r7, #4]
 8000636:	f023 031f 	bic.w	r3, r3, #31
 800063a:	60bb      	str	r3, [r7, #8]
	if ((sp & 0x1F) != 0)
 800063c:	687b      	ldr	r3, [r7, #4]
 800063e:	f003 031f 	and.w	r3, r3, #31
 8000642:	2b00      	cmp	r3, #0
 8000644:	d006      	beq.n	8000654 <dump_stack+0x10c>
		xprintf("0x%8x :", address);
 8000646:	f644 40f4 	movw	r0, #19700	; 0x4cf4
 800064a:	f6c0 0000 	movt	r0, #2048	; 0x800
 800064e:	68b9      	ldr	r1, [r7, #8]
 8000650:	f001 fc26 	bl	8001ea0 <xprintf>
	
	for (i = address; i <= &_eusrstack; ) {
 8000654:	68bb      	ldr	r3, [r7, #8]
 8000656:	60fb      	str	r3, [r7, #12]
 8000658:	e022      	b.n	80006a0 <dump_stack+0x158>
		if (i < sp)
 800065a:	68fa      	ldr	r2, [r7, #12]
 800065c:	687b      	ldr	r3, [r7, #4]
 800065e:	429a      	cmp	r2, r3
 8000660:	da05      	bge.n	800066e <dump_stack+0x126>
			xprintf("---------- ");
 8000662:	f644 40fc 	movw	r0, #19708	; 0x4cfc
 8000666:	f6c0 0000 	movt	r0, #2048	; 0x800
 800066a:	f001 fc19 	bl	8001ea0 <xprintf>
		if ((i & 0x1F) == 0)
 800066e:	68fb      	ldr	r3, [r7, #12]
 8000670:	f003 031f 	and.w	r3, r3, #31
 8000674:	2b00      	cmp	r3, #0
 8000676:	d106      	bne.n	8000686 <dump_stack+0x13e>
			xprintf("\n0x%8x :", i);
 8000678:	f644 5008 	movw	r0, #19720	; 0x4d08
 800067c:	f6c0 0000 	movt	r0, #2048	; 0x800
 8000680:	68f9      	ldr	r1, [r7, #12]
 8000682:	f001 fc0d 	bl	8001ea0 <xprintf>
		xprintf("0x%8x ", *(int *)i);
 8000686:	68fb      	ldr	r3, [r7, #12]
 8000688:	681b      	ldr	r3, [r3, #0]
 800068a:	f644 5014 	movw	r0, #19732	; 0x4d14
 800068e:	f6c0 0000 	movt	r0, #2048	; 0x800
 8000692:	4619      	mov	r1, r3
 8000694:	f001 fc04 	bl	8001ea0 <xprintf>
		i = i + 4;
 8000698:	68fb      	ldr	r3, [r7, #12]
 800069a:	f103 0304 	add.w	r3, r3, #4
 800069e:	60fb      	str	r3, [r7, #12]
	xprintf("memory:\n");
	int address = sp & (0xFFFFFFE0);
	if ((sp & 0x1F) != 0)
		xprintf("0x%8x :", address);
	
	for (i = address; i <= &_eusrstack; ) {
 80006a0:	68fa      	ldr	r2, [r7, #12]
 80006a2:	f241 0330 	movw	r3, #4144	; 0x1030
 80006a6:	f2c2 0300 	movt	r3, #8192	; 0x2000
 80006aa:	429a      	cmp	r2, r3
 80006ac:	d9d5      	bls.n	800065a <dump_stack+0x112>
		if ((i & 0x1F) == 0)
			xprintf("\n0x%8x :", i);
		xprintf("0x%8x ", *(int *)i);
		i = i + 4;
	}
	xprintf("\n======================================\n");
 80006ae:	f644 501c 	movw	r0, #19740	; 0x4d1c
 80006b2:	f6c0 0000 	movt	r0, #2048	; 0x800
 80006b6:	f001 fbf3 	bl	8001ea0 <xprintf>
	while(1);
 80006ba:	e7fe      	b.n	80006ba <dump_stack+0x172>

080006bc <main>:
}

int main(int argc, char *argv[])
{
 80006bc:	b580      	push	{r7, lr}
 80006be:	b086      	sub	sp, #24
 80006c0:	af02      	add	r7, sp, #8
 80006c2:	6078      	str	r0, [r7, #4]
 80006c4:	6039      	str	r1, [r7, #0]
	GPIO_InitTypeDef GPIO_InitStructure;
	u32 delay;

  	RCC_APB2PeriphClockCmd( RCC_APB2Periph_USART1 |RCC_APB2Periph_GPIOA | RCC_APB2Periph_GPIOB |
 80006c6:	f244 007d 	movw	r0, #16509	; 0x407d
 80006ca:	f04f 0101 	mov.w	r1, #1
 80006ce:	f003 fc1b 	bl	8003f08 <RCC_APB2PeriphClockCmd>
                         RCC_APB2Periph_GPIOC | RCC_APB2Periph_GPIOD |
                         RCC_APB2Periph_GPIOE | RCC_APB2Periph_AFIO, ENABLE);
	
  	Uart_Init();
 80006d2:	f7ff fe15 	bl	8000300 <Uart_Init>
	stm32_core_init();
 80006d6:	f7ff ff17 	bl	8000508 <stm32_core_init>
	
  	FSMC_LCD_Init();
 80006da:	f000 f84f 	bl	800077c <FSMC_LCD_Init>
  	LCD_Init();
 80006de:	f001 f887 	bl	80017f0 <LCD_Init>
  	
  	GUI_Text(0, 0, (u8 *)"********BIKE SPEED PROJECT******",
 80006e2:	f04f 0300 	mov.w	r3, #0
 80006e6:	9300      	str	r3, [sp, #0]
 80006e8:	f64f 73ff 	movw	r3, #65535	; 0xffff
 80006ec:	9301      	str	r3, [sp, #4]
 80006ee:	f04f 0000 	mov.w	r0, #0
 80006f2:	f04f 0100 	mov.w	r1, #0
 80006f6:	f644 5248 	movw	r2, #19784	; 0x4d48
 80006fa:	f6c0 0200 	movt	r2, #2048	; 0x800
 80006fe:	f04f 0320 	mov.w	r3, #32
 8000702:	f000 f8c1 	bl	8000888 <GUI_Text>
		strlen("********BIKE SPEED PROJECT******"),0, 0xFFFF);
	
	while(1)
	{
		delay = 500000;
 8000706:	f24a 1320 	movw	r3, #41248	; 0xa120
 800070a:	f2c0 0307 	movt	r3, #7
 800070e:	60fb      	str	r3, [r7, #12]
		xprintf("_eusrstack: 0x%x, _estack: 0x%x\n", &_eusrstack, &_estack);
 8000710:	f644 506c 	movw	r0, #19820	; 0x4d6c
 8000714:	f6c0 0000 	movt	r0, #2048	; 0x800
 8000718:	f241 0130 	movw	r1, #4144	; 0x1030
 800071c:	f2c2 0100 	movt	r1, #8192	; 0x2000
 8000720:	f64f 72ff 	movw	r2, #65535	; 0xffff
 8000724:	f2c2 0200 	movt	r2, #8192	; 0x2000
 8000728:	f001 fbba 	bl	8001ea0 <xprintf>
		stm32_module_init();
 800072c:	f7ff fecc 	bl	80004c8 <stm32_module_init>
		
		while(delay)
 8000730:	e003      	b.n	800073a <main+0x7e>
		{
			delay--;
 8000732:	68fb      	ldr	r3, [r7, #12]
 8000734:	f103 33ff 	add.w	r3, r3, #4294967295
 8000738:	60fb      	str	r3, [r7, #12]
	{
		delay = 500000;
		xprintf("_eusrstack: 0x%x, _estack: 0x%x\n", &_eusrstack, &_estack);
		stm32_module_init();
		
		while(delay)
 800073a:	68fb      	ldr	r3, [r7, #12]
 800073c:	2b00      	cmp	r3, #0
 800073e:	d1f8      	bne.n	8000732 <main+0x76>
		{
			delay--;
		}
		GPIO_SetBits(GPIOC, GPIO_Pin_6);
 8000740:	f44f 5080 	mov.w	r0, #4096	; 0x1000
 8000744:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000748:	f04f 0140 	mov.w	r1, #64	; 0x40
 800074c:	f002 feae 	bl	80034ac <GPIO_SetBits>
		delay = 500000;
 8000750:	f24a 1320 	movw	r3, #41248	; 0xa120
 8000754:	f2c0 0307 	movt	r3, #7
 8000758:	60fb      	str	r3, [r7, #12]
		while(delay)
 800075a:	e003      	b.n	8000764 <main+0xa8>
		{
			delay--;
 800075c:	68fb      	ldr	r3, [r7, #12]
 800075e:	f103 33ff 	add.w	r3, r3, #4294967295
 8000762:	60fb      	str	r3, [r7, #12]
		{
			delay--;
		}
		GPIO_SetBits(GPIOC, GPIO_Pin_6);
		delay = 500000;
		while(delay)
 8000764:	68fb      	ldr	r3, [r7, #12]
 8000766:	2b00      	cmp	r3, #0
 8000768:	d1f8      	bne.n	800075c <main+0xa0>
		{
			delay--;
		}
		GPIO_ResetBits(GPIOC, GPIO_Pin_6);
 800076a:	f44f 5080 	mov.w	r0, #4096	; 0x1000
 800076e:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8000772:	f04f 0140 	mov.w	r1, #64	; 0x40
 8000776:	f002 fea7 	bl	80034c8 <GPIO_ResetBits>
	}
 800077a:	e7c4      	b.n	8000706 <main+0x4a>

0800077c <FSMC_LCD_Init>:
  *         on the SRAM.
  * @param  None 
  * @retval : None
  */
void FSMC_LCD_Init(void)
{
 800077c:	b580      	push	{r7, lr}
 800077e:	b096      	sub	sp, #88	; 0x58
 8000780:	af00      	add	r7, sp, #0
  FSMC_NORSRAMInitTypeDef  FSMC_NORSRAMInitStructure;
  FSMC_NORSRAMTimingInitTypeDef  p;
  //GPIO_InitTypeDef GPIO_InitStructure; 
  
  RCC_AHBPeriphClockCmd(RCC_AHBPeriph_FSMC, ENABLE);
 8000782:	f44f 7080 	mov.w	r0, #256	; 0x100
 8000786:	f04f 0101 	mov.w	r1, #1
 800078a:	f003 fb93 	bl	8003eb4 <RCC_AHBPeriphClockCmd>

  p.FSMC_AddressSetupTime = 0x02;
 800078e:	f04f 0302 	mov.w	r3, #2
 8000792:	603b      	str	r3, [r7, #0]
  p.FSMC_AddressHoldTime = 0x00;
 8000794:	f04f 0300 	mov.w	r3, #0
 8000798:	607b      	str	r3, [r7, #4]
  p.FSMC_DataSetupTime = 0x05;
 800079a:	f04f 0305 	mov.w	r3, #5
 800079e:	60bb      	str	r3, [r7, #8]
  p.FSMC_BusTurnAroundDuration = 0x00;
 80007a0:	f04f 0300 	mov.w	r3, #0
 80007a4:	60fb      	str	r3, [r7, #12]
  p.FSMC_CLKDivision = 0x00;
 80007a6:	f04f 0300 	mov.w	r3, #0
 80007aa:	613b      	str	r3, [r7, #16]
  p.FSMC_DataLatency = 0x00;
 80007ac:	f04f 0300 	mov.w	r3, #0
 80007b0:	617b      	str	r3, [r7, #20]
  p.FSMC_AccessMode = FSMC_AccessMode_B;
 80007b2:	f04f 5380 	mov.w	r3, #268435456	; 0x10000000
 80007b6:	61bb      	str	r3, [r7, #24]

  FSMC_NORSRAMInitStructure.FSMC_Bank = FSMC_Bank1_NORSRAM1;
 80007b8:	f04f 0300 	mov.w	r3, #0
 80007bc:	61fb      	str	r3, [r7, #28]
  FSMC_NORSRAMInitStructure.FSMC_DataAddressMux = FSMC_DataAddressMux_Disable;
 80007be:	f04f 0300 	mov.w	r3, #0
 80007c2:	623b      	str	r3, [r7, #32]
  FSMC_NORSRAMInitStructure.FSMC_MemoryType = FSMC_MemoryType_NOR;
 80007c4:	f04f 0308 	mov.w	r3, #8
 80007c8:	627b      	str	r3, [r7, #36]	; 0x24
  FSMC_NORSRAMInitStructure.FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_16b;
 80007ca:	f04f 0310 	mov.w	r3, #16
 80007ce:	62bb      	str	r3, [r7, #40]	; 0x28
  FSMC_NORSRAMInitStructure.FSMC_BurstAccessMode = FSMC_BurstAccessMode_Disable;
 80007d0:	f04f 0300 	mov.w	r3, #0
 80007d4:	62fb      	str	r3, [r7, #44]	; 0x2c
  FSMC_NORSRAMInitStructure.FSMC_WaitSignalPolarity = FSMC_WaitSignalPolarity_Low;
 80007d6:	f04f 0300 	mov.w	r3, #0
 80007da:	637b      	str	r3, [r7, #52]	; 0x34
  FSMC_NORSRAMInitStructure.FSMC_WrapMode = FSMC_WrapMode_Disable;
 80007dc:	f04f 0300 	mov.w	r3, #0
 80007e0:	63bb      	str	r3, [r7, #56]	; 0x38
  FSMC_NORSRAMInitStructure.FSMC_WaitSignalActive = FSMC_WaitSignalActive_BeforeWaitState;
 80007e2:	f04f 0300 	mov.w	r3, #0
 80007e6:	63fb      	str	r3, [r7, #60]	; 0x3c
  FSMC_NORSRAMInitStructure.FSMC_WriteOperation = FSMC_WriteOperation_Enable;
 80007e8:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80007ec:	643b      	str	r3, [r7, #64]	; 0x40
  FSMC_NORSRAMInitStructure.FSMC_WaitSignal = FSMC_WaitSignal_Disable;
 80007ee:	f04f 0300 	mov.w	r3, #0
 80007f2:	647b      	str	r3, [r7, #68]	; 0x44
  FSMC_NORSRAMInitStructure.FSMC_ExtendedMode = FSMC_ExtendedMode_Disable;
 80007f4:	f04f 0300 	mov.w	r3, #0
 80007f8:	64bb      	str	r3, [r7, #72]	; 0x48
  FSMC_NORSRAMInitStructure.FSMC_WriteBurst = FSMC_WriteBurst_Disable;
 80007fa:	f04f 0300 	mov.w	r3, #0
 80007fe:	64fb      	str	r3, [r7, #76]	; 0x4c
  FSMC_NORSRAMInitStructure.FSMC_ReadWriteTimingStruct = &p;
 8000800:	463b      	mov	r3, r7
 8000802:	653b      	str	r3, [r7, #80]	; 0x50
  FSMC_NORSRAMInitStructure.FSMC_WriteTimingStruct = &p;	  
 8000804:	463b      	mov	r3, r7
 8000806:	657b      	str	r3, [r7, #84]	; 0x54

 

 

  FSMC_NORSRAMInit(&FSMC_NORSRAMInitStructure); 
 8000808:	f107 031c 	add.w	r3, r7, #28
 800080c:	4618      	mov	r0, r3
 800080e:	f001 ff29 	bl	8002664 <FSMC_NORSRAMInit>

  /* Enable FSMC Bank1_SRAM Bank */
  FSMC_NORSRAMCmd(FSMC_Bank1_NORSRAM1, ENABLE);  
 8000812:	f04f 0000 	mov.w	r0, #0
 8000816:	f04f 0101 	mov.w	r1, #1
 800081a:	f002 f9d9 	bl	8002bd0 <FSMC_NORSRAMCmd>
}
 800081e:	f107 0758 	add.w	r7, r7, #88	; 0x58
 8000822:	46bd      	mov	sp, r7
 8000824:	bd80      	pop	{r7, pc}
 8000826:	bf00      	nop

08000828 <GUI_Color565>:
* 出口参数：返回16位RGB颜色值。
* 说    明：
* 调用方法：i=GUI_Color565(0xafafaf);
****************************************************************************/
u16 GUI_Color565(u32 RGB)
{
 8000828:	b480      	push	{r7}
 800082a:	b085      	sub	sp, #20
 800082c:	af00      	add	r7, sp, #0
 800082e:	6078      	str	r0, [r7, #4]
  u8  r, g, b;

  b = ( RGB >> (0+3) ) & 0x1f;		// 取B色的高5位
 8000830:	687b      	ldr	r3, [r7, #4]
 8000832:	ea4f 03d3 	mov.w	r3, r3, lsr #3
 8000836:	b2db      	uxtb	r3, r3
 8000838:	f003 031f 	and.w	r3, r3, #31
 800083c:	73fb      	strb	r3, [r7, #15]
  g = ( RGB >> (8+2) ) & 0x3f;		// 取G色的高6位
 800083e:	687b      	ldr	r3, [r7, #4]
 8000840:	ea4f 2393 	mov.w	r3, r3, lsr #10
 8000844:	b2db      	uxtb	r3, r3
 8000846:	f003 033f 	and.w	r3, r3, #63	; 0x3f
 800084a:	73bb      	strb	r3, [r7, #14]
  r = ( RGB >> (16+3)) & 0x1f;		// 取R色的高5位
 800084c:	687b      	ldr	r3, [r7, #4]
 800084e:	ea4f 43d3 	mov.w	r3, r3, lsr #19
 8000852:	b2db      	uxtb	r3, r3
 8000854:	f003 031f 	and.w	r3, r3, #31
 8000858:	737b      	strb	r3, [r7, #13]
   
  return( (r<<11) + (g<<5) + (b<<0) );		
 800085a:	7b7b      	ldrb	r3, [r7, #13]
 800085c:	b29b      	uxth	r3, r3
 800085e:	ea4f 23c3 	mov.w	r3, r3, lsl #11
 8000862:	b29a      	uxth	r2, r3
 8000864:	7bbb      	ldrb	r3, [r7, #14]
 8000866:	b29b      	uxth	r3, r3
 8000868:	ea4f 1343 	mov.w	r3, r3, lsl #5
 800086c:	b29b      	uxth	r3, r3
 800086e:	18d3      	adds	r3, r2, r3
 8000870:	b29a      	uxth	r2, r3
 8000872:	7bfb      	ldrb	r3, [r7, #15]
 8000874:	b29b      	uxth	r3, r3
 8000876:	18d3      	adds	r3, r2, r3
 8000878:	b29b      	uxth	r3, r3
}
 800087a:	4618      	mov	r0, r3
 800087c:	f107 0714 	add.w	r7, r7, #20
 8000880:	46bd      	mov	sp, r7
 8000882:	bc80      	pop	{r7}
 8000884:	4770      	bx	lr
 8000886:	bf00      	nop

08000888 <GUI_Text>:
* 出口参数：无
* 说    明：
* 调用方法：GUI_Text(0,0,"0123456789",10,0x0000,0xffff);
****************************************************************************/
void GUI_Text(u16 x, u16 y, u8 *str, u16 len,u16 Color, u16 bkColor)
{
 8000888:	b590      	push	{r4, r7, lr}
 800088a:	b089      	sub	sp, #36	; 0x24
 800088c:	af02      	add	r7, sp, #8
 800088e:	60ba      	str	r2, [r7, #8]
 8000890:	4602      	mov	r2, r0
 8000892:	81fa      	strh	r2, [r7, #14]
 8000894:	460a      	mov	r2, r1
 8000896:	81ba      	strh	r2, [r7, #12]
 8000898:	80fb      	strh	r3, [r7, #6]
  u8 i;
  
  for (i=0;i<len;i++)
 800089a:	f04f 0300 	mov.w	r3, #0
 800089e:	75fb      	strb	r3, [r7, #23]
 80008a0:	e017      	b.n	80008d2 <GUI_Text+0x4a>
  {
    ili9320_PutChar((x+8*i),y,*str++,Color,bkColor);
 80008a2:	7dfb      	ldrb	r3, [r7, #23]
 80008a4:	b29b      	uxth	r3, r3
 80008a6:	ea4f 03c3 	mov.w	r3, r3, lsl #3
 80008aa:	b29a      	uxth	r2, r3
 80008ac:	89fb      	ldrh	r3, [r7, #14]
 80008ae:	18d3      	adds	r3, r2, r3
 80008b0:	b298      	uxth	r0, r3
 80008b2:	68bb      	ldr	r3, [r7, #8]
 80008b4:	781a      	ldrb	r2, [r3, #0]
 80008b6:	68bb      	ldr	r3, [r7, #8]
 80008b8:	f103 0301 	add.w	r3, r3, #1
 80008bc:	60bb      	str	r3, [r7, #8]
 80008be:	89b9      	ldrh	r1, [r7, #12]
 80008c0:	8d3b      	ldrh	r3, [r7, #40]	; 0x28
 80008c2:	8dbc      	ldrh	r4, [r7, #44]	; 0x2c
 80008c4:	9400      	str	r4, [sp, #0]
 80008c6:	f000 fddf 	bl	8001488 <ili9320_PutChar>
****************************************************************************/
void GUI_Text(u16 x, u16 y, u8 *str, u16 len,u16 Color, u16 bkColor)
{
  u8 i;
  
  for (i=0;i<len;i++)
 80008ca:	7dfb      	ldrb	r3, [r7, #23]
 80008cc:	f103 0301 	add.w	r3, r3, #1
 80008d0:	75fb      	strb	r3, [r7, #23]
 80008d2:	7dfb      	ldrb	r3, [r7, #23]
 80008d4:	b29b      	uxth	r3, r3
 80008d6:	88fa      	ldrh	r2, [r7, #6]
 80008d8:	429a      	cmp	r2, r3
 80008da:	d8e2      	bhi.n	80008a2 <GUI_Text+0x1a>
  {
    ili9320_PutChar((x+8*i),y,*str++,Color,bkColor);
  }
}
 80008dc:	f107 071c 	add.w	r7, r7, #28
 80008e0:	46bd      	mov	sp, r7
 80008e2:	bd90      	pop	{r4, r7, pc}

080008e4 <GUI_Chn>:

void GUI_Chn(u16 x, u16 y, u8 *str, u16 len, u16 Color, u16 bkColor)
{
 80008e4:	b580      	push	{r7, lr}
 80008e6:	b090      	sub	sp, #64	; 0x40
 80008e8:	af00      	add	r7, sp, #0
 80008ea:	60ba      	str	r2, [r7, #8]
 80008ec:	4602      	mov	r2, r0
 80008ee:	81fa      	strh	r2, [r7, #14]
 80008f0:	460a      	mov	r2, r1
 80008f2:	81ba      	strh	r2, [r7, #12]
 80008f4:	80fb      	strh	r3, [r7, #6]
	int i = 0;
 80008f6:	f04f 0300 	mov.w	r3, #0
 80008fa:	63fb      	str	r3, [r7, #60]	; 0x3c
	u32 offset;
	unsigned char buf[32];
	unsigned char qh, wh, m, n, j;

	for(i = 0; i < len / 2; i++)
 80008fc:	f04f 0300 	mov.w	r3, #0
 8000900:	63fb      	str	r3, [r7, #60]	; 0x3c
 8000902:	e0c2      	b.n	8000a8a <GUI_Chn+0x1a6>
	{
		qh = *(str + 2 * i) - 0xa0;
 8000904:	6bfb      	ldr	r3, [r7, #60]	; 0x3c
 8000906:	ea4f 0343 	mov.w	r3, r3, lsl #1
 800090a:	68ba      	ldr	r2, [r7, #8]
 800090c:	18d3      	adds	r3, r2, r3
 800090e:	781b      	ldrb	r3, [r3, #0]
 8000910:	f103 0360 	add.w	r3, r3, #96	; 0x60
 8000914:	f887 3038 	strb.w	r3, [r7, #56]	; 0x38
   		wh = *(str + 2 * i + 1) - 0xa0;	
 8000918:	6bfb      	ldr	r3, [r7, #60]	; 0x3c
 800091a:	ea4f 0343 	mov.w	r3, r3, lsl #1
 800091e:	f103 0301 	add.w	r3, r3, #1
 8000922:	68ba      	ldr	r2, [r7, #8]
 8000924:	18d3      	adds	r3, r2, r3
 8000926:	781b      	ldrb	r3, [r3, #0]
 8000928:	f103 0360 	add.w	r3, r3, #96	; 0x60
 800092c:	f887 3037 	strb.w	r3, [r7, #55]	; 0x37
		offset = (94 * (qh - 1) + (wh - 1)) * 32;
 8000930:	f897 3038 	ldrb.w	r3, [r7, #56]	; 0x38
 8000934:	f103 33ff 	add.w	r3, r3, #4294967295
 8000938:	f04f 025e 	mov.w	r2, #94	; 0x5e
 800093c:	fb02 f203 	mul.w	r2, r2, r3
 8000940:	f897 3037 	ldrb.w	r3, [r7, #55]	; 0x37
 8000944:	f103 33ff 	add.w	r3, r3, #4294967295
 8000948:	18d3      	adds	r3, r2, r3
 800094a:	ea4f 1343 	mov.w	r3, r3, lsl #5
 800094e:	633b      	str	r3, [r7, #48]	; 0x30
		memcpy(buf, (unsigned char const*)(HZK_FLASH_BASE + offset), 32);
 8000950:	6b3b      	ldr	r3, [r7, #48]	; 0x30
 8000952:	f103 6300 	add.w	r3, r3, #134217728	; 0x8000000
 8000956:	f503 3340 	add.w	r3, r3, #196608	; 0x30000
 800095a:	f107 0210 	add.w	r2, r7, #16
 800095e:	4611      	mov	r1, r2
 8000960:	461a      	mov	r2, r3
 8000962:	f04f 0320 	mov.w	r3, #32
 8000966:	4608      	mov	r0, r1
 8000968:	4611      	mov	r1, r2
 800096a:	461a      	mov	r2, r3
 800096c:	f001 fbc6 	bl	80020fc <memcpy>

		for (m = 0; m < 16; m++)
 8000970:	f04f 0300 	mov.w	r3, #0
 8000974:	f887 303b 	strb.w	r3, [r7, #59]	; 0x3b
 8000978:	e07e      	b.n	8000a78 <GUI_Chn+0x194>
			for(n = 0; n < 2; n++)
 800097a:	f04f 0300 	mov.w	r3, #0
 800097e:	f887 303a 	strb.w	r3, [r7, #58]	; 0x3a
 8000982:	e06f      	b.n	8000a64 <GUI_Chn+0x180>
			{
				for(j = 0; j < 8; j++)
 8000984:	f04f 0300 	mov.w	r3, #0
 8000988:	f887 3039 	strb.w	r3, [r7, #57]	; 0x39
 800098c:	e060      	b.n	8000a50 <GUI_Chn+0x16c>
				{
					if (buf[m * 2 + n] & (0x80 >> j))
 800098e:	f897 303b 	ldrb.w	r3, [r7, #59]	; 0x3b
 8000992:	ea4f 0243 	mov.w	r2, r3, lsl #1
 8000996:	f897 303a 	ldrb.w	r3, [r7, #58]	; 0x3a
 800099a:	18d3      	adds	r3, r2, r3
 800099c:	f107 0240 	add.w	r2, r7, #64	; 0x40
 80009a0:	18d3      	adds	r3, r2, r3
 80009a2:	f813 3c30 	ldrb.w	r3, [r3, #-48]
 80009a6:	461a      	mov	r2, r3
 80009a8:	f897 3039 	ldrb.w	r3, [r7, #57]	; 0x39
 80009ac:	f04f 0180 	mov.w	r1, #128	; 0x80
 80009b0:	fa41 f303 	asr.w	r3, r1, r3
 80009b4:	4013      	ands	r3, r2
 80009b6:	2b00      	cmp	r3, #0
 80009b8:	d022      	beq.n	8000a00 <GUI_Chn+0x11c>
						ili9320_SetPoint(i * 16 + x + j + n * 8, y + m, Color); // 字符颜色
 80009ba:	6bfb      	ldr	r3, [r7, #60]	; 0x3c
 80009bc:	b29b      	uxth	r3, r3
 80009be:	ea4f 1303 	mov.w	r3, r3, lsl #4
 80009c2:	b29a      	uxth	r2, r3
 80009c4:	89fb      	ldrh	r3, [r7, #14]
 80009c6:	18d3      	adds	r3, r2, r3
 80009c8:	b29a      	uxth	r2, r3
 80009ca:	f897 3039 	ldrb.w	r3, [r7, #57]	; 0x39
 80009ce:	b29b      	uxth	r3, r3
 80009d0:	18d3      	adds	r3, r2, r3
 80009d2:	b29a      	uxth	r2, r3
 80009d4:	f897 303a 	ldrb.w	r3, [r7, #58]	; 0x3a
 80009d8:	b29b      	uxth	r3, r3
 80009da:	ea4f 03c3 	mov.w	r3, r3, lsl #3
 80009de:	b29b      	uxth	r3, r3
 80009e0:	18d3      	adds	r3, r2, r3
 80009e2:	b299      	uxth	r1, r3
 80009e4:	f897 303b 	ldrb.w	r3, [r7, #59]	; 0x3b
 80009e8:	b29a      	uxth	r2, r3
 80009ea:	89bb      	ldrh	r3, [r7, #12]
 80009ec:	18d3      	adds	r3, r2, r3
 80009ee:	b29a      	uxth	r2, r3
 80009f0:	f8b7 3048 	ldrh.w	r3, [r7, #72]	; 0x48
 80009f4:	4608      	mov	r0, r1
 80009f6:	4611      	mov	r1, r2
 80009f8:	461a      	mov	r2, r3
 80009fa:	f000 fcef 	bl	80013dc <ili9320_SetPoint>
 80009fe:	e021      	b.n	8000a44 <GUI_Chn+0x160>
					else
						ili9320_SetPoint(i * 16 + x + j + n * 8, y + m, bkColor);
 8000a00:	6bfb      	ldr	r3, [r7, #60]	; 0x3c
 8000a02:	b29b      	uxth	r3, r3
 8000a04:	ea4f 1303 	mov.w	r3, r3, lsl #4
 8000a08:	b29a      	uxth	r2, r3
 8000a0a:	89fb      	ldrh	r3, [r7, #14]
 8000a0c:	18d3      	adds	r3, r2, r3
 8000a0e:	b29a      	uxth	r2, r3
 8000a10:	f897 3039 	ldrb.w	r3, [r7, #57]	; 0x39
 8000a14:	b29b      	uxth	r3, r3
 8000a16:	18d3      	adds	r3, r2, r3
 8000a18:	b29a      	uxth	r2, r3
 8000a1a:	f897 303a 	ldrb.w	r3, [r7, #58]	; 0x3a
 8000a1e:	b29b      	uxth	r3, r3
 8000a20:	ea4f 03c3 	mov.w	r3, r3, lsl #3
 8000a24:	b29b      	uxth	r3, r3
 8000a26:	18d3      	adds	r3, r2, r3
 8000a28:	b299      	uxth	r1, r3
 8000a2a:	f897 303b 	ldrb.w	r3, [r7, #59]	; 0x3b
 8000a2e:	b29a      	uxth	r2, r3
 8000a30:	89bb      	ldrh	r3, [r7, #12]
 8000a32:	18d3      	adds	r3, r2, r3
 8000a34:	b29a      	uxth	r2, r3
 8000a36:	f8b7 304c 	ldrh.w	r3, [r7, #76]	; 0x4c
 8000a3a:	4608      	mov	r0, r1
 8000a3c:	4611      	mov	r1, r2
 8000a3e:	461a      	mov	r2, r3
 8000a40:	f000 fccc 	bl	80013dc <ili9320_SetPoint>
		memcpy(buf, (unsigned char const*)(HZK_FLASH_BASE + offset), 32);

		for (m = 0; m < 16; m++)
			for(n = 0; n < 2; n++)
			{
				for(j = 0; j < 8; j++)
 8000a44:	f897 3039 	ldrb.w	r3, [r7, #57]	; 0x39
 8000a48:	f103 0301 	add.w	r3, r3, #1
 8000a4c:	f887 3039 	strb.w	r3, [r7, #57]	; 0x39
 8000a50:	f897 3039 	ldrb.w	r3, [r7, #57]	; 0x39
 8000a54:	2b07      	cmp	r3, #7
 8000a56:	d99a      	bls.n	800098e <GUI_Chn+0xaa>
   		wh = *(str + 2 * i + 1) - 0xa0;	
		offset = (94 * (qh - 1) + (wh - 1)) * 32;
		memcpy(buf, (unsigned char const*)(HZK_FLASH_BASE + offset), 32);

		for (m = 0; m < 16; m++)
			for(n = 0; n < 2; n++)
 8000a58:	f897 303a 	ldrb.w	r3, [r7, #58]	; 0x3a
 8000a5c:	f103 0301 	add.w	r3, r3, #1
 8000a60:	f887 303a 	strb.w	r3, [r7, #58]	; 0x3a
 8000a64:	f897 303a 	ldrb.w	r3, [r7, #58]	; 0x3a
 8000a68:	2b01      	cmp	r3, #1
 8000a6a:	d98b      	bls.n	8000984 <GUI_Chn+0xa0>
		qh = *(str + 2 * i) - 0xa0;
   		wh = *(str + 2 * i + 1) - 0xa0;	
		offset = (94 * (qh - 1) + (wh - 1)) * 32;
		memcpy(buf, (unsigned char const*)(HZK_FLASH_BASE + offset), 32);

		for (m = 0; m < 16; m++)
 8000a6c:	f897 303b 	ldrb.w	r3, [r7, #59]	; 0x3b
 8000a70:	f103 0301 	add.w	r3, r3, #1
 8000a74:	f887 303b 	strb.w	r3, [r7, #59]	; 0x3b
 8000a78:	f897 303b 	ldrb.w	r3, [r7, #59]	; 0x3b
 8000a7c:	2b0f      	cmp	r3, #15
 8000a7e:	f67f af7c 	bls.w	800097a <GUI_Chn+0x96>
	int i = 0;
	u32 offset;
	unsigned char buf[32];
	unsigned char qh, wh, m, n, j;

	for(i = 0; i < len / 2; i++)
 8000a82:	6bfb      	ldr	r3, [r7, #60]	; 0x3c
 8000a84:	f103 0301 	add.w	r3, r3, #1
 8000a88:	63fb      	str	r3, [r7, #60]	; 0x3c
 8000a8a:	88fb      	ldrh	r3, [r7, #6]
 8000a8c:	ea4f 0353 	mov.w	r3, r3, lsr #1
 8000a90:	b29b      	uxth	r3, r3
 8000a92:	461a      	mov	r2, r3
 8000a94:	6bfb      	ldr	r3, [r7, #60]	; 0x3c
 8000a96:	429a      	cmp	r2, r3
 8000a98:	f73f af34 	bgt.w	8000904 <GUI_Chn+0x20>
						ili9320_SetPoint(i * 16 + x + j + n * 8, y + m, bkColor);
				}
			}

	}
}
 8000a9c:	f107 0740 	add.w	r7, r7, #64	; 0x40
 8000aa0:	46bd      	mov	sp, r7
 8000aa2:	bd80      	pop	{r7, pc}

08000aa4 <LCD_Disp>:

void LCD_Disp(u16 x, u16 y, u8 *str, u16 Color, u16 bkColor)
{
 8000aa4:	b580      	push	{r7, lr}
 8000aa6:	b088      	sub	sp, #32
 8000aa8:	af02      	add	r7, sp, #8
 8000aaa:	60ba      	str	r2, [r7, #8]
 8000aac:	4602      	mov	r2, r0
 8000aae:	81fa      	strh	r2, [r7, #14]
 8000ab0:	460a      	mov	r2, r1
 8000ab2:	81ba      	strh	r2, [r7, #12]
 8000ab4:	80fb      	strh	r3, [r7, #6]
	int i = 0;
 8000ab6:	f04f 0300 	mov.w	r3, #0
 8000aba:	617b      	str	r3, [r7, #20]
    while( (*str) != '\0')
 8000abc:	e038      	b.n	8000b30 <LCD_Disp+0x8c>
    {
        if( (*str)<= 127 )
 8000abe:	68bb      	ldr	r3, [r7, #8]
 8000ac0:	781b      	ldrb	r3, [r3, #0]
 8000ac2:	b2db      	uxtb	r3, r3
 8000ac4:	b25b      	sxtb	r3, r3
 8000ac6:	2b00      	cmp	r3, #0
 8000ac8:	db19      	blt.n	8000afe <LCD_Disp+0x5a>
        {
             
             GUI_Text(x + i, y, str, 1, Color, bkColor);
 8000aca:	697b      	ldr	r3, [r7, #20]
 8000acc:	b29a      	uxth	r2, r3
 8000ace:	89fb      	ldrh	r3, [r7, #14]
 8000ad0:	18d3      	adds	r3, r2, r3
 8000ad2:	b29a      	uxth	r2, r3
 8000ad4:	89bb      	ldrh	r3, [r7, #12]
 8000ad6:	88f9      	ldrh	r1, [r7, #6]
 8000ad8:	9100      	str	r1, [sp, #0]
 8000ada:	8c39      	ldrh	r1, [r7, #32]
 8000adc:	9101      	str	r1, [sp, #4]
 8000ade:	4610      	mov	r0, r2
 8000ae0:	4619      	mov	r1, r3
 8000ae2:	68ba      	ldr	r2, [r7, #8]
 8000ae4:	f04f 0301 	mov.w	r3, #1
 8000ae8:	f7ff fece 	bl	8000888 <GUI_Text>
             i = i + 8;
 8000aec:	697b      	ldr	r3, [r7, #20]
 8000aee:	f103 0308 	add.w	r3, r3, #8
 8000af2:	617b      	str	r3, [r7, #20]
             str++;
 8000af4:	68bb      	ldr	r3, [r7, #8]
 8000af6:	f103 0301 	add.w	r3, r3, #1
 8000afa:	60bb      	str	r3, [r7, #8]
 8000afc:	e018      	b.n	8000b30 <LCD_Disp+0x8c>
        }
        else
        {
             GUI_Chn(x + i, y, str, 2, Color, bkColor);
 8000afe:	697b      	ldr	r3, [r7, #20]
 8000b00:	b29a      	uxth	r2, r3
 8000b02:	89fb      	ldrh	r3, [r7, #14]
 8000b04:	18d3      	adds	r3, r2, r3
 8000b06:	b29a      	uxth	r2, r3
 8000b08:	89bb      	ldrh	r3, [r7, #12]
 8000b0a:	88f9      	ldrh	r1, [r7, #6]
 8000b0c:	9100      	str	r1, [sp, #0]
 8000b0e:	8c39      	ldrh	r1, [r7, #32]
 8000b10:	9101      	str	r1, [sp, #4]
 8000b12:	4610      	mov	r0, r2
 8000b14:	4619      	mov	r1, r3
 8000b16:	68ba      	ldr	r2, [r7, #8]
 8000b18:	f04f 0302 	mov.w	r3, #2
 8000b1c:	f7ff fee2 	bl	80008e4 <GUI_Chn>
             str = str + 2;
 8000b20:	68bb      	ldr	r3, [r7, #8]
 8000b22:	f103 0302 	add.w	r3, r3, #2
 8000b26:	60bb      	str	r3, [r7, #8]
             i = i + 16;
 8000b28:	697b      	ldr	r3, [r7, #20]
 8000b2a:	f103 0310 	add.w	r3, r3, #16
 8000b2e:	617b      	str	r3, [r7, #20]
}

void LCD_Disp(u16 x, u16 y, u8 *str, u16 Color, u16 bkColor)
{
	int i = 0;
    while( (*str) != '\0')
 8000b30:	68bb      	ldr	r3, [r7, #8]
 8000b32:	781b      	ldrb	r3, [r3, #0]
 8000b34:	2b00      	cmp	r3, #0
 8000b36:	d1c2      	bne.n	8000abe <LCD_Disp+0x1a>
             GUI_Chn(x + i, y, str, 2, Color, bkColor);
             str = str + 2;
             i = i + 16;
        }
    }
}
 8000b38:	f107 0718 	add.w	r7, r7, #24
 8000b3c:	46bd      	mov	sp, r7
 8000b3e:	bd80      	pop	{r7, pc}

08000b40 <GUI_Line>:
* 出口参数：无
* 说    明：
* 调用方法：GUI_Line(0,0,240,320,0x0000);
****************************************************************************/
void GUI_Line(u16 x0, u16 y0, u16 x1, u16 y1,u16 color)
{
 8000b40:	b580      	push	{r7, lr}
 8000b42:	b08a      	sub	sp, #40	; 0x28
 8000b44:	af00      	add	r7, sp, #0
 8000b46:	80f8      	strh	r0, [r7, #6]
 8000b48:	80b9      	strh	r1, [r7, #4]
 8000b4a:	807a      	strh	r2, [r7, #2]
 8000b4c:	803b      	strh	r3, [r7, #0]
 	u16 x,y;
 	u16 dx;// = abs(x1 - x0);
 	u16 dy;// = abs(y1 - y0);

	if(y0==y1)
 8000b4e:	88ba      	ldrh	r2, [r7, #4]
 8000b50:	883b      	ldrh	r3, [r7, #0]
 8000b52:	429a      	cmp	r2, r3
 8000b54:	d11c      	bne.n	8000b90 <GUI_Line+0x50>
	{
		if(x0<=x1)
 8000b56:	88fa      	ldrh	r2, [r7, #6]
 8000b58:	887b      	ldrh	r3, [r7, #2]
 8000b5a:	429a      	cmp	r2, r3
 8000b5c:	d802      	bhi.n	8000b64 <GUI_Line+0x24>
		{
			x=x0;
 8000b5e:	88fb      	ldrh	r3, [r7, #6]
 8000b60:	84fb      	strh	r3, [r7, #38]	; 0x26
		else
		{
			x=x1;
			x1=x0;
		}
  		while(x <= x1)
 8000b62:	e010      	b.n	8000b86 <GUI_Line+0x46>
		{
			x=x0;
		}
		else
		{
			x=x1;
 8000b64:	887b      	ldrh	r3, [r7, #2]
 8000b66:	84fb      	strh	r3, [r7, #38]	; 0x26
			x1=x0;
 8000b68:	88fb      	ldrh	r3, [r7, #6]
 8000b6a:	807b      	strh	r3, [r7, #2]
		}
  		while(x <= x1)
 8000b6c:	e00b      	b.n	8000b86 <GUI_Line+0x46>
  		{
   			ili9320_SetPoint(x,y0,color);
 8000b6e:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
 8000b70:	88ba      	ldrh	r2, [r7, #4]
 8000b72:	8e3b      	ldrh	r3, [r7, #48]	; 0x30
 8000b74:	4608      	mov	r0, r1
 8000b76:	4611      	mov	r1, r2
 8000b78:	461a      	mov	r2, r3
 8000b7a:	f000 fc2f 	bl	80013dc <ili9320_SetPoint>
   			x++;
 8000b7e:	8cfb      	ldrh	r3, [r7, #38]	; 0x26
 8000b80:	f103 0301 	add.w	r3, r3, #1
 8000b84:	84fb      	strh	r3, [r7, #38]	; 0x26
		else
		{
			x=x1;
			x1=x0;
		}
  		while(x <= x1)
 8000b86:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
 8000b88:	887b      	ldrh	r3, [r7, #2]
 8000b8a:	429a      	cmp	r2, r3
 8000b8c:	d9ef      	bls.n	8000b6e <GUI_Line+0x2e>
  		{
   			ili9320_SetPoint(x,y0,color);
   			x++;
  		}
  		return;
 8000b8e:	e164      	b.n	8000e5a <GUI_Line+0x31a>
	}
	else if(y0>y1)
 8000b90:	88ba      	ldrh	r2, [r7, #4]
 8000b92:	883b      	ldrh	r3, [r7, #0]
 8000b94:	429a      	cmp	r2, r3
 8000b96:	d904      	bls.n	8000ba2 <GUI_Line+0x62>
	{
		dy=y0-y1;
 8000b98:	88ba      	ldrh	r2, [r7, #4]
 8000b9a:	883b      	ldrh	r3, [r7, #0]
 8000b9c:	1ad3      	subs	r3, r2, r3
 8000b9e:	843b      	strh	r3, [r7, #32]
 8000ba0:	e003      	b.n	8000baa <GUI_Line+0x6a>
	}
	else
	{
		dy=y1-y0;
 8000ba2:	883a      	ldrh	r2, [r7, #0]
 8000ba4:	88bb      	ldrh	r3, [r7, #4]
 8000ba6:	1ad3      	subs	r3, r2, r3
 8000ba8:	843b      	strh	r3, [r7, #32]
	}
 
 	if(x0==x1)
 8000baa:	88fa      	ldrh	r2, [r7, #6]
 8000bac:	887b      	ldrh	r3, [r7, #2]
 8000bae:	429a      	cmp	r2, r3
 8000bb0:	d11c      	bne.n	8000bec <GUI_Line+0xac>
	{
		if(y0<=y1)
 8000bb2:	88ba      	ldrh	r2, [r7, #4]
 8000bb4:	883b      	ldrh	r3, [r7, #0]
 8000bb6:	429a      	cmp	r2, r3
 8000bb8:	d802      	bhi.n	8000bc0 <GUI_Line+0x80>
		{
			y=y0;
 8000bba:	88bb      	ldrh	r3, [r7, #4]
 8000bbc:	84bb      	strh	r3, [r7, #36]	; 0x24
		else
		{
			y=y1;
			y1=y0;
		}
  		while(y <= y1)
 8000bbe:	e010      	b.n	8000be2 <GUI_Line+0xa2>
		{
			y=y0;
		}
		else
		{
			y=y1;
 8000bc0:	883b      	ldrh	r3, [r7, #0]
 8000bc2:	84bb      	strh	r3, [r7, #36]	; 0x24
			y1=y0;
 8000bc4:	88bb      	ldrh	r3, [r7, #4]
 8000bc6:	803b      	strh	r3, [r7, #0]
		}
  		while(y <= y1)
 8000bc8:	e00b      	b.n	8000be2 <GUI_Line+0xa2>
  		{
   			ili9320_SetPoint(x0,y,color);
 8000bca:	88f9      	ldrh	r1, [r7, #6]
 8000bcc:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000bce:	8e3b      	ldrh	r3, [r7, #48]	; 0x30
 8000bd0:	4608      	mov	r0, r1
 8000bd2:	4611      	mov	r1, r2
 8000bd4:	461a      	mov	r2, r3
 8000bd6:	f000 fc01 	bl	80013dc <ili9320_SetPoint>
   			y++;
 8000bda:	8cbb      	ldrh	r3, [r7, #36]	; 0x24
 8000bdc:	f103 0301 	add.w	r3, r3, #1
 8000be0:	84bb      	strh	r3, [r7, #36]	; 0x24
		else
		{
			y=y1;
			y1=y0;
		}
  		while(y <= y1)
 8000be2:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000be4:	883b      	ldrh	r3, [r7, #0]
 8000be6:	429a      	cmp	r2, r3
 8000be8:	d9ef      	bls.n	8000bca <GUI_Line+0x8a>
  		{
   			ili9320_SetPoint(x0,y,color);
   			y++;
  		}
  		return;
 8000bea:	e136      	b.n	8000e5a <GUI_Line+0x31a>
	}
	else if(x0 > x1)
 8000bec:	88fa      	ldrh	r2, [r7, #6]
 8000bee:	887b      	ldrh	r3, [r7, #2]
 8000bf0:	429a      	cmp	r2, r3
 8000bf2:	d90c      	bls.n	8000c0e <GUI_Line+0xce>
 	{
		dx=x0-x1;
 8000bf4:	88fa      	ldrh	r2, [r7, #6]
 8000bf6:	887b      	ldrh	r3, [r7, #2]
 8000bf8:	1ad3      	subs	r3, r2, r3
 8000bfa:	847b      	strh	r3, [r7, #34]	; 0x22
  		x = x1;
 8000bfc:	887b      	ldrh	r3, [r7, #2]
 8000bfe:	84fb      	strh	r3, [r7, #38]	; 0x26
  		x1 = x0;
 8000c00:	88fb      	ldrh	r3, [r7, #6]
 8000c02:	807b      	strh	r3, [r7, #2]
  		y = y1;
 8000c04:	883b      	ldrh	r3, [r7, #0]
 8000c06:	84bb      	strh	r3, [r7, #36]	; 0x24
  		y1 = y0;
 8000c08:	88bb      	ldrh	r3, [r7, #4]
 8000c0a:	803b      	strh	r3, [r7, #0]
 8000c0c:	e007      	b.n	8000c1e <GUI_Line+0xde>
 	}
 	else
 	{
		dx=x1-x0;
 8000c0e:	887a      	ldrh	r2, [r7, #2]
 8000c10:	88fb      	ldrh	r3, [r7, #6]
 8000c12:	1ad3      	subs	r3, r2, r3
 8000c14:	847b      	strh	r3, [r7, #34]	; 0x22
  		x = x0;
 8000c16:	88fb      	ldrh	r3, [r7, #6]
 8000c18:	84fb      	strh	r3, [r7, #38]	; 0x26
  		y = y0;
 8000c1a:	88bb      	ldrh	r3, [r7, #4]
 8000c1c:	84bb      	strh	r3, [r7, #36]	; 0x24
 	}

 	if(dx == dy)
 8000c1e:	8c7a      	ldrh	r2, [r7, #34]	; 0x22
 8000c20:	8c3b      	ldrh	r3, [r7, #32]
 8000c22:	429a      	cmp	r2, r3
 8000c24:	d11e      	bne.n	8000c64 <GUI_Line+0x124>
 	{
  		while(x <= x1)
 8000c26:	e018      	b.n	8000c5a <GUI_Line+0x11a>
  		{

   			x++;
 8000c28:	8cfb      	ldrh	r3, [r7, #38]	; 0x26
 8000c2a:	f103 0301 	add.w	r3, r3, #1
 8000c2e:	84fb      	strh	r3, [r7, #38]	; 0x26
			if(y>y1)
 8000c30:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000c32:	883b      	ldrh	r3, [r7, #0]
 8000c34:	429a      	cmp	r2, r3
 8000c36:	d904      	bls.n	8000c42 <GUI_Line+0x102>
			{
				y--;
 8000c38:	8cbb      	ldrh	r3, [r7, #36]	; 0x24
 8000c3a:	f103 33ff 	add.w	r3, r3, #4294967295
 8000c3e:	84bb      	strh	r3, [r7, #36]	; 0x24
 8000c40:	e003      	b.n	8000c4a <GUI_Line+0x10a>
			}
			else
			{
   				y++;
 8000c42:	8cbb      	ldrh	r3, [r7, #36]	; 0x24
 8000c44:	f103 0301 	add.w	r3, r3, #1
 8000c48:	84bb      	strh	r3, [r7, #36]	; 0x24
			}
   			ili9320_SetPoint(x,y,color);
 8000c4a:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
 8000c4c:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000c4e:	8e3b      	ldrh	r3, [r7, #48]	; 0x30
 8000c50:	4608      	mov	r0, r1
 8000c52:	4611      	mov	r1, r2
 8000c54:	461a      	mov	r2, r3
 8000c56:	f000 fbc1 	bl	80013dc <ili9320_SetPoint>
  		y = y0;
 	}

 	if(dx == dy)
 	{
  		while(x <= x1)
 8000c5a:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
 8000c5c:	887b      	ldrh	r3, [r7, #2]
 8000c5e:	429a      	cmp	r2, r3
 8000c60:	d9e2      	bls.n	8000c28 <GUI_Line+0xe8>
 8000c62:	e0fa      	b.n	8000e5a <GUI_Line+0x31a>
   			ili9320_SetPoint(x,y,color);
  		}
 	}
 	else
 	{
 		ili9320_SetPoint(x, y, color);
 8000c64:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
 8000c66:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000c68:	8e3b      	ldrh	r3, [r7, #48]	; 0x30
 8000c6a:	4608      	mov	r0, r1
 8000c6c:	4611      	mov	r1, r2
 8000c6e:	461a      	mov	r2, r3
 8000c70:	f000 fbb4 	bl	80013dc <ili9320_SetPoint>
  		if(y < y1)
 8000c74:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000c76:	883b      	ldrh	r3, [r7, #0]
 8000c78:	429a      	cmp	r2, r3
 8000c7a:	d277      	bcs.n	8000d6c <GUI_Line+0x22c>
  		{
   			if(dx > dy)
 8000c7c:	8c7a      	ldrh	r2, [r7, #34]	; 0x22
 8000c7e:	8c3b      	ldrh	r3, [r7, #32]
 8000c80:	429a      	cmp	r2, r3
 8000c82:	d939      	bls.n	8000cf8 <GUI_Line+0x1b8>
   			{
    			s16 p = dy * 2 - dx;
 8000c84:	8c3b      	ldrh	r3, [r7, #32]
 8000c86:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000c8a:	b29a      	uxth	r2, r3
 8000c8c:	8c7b      	ldrh	r3, [r7, #34]	; 0x22
 8000c8e:	1ad3      	subs	r3, r2, r3
 8000c90:	b29b      	uxth	r3, r3
 8000c92:	83fb      	strh	r3, [r7, #30]
    			s16 twoDy = 2 * dy;
 8000c94:	8c3b      	ldrh	r3, [r7, #32]
 8000c96:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000c9a:	b29b      	uxth	r3, r3
 8000c9c:	82fb      	strh	r3, [r7, #22]
    			s16 twoDyMinusDx = 2 * (dy - dx);
 8000c9e:	8c3a      	ldrh	r2, [r7, #32]
 8000ca0:	8c7b      	ldrh	r3, [r7, #34]	; 0x22
 8000ca2:	1ad3      	subs	r3, r2, r3
 8000ca4:	b29b      	uxth	r3, r3
 8000ca6:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000caa:	b29b      	uxth	r3, r3
 8000cac:	82bb      	strh	r3, [r7, #20]
    			while(x < x1)
 8000cae:	e01e      	b.n	8000cee <GUI_Line+0x1ae>
    			{
     				x++;
 8000cb0:	8cfb      	ldrh	r3, [r7, #38]	; 0x26
 8000cb2:	f103 0301 	add.w	r3, r3, #1
 8000cb6:	84fb      	strh	r3, [r7, #38]	; 0x26
     				if(p < 0)
 8000cb8:	f9b7 301e 	ldrsh.w	r3, [r7, #30]
 8000cbc:	2b00      	cmp	r3, #0
 8000cbe:	da05      	bge.n	8000ccc <GUI_Line+0x18c>
     				{
      					p += twoDy;
 8000cc0:	8bfa      	ldrh	r2, [r7, #30]
 8000cc2:	8afb      	ldrh	r3, [r7, #22]
 8000cc4:	18d3      	adds	r3, r2, r3
 8000cc6:	b29b      	uxth	r3, r3
 8000cc8:	83fb      	strh	r3, [r7, #30]
 8000cca:	e008      	b.n	8000cde <GUI_Line+0x19e>
     				}
     				else
     				{
      					y++;
 8000ccc:	8cbb      	ldrh	r3, [r7, #36]	; 0x24
 8000cce:	f103 0301 	add.w	r3, r3, #1
 8000cd2:	84bb      	strh	r3, [r7, #36]	; 0x24
      					p += twoDyMinusDx;
 8000cd4:	8bfa      	ldrh	r2, [r7, #30]
 8000cd6:	8abb      	ldrh	r3, [r7, #20]
 8000cd8:	18d3      	adds	r3, r2, r3
 8000cda:	b29b      	uxth	r3, r3
 8000cdc:	83fb      	strh	r3, [r7, #30]
     				}
     				ili9320_SetPoint(x, y,color);
 8000cde:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
 8000ce0:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000ce2:	8e3b      	ldrh	r3, [r7, #48]	; 0x30
 8000ce4:	4608      	mov	r0, r1
 8000ce6:	4611      	mov	r1, r2
 8000ce8:	461a      	mov	r2, r3
 8000cea:	f000 fb77 	bl	80013dc <ili9320_SetPoint>
   			if(dx > dy)
   			{
    			s16 p = dy * 2 - dx;
    			s16 twoDy = 2 * dy;
    			s16 twoDyMinusDx = 2 * (dy - dx);
    			while(x < x1)
 8000cee:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
 8000cf0:	887b      	ldrh	r3, [r7, #2]
 8000cf2:	429a      	cmp	r2, r3
 8000cf4:	d3dc      	bcc.n	8000cb0 <GUI_Line+0x170>
 8000cf6:	e0b0      	b.n	8000e5a <GUI_Line+0x31a>
     				ili9320_SetPoint(x, y,color);
    			}
   			}
   			else
   			{
    			s16 p = dx * 2 - dy;
 8000cf8:	8c7b      	ldrh	r3, [r7, #34]	; 0x22
 8000cfa:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000cfe:	b29a      	uxth	r2, r3
 8000d00:	8c3b      	ldrh	r3, [r7, #32]
 8000d02:	1ad3      	subs	r3, r2, r3
 8000d04:	b29b      	uxth	r3, r3
 8000d06:	83bb      	strh	r3, [r7, #28]
    			s16 twoDx = 2 * dx;
 8000d08:	8c7b      	ldrh	r3, [r7, #34]	; 0x22
 8000d0a:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000d0e:	b29b      	uxth	r3, r3
 8000d10:	827b      	strh	r3, [r7, #18]
    			s16 twoDxMinusDy = 2 * (dx - dy);
 8000d12:	8c7a      	ldrh	r2, [r7, #34]	; 0x22
 8000d14:	8c3b      	ldrh	r3, [r7, #32]
 8000d16:	1ad3      	subs	r3, r2, r3
 8000d18:	b29b      	uxth	r3, r3
 8000d1a:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000d1e:	b29b      	uxth	r3, r3
 8000d20:	823b      	strh	r3, [r7, #16]
    			while(y < y1)
 8000d22:	e01e      	b.n	8000d62 <GUI_Line+0x222>
    			{
     				y++;
 8000d24:	8cbb      	ldrh	r3, [r7, #36]	; 0x24
 8000d26:	f103 0301 	add.w	r3, r3, #1
 8000d2a:	84bb      	strh	r3, [r7, #36]	; 0x24
     				if(p < 0)
 8000d2c:	f9b7 301c 	ldrsh.w	r3, [r7, #28]
 8000d30:	2b00      	cmp	r3, #0
 8000d32:	da05      	bge.n	8000d40 <GUI_Line+0x200>
     				{
      					p += twoDx;
 8000d34:	8bba      	ldrh	r2, [r7, #28]
 8000d36:	8a7b      	ldrh	r3, [r7, #18]
 8000d38:	18d3      	adds	r3, r2, r3
 8000d3a:	b29b      	uxth	r3, r3
 8000d3c:	83bb      	strh	r3, [r7, #28]
 8000d3e:	e008      	b.n	8000d52 <GUI_Line+0x212>
     				}
     				else
     				{
      					x++;
 8000d40:	8cfb      	ldrh	r3, [r7, #38]	; 0x26
 8000d42:	f103 0301 	add.w	r3, r3, #1
 8000d46:	84fb      	strh	r3, [r7, #38]	; 0x26
      					p+= twoDxMinusDy;
 8000d48:	8bba      	ldrh	r2, [r7, #28]
 8000d4a:	8a3b      	ldrh	r3, [r7, #16]
 8000d4c:	18d3      	adds	r3, r2, r3
 8000d4e:	b29b      	uxth	r3, r3
 8000d50:	83bb      	strh	r3, [r7, #28]
     				}
     				ili9320_SetPoint(x, y, color);
 8000d52:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
 8000d54:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000d56:	8e3b      	ldrh	r3, [r7, #48]	; 0x30
 8000d58:	4608      	mov	r0, r1
 8000d5a:	4611      	mov	r1, r2
 8000d5c:	461a      	mov	r2, r3
 8000d5e:	f000 fb3d 	bl	80013dc <ili9320_SetPoint>
   			else
   			{
    			s16 p = dx * 2 - dy;
    			s16 twoDx = 2 * dx;
    			s16 twoDxMinusDy = 2 * (dx - dy);
    			while(y < y1)
 8000d62:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000d64:	883b      	ldrh	r3, [r7, #0]
 8000d66:	429a      	cmp	r2, r3
 8000d68:	d3dc      	bcc.n	8000d24 <GUI_Line+0x1e4>
 8000d6a:	e076      	b.n	8000e5a <GUI_Line+0x31a>
    			}
   			}
  		}
  		else
  		{
   			if(dx > dy)
 8000d6c:	8c7a      	ldrh	r2, [r7, #34]	; 0x22
 8000d6e:	8c3b      	ldrh	r3, [r7, #32]
 8000d70:	429a      	cmp	r2, r3
 8000d72:	d939      	bls.n	8000de8 <GUI_Line+0x2a8>
   			{
    			s16 p = dy * 2 - dx;
 8000d74:	8c3b      	ldrh	r3, [r7, #32]
 8000d76:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000d7a:	b29a      	uxth	r2, r3
 8000d7c:	8c7b      	ldrh	r3, [r7, #34]	; 0x22
 8000d7e:	1ad3      	subs	r3, r2, r3
 8000d80:	b29b      	uxth	r3, r3
 8000d82:	837b      	strh	r3, [r7, #26]
    			s16 twoDy = 2 * dy;
 8000d84:	8c3b      	ldrh	r3, [r7, #32]
 8000d86:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000d8a:	b29b      	uxth	r3, r3
 8000d8c:	81fb      	strh	r3, [r7, #14]
	    		s16 twoDyMinusDx = 2 * (dy - dx);
 8000d8e:	8c3a      	ldrh	r2, [r7, #32]
 8000d90:	8c7b      	ldrh	r3, [r7, #34]	; 0x22
 8000d92:	1ad3      	subs	r3, r2, r3
 8000d94:	b29b      	uxth	r3, r3
 8000d96:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000d9a:	b29b      	uxth	r3, r3
 8000d9c:	81bb      	strh	r3, [r7, #12]
    			while(x < x1)
 8000d9e:	e01e      	b.n	8000dde <GUI_Line+0x29e>
    			{
     				x++;
 8000da0:	8cfb      	ldrh	r3, [r7, #38]	; 0x26
 8000da2:	f103 0301 	add.w	r3, r3, #1
 8000da6:	84fb      	strh	r3, [r7, #38]	; 0x26
     				if(p < 0)
 8000da8:	f9b7 301a 	ldrsh.w	r3, [r7, #26]
 8000dac:	2b00      	cmp	r3, #0
 8000dae:	da05      	bge.n	8000dbc <GUI_Line+0x27c>
	     			{
    	  				p += twoDy;
 8000db0:	8b7a      	ldrh	r2, [r7, #26]
 8000db2:	89fb      	ldrh	r3, [r7, #14]
 8000db4:	18d3      	adds	r3, r2, r3
 8000db6:	b29b      	uxth	r3, r3
 8000db8:	837b      	strh	r3, [r7, #26]
 8000dba:	e008      	b.n	8000dce <GUI_Line+0x28e>
     				}
     				else
     				{
      					y--;
 8000dbc:	8cbb      	ldrh	r3, [r7, #36]	; 0x24
 8000dbe:	f103 33ff 	add.w	r3, r3, #4294967295
 8000dc2:	84bb      	strh	r3, [r7, #36]	; 0x24
	      				p += twoDyMinusDx;
 8000dc4:	8b7a      	ldrh	r2, [r7, #26]
 8000dc6:	89bb      	ldrh	r3, [r7, #12]
 8000dc8:	18d3      	adds	r3, r2, r3
 8000dca:	b29b      	uxth	r3, r3
 8000dcc:	837b      	strh	r3, [r7, #26]
    	 			}
     				ili9320_SetPoint(x, y,color);
 8000dce:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
 8000dd0:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000dd2:	8e3b      	ldrh	r3, [r7, #48]	; 0x30
 8000dd4:	4608      	mov	r0, r1
 8000dd6:	4611      	mov	r1, r2
 8000dd8:	461a      	mov	r2, r3
 8000dda:	f000 faff 	bl	80013dc <ili9320_SetPoint>
   			if(dx > dy)
   			{
    			s16 p = dy * 2 - dx;
    			s16 twoDy = 2 * dy;
	    		s16 twoDyMinusDx = 2 * (dy - dx);
    			while(x < x1)
 8000dde:	8cfa      	ldrh	r2, [r7, #38]	; 0x26
 8000de0:	887b      	ldrh	r3, [r7, #2]
 8000de2:	429a      	cmp	r2, r3
 8000de4:	d3dc      	bcc.n	8000da0 <GUI_Line+0x260>
 8000de6:	e038      	b.n	8000e5a <GUI_Line+0x31a>
     				ili9320_SetPoint(x, y,color);
    			}
   			}
	   		else
   			{
    			s16 p = dx * 2 - dy;
 8000de8:	8c7b      	ldrh	r3, [r7, #34]	; 0x22
 8000dea:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000dee:	b29a      	uxth	r2, r3
 8000df0:	8c3b      	ldrh	r3, [r7, #32]
 8000df2:	1ad3      	subs	r3, r2, r3
 8000df4:	b29b      	uxth	r3, r3
 8000df6:	833b      	strh	r3, [r7, #24]
    			s16 twoDx = 2 * dx;
 8000df8:	8c7b      	ldrh	r3, [r7, #34]	; 0x22
 8000dfa:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000dfe:	b29b      	uxth	r3, r3
 8000e00:	817b      	strh	r3, [r7, #10]
	    		s16 twoDxMinusDy = 2 * (dx - dy);
 8000e02:	8c7a      	ldrh	r2, [r7, #34]	; 0x22
 8000e04:	8c3b      	ldrh	r3, [r7, #32]
 8000e06:	1ad3      	subs	r3, r2, r3
 8000e08:	b29b      	uxth	r3, r3
 8000e0a:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000e0e:	b29b      	uxth	r3, r3
 8000e10:	813b      	strh	r3, [r7, #8]
    			while(y1 < y)
 8000e12:	e01e      	b.n	8000e52 <GUI_Line+0x312>
    			{
     				y--;
 8000e14:	8cbb      	ldrh	r3, [r7, #36]	; 0x24
 8000e16:	f103 33ff 	add.w	r3, r3, #4294967295
 8000e1a:	84bb      	strh	r3, [r7, #36]	; 0x24
     				if(p < 0)
 8000e1c:	f9b7 3018 	ldrsh.w	r3, [r7, #24]
 8000e20:	2b00      	cmp	r3, #0
 8000e22:	da05      	bge.n	8000e30 <GUI_Line+0x2f0>
	     			{
    	  				p += twoDx;
 8000e24:	8b3a      	ldrh	r2, [r7, #24]
 8000e26:	897b      	ldrh	r3, [r7, #10]
 8000e28:	18d3      	adds	r3, r2, r3
 8000e2a:	b29b      	uxth	r3, r3
 8000e2c:	833b      	strh	r3, [r7, #24]
 8000e2e:	e008      	b.n	8000e42 <GUI_Line+0x302>
     				}
     				else
     				{
      					x++;
 8000e30:	8cfb      	ldrh	r3, [r7, #38]	; 0x26
 8000e32:	f103 0301 	add.w	r3, r3, #1
 8000e36:	84fb      	strh	r3, [r7, #38]	; 0x26
	      				p+= twoDxMinusDy;
 8000e38:	8b3a      	ldrh	r2, [r7, #24]
 8000e3a:	893b      	ldrh	r3, [r7, #8]
 8000e3c:	18d3      	adds	r3, r2, r3
 8000e3e:	b29b      	uxth	r3, r3
 8000e40:	833b      	strh	r3, [r7, #24]
    	 			}
     				ili9320_SetPoint(x, y,color);
 8000e42:	8cf9      	ldrh	r1, [r7, #38]	; 0x26
 8000e44:	8cba      	ldrh	r2, [r7, #36]	; 0x24
 8000e46:	8e3b      	ldrh	r3, [r7, #48]	; 0x30
 8000e48:	4608      	mov	r0, r1
 8000e4a:	4611      	mov	r1, r2
 8000e4c:	461a      	mov	r2, r3
 8000e4e:	f000 fac5 	bl	80013dc <ili9320_SetPoint>
	   		else
   			{
    			s16 p = dx * 2 - dy;
    			s16 twoDx = 2 * dx;
	    		s16 twoDxMinusDy = 2 * (dx - dy);
    			while(y1 < y)
 8000e52:	883a      	ldrh	r2, [r7, #0]
 8000e54:	8cbb      	ldrh	r3, [r7, #36]	; 0x24
 8000e56:	429a      	cmp	r2, r3
 8000e58:	d3dc      	bcc.n	8000e14 <GUI_Line+0x2d4>
     				ili9320_SetPoint(x, y,color);
    			}
   			}
  		}
 	}
}
 8000e5a:	f107 0728 	add.w	r7, r7, #40	; 0x28
 8000e5e:	46bd      	mov	sp, r7
 8000e60:	bd80      	pop	{r7, pc}
 8000e62:	bf00      	nop

08000e64 <GUI_Circle>:
* 出口参数：
* 说    明：
* 调用方法：
****************************************************************************/
void GUI_Circle(u16 cx,u16 cy,u16 r,u16 color,u8 fill)
{
 8000e64:	b590      	push	{r4, r7, lr}
 8000e66:	b087      	sub	sp, #28
 8000e68:	af02      	add	r7, sp, #8
 8000e6a:	80f8      	strh	r0, [r7, #6]
 8000e6c:	80b9      	strh	r1, [r7, #4]
 8000e6e:	807a      	strh	r2, [r7, #2]
 8000e70:	803b      	strh	r3, [r7, #0]
	u16 x,y;
	s16 delta,tmp;
	x=0;
 8000e72:	f04f 0300 	mov.w	r3, #0
 8000e76:	81fb      	strh	r3, [r7, #14]
	y=r;
 8000e78:	887b      	ldrh	r3, [r7, #2]
 8000e7a:	81bb      	strh	r3, [r7, #12]
	delta=3-(r<<1);
 8000e7c:	887b      	ldrh	r3, [r7, #2]
 8000e7e:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8000e82:	b29b      	uxth	r3, r3
 8000e84:	f1c3 0303 	rsb	r3, r3, #3
 8000e88:	b29b      	uxth	r3, r3
 8000e8a:	817b      	strh	r3, [r7, #10]

	while(y>x)
 8000e8c:	e0f0      	b.n	8001070 <GUI_Circle+0x20c>
	{
		if(fill)
 8000e8e:	f897 3020 	ldrb.w	r3, [r7, #32]
 8000e92:	2b00      	cmp	r3, #0
 8000e94:	d050      	beq.n	8000f38 <GUI_Circle+0xd4>
		{
			GUI_Line(cx+x,cy+y,cx-x,cy+y,color);
 8000e96:	88fa      	ldrh	r2, [r7, #6]
 8000e98:	89fb      	ldrh	r3, [r7, #14]
 8000e9a:	18d3      	adds	r3, r2, r3
 8000e9c:	b298      	uxth	r0, r3
 8000e9e:	88ba      	ldrh	r2, [r7, #4]
 8000ea0:	89bb      	ldrh	r3, [r7, #12]
 8000ea2:	18d3      	adds	r3, r2, r3
 8000ea4:	b299      	uxth	r1, r3
 8000ea6:	88fa      	ldrh	r2, [r7, #6]
 8000ea8:	89fb      	ldrh	r3, [r7, #14]
 8000eaa:	1ad3      	subs	r3, r2, r3
 8000eac:	b29a      	uxth	r2, r3
 8000eae:	88bc      	ldrh	r4, [r7, #4]
 8000eb0:	89bb      	ldrh	r3, [r7, #12]
 8000eb2:	18e3      	adds	r3, r4, r3
 8000eb4:	b29b      	uxth	r3, r3
 8000eb6:	883c      	ldrh	r4, [r7, #0]
 8000eb8:	9400      	str	r4, [sp, #0]
 8000eba:	f7ff fe41 	bl	8000b40 <GUI_Line>
			GUI_Line(cx+x,cy-y,cx-x,cy-y,color);
 8000ebe:	88fa      	ldrh	r2, [r7, #6]
 8000ec0:	89fb      	ldrh	r3, [r7, #14]
 8000ec2:	18d3      	adds	r3, r2, r3
 8000ec4:	b298      	uxth	r0, r3
 8000ec6:	88ba      	ldrh	r2, [r7, #4]
 8000ec8:	89bb      	ldrh	r3, [r7, #12]
 8000eca:	1ad3      	subs	r3, r2, r3
 8000ecc:	b299      	uxth	r1, r3
 8000ece:	88fa      	ldrh	r2, [r7, #6]
 8000ed0:	89fb      	ldrh	r3, [r7, #14]
 8000ed2:	1ad3      	subs	r3, r2, r3
 8000ed4:	b29a      	uxth	r2, r3
 8000ed6:	88bc      	ldrh	r4, [r7, #4]
 8000ed8:	89bb      	ldrh	r3, [r7, #12]
 8000eda:	1ae3      	subs	r3, r4, r3
 8000edc:	b29b      	uxth	r3, r3
 8000ede:	883c      	ldrh	r4, [r7, #0]
 8000ee0:	9400      	str	r4, [sp, #0]
 8000ee2:	f7ff fe2d 	bl	8000b40 <GUI_Line>
			GUI_Line(cx+y,cy+x,cx-y,cy+x,color);
 8000ee6:	88fa      	ldrh	r2, [r7, #6]
 8000ee8:	89bb      	ldrh	r3, [r7, #12]
 8000eea:	18d3      	adds	r3, r2, r3
 8000eec:	b298      	uxth	r0, r3
 8000eee:	88ba      	ldrh	r2, [r7, #4]
 8000ef0:	89fb      	ldrh	r3, [r7, #14]
 8000ef2:	18d3      	adds	r3, r2, r3
 8000ef4:	b299      	uxth	r1, r3
 8000ef6:	88fa      	ldrh	r2, [r7, #6]
 8000ef8:	89bb      	ldrh	r3, [r7, #12]
 8000efa:	1ad3      	subs	r3, r2, r3
 8000efc:	b29a      	uxth	r2, r3
 8000efe:	88bc      	ldrh	r4, [r7, #4]
 8000f00:	89fb      	ldrh	r3, [r7, #14]
 8000f02:	18e3      	adds	r3, r4, r3
 8000f04:	b29b      	uxth	r3, r3
 8000f06:	883c      	ldrh	r4, [r7, #0]
 8000f08:	9400      	str	r4, [sp, #0]
 8000f0a:	f7ff fe19 	bl	8000b40 <GUI_Line>
			GUI_Line(cx+y,cy-x,cx-y,cy-x,color);
 8000f0e:	88fa      	ldrh	r2, [r7, #6]
 8000f10:	89bb      	ldrh	r3, [r7, #12]
 8000f12:	18d3      	adds	r3, r2, r3
 8000f14:	b298      	uxth	r0, r3
 8000f16:	88ba      	ldrh	r2, [r7, #4]
 8000f18:	89fb      	ldrh	r3, [r7, #14]
 8000f1a:	1ad3      	subs	r3, r2, r3
 8000f1c:	b299      	uxth	r1, r3
 8000f1e:	88fa      	ldrh	r2, [r7, #6]
 8000f20:	89bb      	ldrh	r3, [r7, #12]
 8000f22:	1ad3      	subs	r3, r2, r3
 8000f24:	b29a      	uxth	r2, r3
 8000f26:	88bc      	ldrh	r4, [r7, #4]
 8000f28:	89fb      	ldrh	r3, [r7, #14]
 8000f2a:	1ae3      	subs	r3, r4, r3
 8000f2c:	b29b      	uxth	r3, r3
 8000f2e:	883c      	ldrh	r4, [r7, #0]
 8000f30:	9400      	str	r4, [sp, #0]
 8000f32:	f7ff fe05 	bl	8000b40 <GUI_Line>
 8000f36:	e06f      	b.n	8001018 <GUI_Circle+0x1b4>
		}
		else
		{
			ili9320_SetPoint(cx+x,cy+y,color);
 8000f38:	88fa      	ldrh	r2, [r7, #6]
 8000f3a:	89fb      	ldrh	r3, [r7, #14]
 8000f3c:	18d3      	adds	r3, r2, r3
 8000f3e:	b299      	uxth	r1, r3
 8000f40:	88ba      	ldrh	r2, [r7, #4]
 8000f42:	89bb      	ldrh	r3, [r7, #12]
 8000f44:	18d3      	adds	r3, r2, r3
 8000f46:	b29a      	uxth	r2, r3
 8000f48:	883b      	ldrh	r3, [r7, #0]
 8000f4a:	4608      	mov	r0, r1
 8000f4c:	4611      	mov	r1, r2
 8000f4e:	461a      	mov	r2, r3
 8000f50:	f000 fa44 	bl	80013dc <ili9320_SetPoint>
			ili9320_SetPoint(cx-x,cy+y,color);
 8000f54:	88fa      	ldrh	r2, [r7, #6]
 8000f56:	89fb      	ldrh	r3, [r7, #14]
 8000f58:	1ad3      	subs	r3, r2, r3
 8000f5a:	b299      	uxth	r1, r3
 8000f5c:	88ba      	ldrh	r2, [r7, #4]
 8000f5e:	89bb      	ldrh	r3, [r7, #12]
 8000f60:	18d3      	adds	r3, r2, r3
 8000f62:	b29a      	uxth	r2, r3
 8000f64:	883b      	ldrh	r3, [r7, #0]
 8000f66:	4608      	mov	r0, r1
 8000f68:	4611      	mov	r1, r2
 8000f6a:	461a      	mov	r2, r3
 8000f6c:	f000 fa36 	bl	80013dc <ili9320_SetPoint>
			ili9320_SetPoint(cx+x,cy-y,color);
 8000f70:	88fa      	ldrh	r2, [r7, #6]
 8000f72:	89fb      	ldrh	r3, [r7, #14]
 8000f74:	18d3      	adds	r3, r2, r3
 8000f76:	b299      	uxth	r1, r3
 8000f78:	88ba      	ldrh	r2, [r7, #4]
 8000f7a:	89bb      	ldrh	r3, [r7, #12]
 8000f7c:	1ad3      	subs	r3, r2, r3
 8000f7e:	b29a      	uxth	r2, r3
 8000f80:	883b      	ldrh	r3, [r7, #0]
 8000f82:	4608      	mov	r0, r1
 8000f84:	4611      	mov	r1, r2
 8000f86:	461a      	mov	r2, r3
 8000f88:	f000 fa28 	bl	80013dc <ili9320_SetPoint>
			ili9320_SetPoint(cx-x,cy-y,color);
 8000f8c:	88fa      	ldrh	r2, [r7, #6]
 8000f8e:	89fb      	ldrh	r3, [r7, #14]
 8000f90:	1ad3      	subs	r3, r2, r3
 8000f92:	b299      	uxth	r1, r3
 8000f94:	88ba      	ldrh	r2, [r7, #4]
 8000f96:	89bb      	ldrh	r3, [r7, #12]
 8000f98:	1ad3      	subs	r3, r2, r3
 8000f9a:	b29a      	uxth	r2, r3
 8000f9c:	883b      	ldrh	r3, [r7, #0]
 8000f9e:	4608      	mov	r0, r1
 8000fa0:	4611      	mov	r1, r2
 8000fa2:	461a      	mov	r2, r3
 8000fa4:	f000 fa1a 	bl	80013dc <ili9320_SetPoint>
			ili9320_SetPoint(cx+y,cy+x,color);
 8000fa8:	88fa      	ldrh	r2, [r7, #6]
 8000faa:	89bb      	ldrh	r3, [r7, #12]
 8000fac:	18d3      	adds	r3, r2, r3
 8000fae:	b299      	uxth	r1, r3
 8000fb0:	88ba      	ldrh	r2, [r7, #4]
 8000fb2:	89fb      	ldrh	r3, [r7, #14]
 8000fb4:	18d3      	adds	r3, r2, r3
 8000fb6:	b29a      	uxth	r2, r3
 8000fb8:	883b      	ldrh	r3, [r7, #0]
 8000fba:	4608      	mov	r0, r1
 8000fbc:	4611      	mov	r1, r2
 8000fbe:	461a      	mov	r2, r3
 8000fc0:	f000 fa0c 	bl	80013dc <ili9320_SetPoint>
			ili9320_SetPoint(cx-y,cy+x,color);
 8000fc4:	88fa      	ldrh	r2, [r7, #6]
 8000fc6:	89bb      	ldrh	r3, [r7, #12]
 8000fc8:	1ad3      	subs	r3, r2, r3
 8000fca:	b299      	uxth	r1, r3
 8000fcc:	88ba      	ldrh	r2, [r7, #4]
 8000fce:	89fb      	ldrh	r3, [r7, #14]
 8000fd0:	18d3      	adds	r3, r2, r3
 8000fd2:	b29a      	uxth	r2, r3
 8000fd4:	883b      	ldrh	r3, [r7, #0]
 8000fd6:	4608      	mov	r0, r1
 8000fd8:	4611      	mov	r1, r2
 8000fda:	461a      	mov	r2, r3
 8000fdc:	f000 f9fe 	bl	80013dc <ili9320_SetPoint>
			ili9320_SetPoint(cx+y,cy-x,color);
 8000fe0:	88fa      	ldrh	r2, [r7, #6]
 8000fe2:	89bb      	ldrh	r3, [r7, #12]
 8000fe4:	18d3      	adds	r3, r2, r3
 8000fe6:	b299      	uxth	r1, r3
 8000fe8:	88ba      	ldrh	r2, [r7, #4]
 8000fea:	89fb      	ldrh	r3, [r7, #14]
 8000fec:	1ad3      	subs	r3, r2, r3
 8000fee:	b29a      	uxth	r2, r3
 8000ff0:	883b      	ldrh	r3, [r7, #0]
 8000ff2:	4608      	mov	r0, r1
 8000ff4:	4611      	mov	r1, r2
 8000ff6:	461a      	mov	r2, r3
 8000ff8:	f000 f9f0 	bl	80013dc <ili9320_SetPoint>
			ili9320_SetPoint(cx-y,cy-x,color);
 8000ffc:	88fa      	ldrh	r2, [r7, #6]
 8000ffe:	89bb      	ldrh	r3, [r7, #12]
 8001000:	1ad3      	subs	r3, r2, r3
 8001002:	b299      	uxth	r1, r3
 8001004:	88ba      	ldrh	r2, [r7, #4]
 8001006:	89fb      	ldrh	r3, [r7, #14]
 8001008:	1ad3      	subs	r3, r2, r3
 800100a:	b29a      	uxth	r2, r3
 800100c:	883b      	ldrh	r3, [r7, #0]
 800100e:	4608      	mov	r0, r1
 8001010:	4611      	mov	r1, r2
 8001012:	461a      	mov	r2, r3
 8001014:	f000 f9e2 	bl	80013dc <ili9320_SetPoint>
		}
		x++;
 8001018:	89fb      	ldrh	r3, [r7, #14]
 800101a:	f103 0301 	add.w	r3, r3, #1
 800101e:	81fb      	strh	r3, [r7, #14]
		if(delta>=0)
 8001020:	f9b7 300a 	ldrsh.w	r3, [r7, #10]
 8001024:	2b00      	cmp	r3, #0
 8001026:	db18      	blt.n	800105a <GUI_Circle+0x1f6>
		{
			y--;
 8001028:	89bb      	ldrh	r3, [r7, #12]
 800102a:	f103 33ff 	add.w	r3, r3, #4294967295
 800102e:	81bb      	strh	r3, [r7, #12]
			tmp=(x<<2);
 8001030:	89fb      	ldrh	r3, [r7, #14]
 8001032:	ea4f 0383 	mov.w	r3, r3, lsl #2
 8001036:	813b      	strh	r3, [r7, #8]
			tmp-=(y<<2);
 8001038:	893a      	ldrh	r2, [r7, #8]
 800103a:	89bb      	ldrh	r3, [r7, #12]
 800103c:	ea4f 0383 	mov.w	r3, r3, lsl #2
 8001040:	b29b      	uxth	r3, r3
 8001042:	1ad3      	subs	r3, r2, r3
 8001044:	b29b      	uxth	r3, r3
 8001046:	813b      	strh	r3, [r7, #8]
			delta+=(tmp+10);
 8001048:	893a      	ldrh	r2, [r7, #8]
 800104a:	897b      	ldrh	r3, [r7, #10]
 800104c:	18d3      	adds	r3, r2, r3
 800104e:	b29b      	uxth	r3, r3
 8001050:	f103 030a 	add.w	r3, r3, #10
 8001054:	b29b      	uxth	r3, r3
 8001056:	817b      	strh	r3, [r7, #10]
 8001058:	e00a      	b.n	8001070 <GUI_Circle+0x20c>
		}
		else
		{
			delta+=((x<<2)+6);
 800105a:	89fb      	ldrh	r3, [r7, #14]
 800105c:	ea4f 0383 	mov.w	r3, r3, lsl #2
 8001060:	b29a      	uxth	r2, r3
 8001062:	897b      	ldrh	r3, [r7, #10]
 8001064:	18d3      	adds	r3, r2, r3
 8001066:	b29b      	uxth	r3, r3
 8001068:	f103 0306 	add.w	r3, r3, #6
 800106c:	b29b      	uxth	r3, r3
 800106e:	817b      	strh	r3, [r7, #10]
	s16 delta,tmp;
	x=0;
	y=r;
	delta=3-(r<<1);

	while(y>x)
 8001070:	89ba      	ldrh	r2, [r7, #12]
 8001072:	89fb      	ldrh	r3, [r7, #14]
 8001074:	429a      	cmp	r2, r3
 8001076:	f63f af0a 	bhi.w	8000e8e <GUI_Circle+0x2a>
		else
		{
			delta+=((x<<2)+6);
		}
	}
}
 800107a:	f107 0714 	add.w	r7, r7, #20
 800107e:	46bd      	mov	sp, r7
 8001080:	bd90      	pop	{r4, r7, pc}
 8001082:	bf00      	nop

08001084 <GUI_Rectangle>:
* 出口参数：
* 说    明：
* 调用方法：
****************************************************************************/
void GUI_Rectangle(u16 x0, u16 y0, u16 x1, u16 y1,u16 color,u8 fill)
{
 8001084:	b590      	push	{r4, r7, lr}
 8001086:	b087      	sub	sp, #28
 8001088:	af02      	add	r7, sp, #8
 800108a:	80f8      	strh	r0, [r7, #6]
 800108c:	80b9      	strh	r1, [r7, #4]
 800108e:	807a      	strh	r2, [r7, #2]
 8001090:	803b      	strh	r3, [r7, #0]
	if(fill)
 8001092:	f897 3024 	ldrb.w	r3, [r7, #36]	; 0x24
 8001096:	2b00      	cmp	r3, #0
 8001098:	d01c      	beq.n	80010d4 <GUI_Rectangle+0x50>
	{
		u16 i;
		if(x0>x1)
 800109a:	88fa      	ldrh	r2, [r7, #6]
 800109c:	887b      	ldrh	r3, [r7, #2]
 800109e:	429a      	cmp	r2, r3
 80010a0:	d904      	bls.n	80010ac <GUI_Rectangle+0x28>
		{
			i=x1;
 80010a2:	887b      	ldrh	r3, [r7, #2]
 80010a4:	81fb      	strh	r3, [r7, #14]
			x1=x0;
 80010a6:	88fb      	ldrh	r3, [r7, #6]
 80010a8:	807b      	strh	r3, [r7, #2]
		}
		else
		{
			i=x0;
		}
		for(;i<=x1;i++)
 80010aa:	e00e      	b.n	80010ca <GUI_Rectangle+0x46>
			i=x1;
			x1=x0;
		}
		else
		{
			i=x0;
 80010ac:	88fb      	ldrh	r3, [r7, #6]
 80010ae:	81fb      	strh	r3, [r7, #14]
		}
		for(;i<=x1;i++)
 80010b0:	e00b      	b.n	80010ca <GUI_Rectangle+0x46>
		{
			GUI_Line(i,y0,i,y1,color);
 80010b2:	89f8      	ldrh	r0, [r7, #14]
 80010b4:	88b9      	ldrh	r1, [r7, #4]
 80010b6:	89fa      	ldrh	r2, [r7, #14]
 80010b8:	883b      	ldrh	r3, [r7, #0]
 80010ba:	8c3c      	ldrh	r4, [r7, #32]
 80010bc:	9400      	str	r4, [sp, #0]
 80010be:	f7ff fd3f 	bl	8000b40 <GUI_Line>
		}
		else
		{
			i=x0;
		}
		for(;i<=x1;i++)
 80010c2:	89fb      	ldrh	r3, [r7, #14]
 80010c4:	f103 0301 	add.w	r3, r3, #1
 80010c8:	81fb      	strh	r3, [r7, #14]
 80010ca:	89fa      	ldrh	r2, [r7, #14]
 80010cc:	887b      	ldrh	r3, [r7, #2]
 80010ce:	429a      	cmp	r2, r3
 80010d0:	d9ef      	bls.n	80010b2 <GUI_Rectangle+0x2e>
		{
			GUI_Line(i,y0,i,y1,color);
		}
		return;
 80010d2:	e01f      	b.n	8001114 <GUI_Rectangle+0x90>
	}
	GUI_Line(x0,y0,x0,y1,color);
 80010d4:	88f8      	ldrh	r0, [r7, #6]
 80010d6:	88b9      	ldrh	r1, [r7, #4]
 80010d8:	88fa      	ldrh	r2, [r7, #6]
 80010da:	883b      	ldrh	r3, [r7, #0]
 80010dc:	8c3c      	ldrh	r4, [r7, #32]
 80010de:	9400      	str	r4, [sp, #0]
 80010e0:	f7ff fd2e 	bl	8000b40 <GUI_Line>
	GUI_Line(x0,y1,x1,y1,color);
 80010e4:	88f8      	ldrh	r0, [r7, #6]
 80010e6:	8839      	ldrh	r1, [r7, #0]
 80010e8:	887a      	ldrh	r2, [r7, #2]
 80010ea:	883b      	ldrh	r3, [r7, #0]
 80010ec:	8c3c      	ldrh	r4, [r7, #32]
 80010ee:	9400      	str	r4, [sp, #0]
 80010f0:	f7ff fd26 	bl	8000b40 <GUI_Line>
	GUI_Line(x1,y1,x1,y0,color);
 80010f4:	8878      	ldrh	r0, [r7, #2]
 80010f6:	8839      	ldrh	r1, [r7, #0]
 80010f8:	887a      	ldrh	r2, [r7, #2]
 80010fa:	88bb      	ldrh	r3, [r7, #4]
 80010fc:	8c3c      	ldrh	r4, [r7, #32]
 80010fe:	9400      	str	r4, [sp, #0]
 8001100:	f7ff fd1e 	bl	8000b40 <GUI_Line>
	GUI_Line(x1,y0,x0,y0,color);
 8001104:	8878      	ldrh	r0, [r7, #2]
 8001106:	88b9      	ldrh	r1, [r7, #4]
 8001108:	88fa      	ldrh	r2, [r7, #6]
 800110a:	88bb      	ldrh	r3, [r7, #4]
 800110c:	8c3c      	ldrh	r4, [r7, #32]
 800110e:	9400      	str	r4, [sp, #0]
 8001110:	f7ff fd16 	bl	8000b40 <GUI_Line>
}
 8001114:	f107 0714 	add.w	r7, r7, #20
 8001118:	46bd      	mov	sp, r7
 800111a:	bd90      	pop	{r4, r7, pc}

0800111c <GUI_Square>:
* 出口参数：
* 说    明：
* 调用方法：
****************************************************************************/
void  GUI_Square(u16 x0, u16 y0, u16 with, u16 color,u8 fill)
{
 800111c:	b590      	push	{r4, r7, lr}
 800111e:	b085      	sub	sp, #20
 8001120:	af02      	add	r7, sp, #8
 8001122:	80f8      	strh	r0, [r7, #6]
 8001124:	80b9      	strh	r1, [r7, #4]
 8001126:	807a      	strh	r2, [r7, #2]
 8001128:	803b      	strh	r3, [r7, #0]
	GUI_Rectangle(x0, y0, x0+with, y0+with, color,fill);
 800112a:	88fa      	ldrh	r2, [r7, #6]
 800112c:	887b      	ldrh	r3, [r7, #2]
 800112e:	18d3      	adds	r3, r2, r3
 8001130:	b29a      	uxth	r2, r3
 8001132:	88b9      	ldrh	r1, [r7, #4]
 8001134:	887b      	ldrh	r3, [r7, #2]
 8001136:	18cb      	adds	r3, r1, r3
 8001138:	b29b      	uxth	r3, r3
 800113a:	88f8      	ldrh	r0, [r7, #6]
 800113c:	88b9      	ldrh	r1, [r7, #4]
 800113e:	883c      	ldrh	r4, [r7, #0]
 8001140:	9400      	str	r4, [sp, #0]
 8001142:	7e3c      	ldrb	r4, [r7, #24]
 8001144:	9401      	str	r4, [sp, #4]
 8001146:	f7ff ff9d 	bl	8001084 <GUI_Rectangle>
}
 800114a:	f107 070c 	add.w	r7, r7, #12
 800114e:	46bd      	mov	sp, r7
 8001150:	bd90      	pop	{r4, r7, pc}
 8001152:	bf00      	nop

08001154 <CheckController>:
* 出口参数：控制器型号
* 说    明：调用后返回兼容型号的控制器型号
* 调用方法：code=CheckController();
****************************************************************************/
u16 CheckController(void)
{
 8001154:	b580      	push	{r7, lr}
 8001156:	b082      	sub	sp, #8
 8001158:	af00      	add	r7, sp, #0
  GPIO_InitTypeDef GPIO_InitStructure;
  u16 tmp=0;
 800115a:	f04f 0300 	mov.w	r3, #0
 800115e:	80fb      	strh	r3, [r7, #6]
  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOE, ENABLE);
 8001160:	f04f 0040 	mov.w	r0, #64	; 0x40
 8001164:	f04f 0101 	mov.w	r1, #1
 8001168:	f002 fece 	bl	8003f08 <RCC_APB2PeriphClockCmd>
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_All;
 800116c:	f64f 73ff 	movw	r3, #65535	; 0xffff
 8001170:	803b      	strh	r3, [r7, #0]
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
 8001172:	f04f 0303 	mov.w	r3, #3
 8001176:	70bb      	strb	r3, [r7, #2]
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
 8001178:	f04f 0310 	mov.w	r3, #16
 800117c:	70fb      	strb	r3, [r7, #3]
  GPIO_Init(GPIOE, &GPIO_InitStructure);//数据线在PE口
 800117e:	463b      	mov	r3, r7
 8001180:	f44f 50c0 	mov.w	r0, #6144	; 0x1800
 8001184:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8001188:	4619      	mov	r1, r3
 800118a:	f002 f849 	bl	8003220 <GPIO_Init>
  

  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOD,ENABLE);
 800118e:	f04f 0020 	mov.w	r0, #32
 8001192:	f04f 0101 	mov.w	r1, #1
 8001196:	f002 feb7 	bl	8003f08 <RCC_APB2PeriphClockCmd>
  GPIO_InitStructure.GPIO_Pin = nReset|nCS|nWR|RS|nRD;
 800119a:	f04f 031f 	mov.w	r3, #31
 800119e:	803b      	strh	r3, [r7, #0]
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
 80011a0:	f04f 0303 	mov.w	r3, #3
 80011a4:	70bb      	strb	r3, [r7, #2]
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
 80011a6:	f04f 0310 	mov.w	r3, #16
 80011aa:	70fb      	strb	r3, [r7, #3]
  GPIO_Init(GPIOD, &GPIO_InitStructure);
 80011ac:	463b      	mov	r3, r7
 80011ae:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 80011b2:	f2c4 0001 	movt	r0, #16385	; 0x4001
 80011b6:	4619      	mov	r1, r3
 80011b8:	f002 f832 	bl	8003220 <GPIO_Init>
  GPIO_PinLockConfig(GPIOD,nReset|nCS|nWR|RS|nRD);
 80011bc:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 80011c0:	f2c4 0001 	movt	r0, #16385	; 0x4001
 80011c4:	f04f 011f 	mov.w	r1, #31
 80011c8:	f002 f9b2 	bl	8003530 <GPIO_PinLockConfig>
  
  GPIO_SetBits( GPIOD, nReset | nCS | nWR | RS | nRD );
 80011cc:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 80011d0:	f2c4 0001 	movt	r0, #16385	; 0x4001
 80011d4:	f04f 011f 	mov.w	r1, #31
 80011d8:	f002 f968 	bl	80034ac <GPIO_SetBits>
  
  ili9320_Reset();
 80011dc:	f000 fa8e 	bl	80016fc <ili9320_Reset>

  ili9320_WriteRegister(0x0000,0x0001);ili9320_Delay(50000);
 80011e0:	f04f 0000 	mov.w	r0, #0
 80011e4:	f04f 0101 	mov.w	r1, #1
 80011e8:	f000 fa76 	bl	80016d8 <ili9320_WriteRegister>
 80011ec:	f24c 3050 	movw	r0, #50000	; 0xc350
 80011f0:	f000 fa94 	bl	800171c <ili9320_Delay>
  
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_All;
 80011f4:	f64f 73ff 	movw	r3, #65535	; 0xffff
 80011f8:	803b      	strh	r3, [r7, #0]
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
 80011fa:	f04f 0302 	mov.w	r3, #2
 80011fe:	70bb      	strb	r3, [r7, #2]
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
 8001200:	f04f 0304 	mov.w	r3, #4
 8001204:	70fb      	strb	r3, [r7, #3]
  GPIO_Init(GPIOE, &GPIO_InitStructure);
 8001206:	463b      	mov	r3, r7
 8001208:	f44f 50c0 	mov.w	r0, #6144	; 0x1800
 800120c:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8001210:	4619      	mov	r1, r3
 8001212:	f002 f805 	bl	8003220 <GPIO_Init>
  
  GPIO_ResetBits(GPIOD,nCS);
 8001216:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 800121a:	f2c4 0001 	movt	r0, #16385	; 0x4001
 800121e:	f04f 0101 	mov.w	r1, #1
 8001222:	f002 f951 	bl	80034c8 <GPIO_ResetBits>
  
  GPIO_SetBits(GPIOD,RS);
 8001226:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 800122a:	f2c4 0001 	movt	r0, #16385	; 0x4001
 800122e:	f04f 0102 	mov.w	r1, #2
 8001232:	f002 f93b 	bl	80034ac <GPIO_SetBits>
  
  GPIO_ResetBits(GPIOD,nRD);
 8001236:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 800123a:	f2c4 0001 	movt	r0, #16385	; 0x4001
 800123e:	f04f 0108 	mov.w	r1, #8
 8001242:	f002 f941 	bl	80034c8 <GPIO_ResetBits>
  tmp=GPIO_ReadInputData(GPIOE);
 8001246:	f44f 50c0 	mov.w	r0, #6144	; 0x1800
 800124a:	f2c4 0001 	movt	r0, #16385	; 0x4001
 800124e:	f002 f8f3 	bl	8003438 <GPIO_ReadInputData>
 8001252:	4603      	mov	r3, r0
 8001254:	80fb      	strh	r3, [r7, #6]
  
  GPIO_SetBits(GPIOD,nRD);
 8001256:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 800125a:	f2c4 0001 	movt	r0, #16385	; 0x4001
 800125e:	f04f 0108 	mov.w	r1, #8
 8001262:	f002 f923 	bl	80034ac <GPIO_SetBits>
  
  GPIO_SetBits(GPIOD,nCS);
 8001266:	f44f 50a0 	mov.w	r0, #5120	; 0x1400
 800126a:	f2c4 0001 	movt	r0, #16385	; 0x4001
 800126e:	f04f 0101 	mov.w	r1, #1
 8001272:	f002 f91b 	bl	80034ac <GPIO_SetBits>
  
  return tmp;
 8001276:	88fb      	ldrh	r3, [r7, #6]
}
 8001278:	4618      	mov	r0, r3
 800127a:	f107 0708 	add.w	r7, r7, #8
 800127e:	46bd      	mov	sp, r7
 8001280:	bd80      	pop	{r7, pc}
 8001282:	bf00      	nop

08001284 <ili9320_Initializtion>:
* 出口参数：无
* 说    明：
* 调用方法：ili9320_Initializtion();
****************************************************************************/
void ili9320_Initializtion()
{ 
 8001284:	b580      	push	{r7, lr}
 8001286:	af00      	add	r7, sp, #0
   LCD_Init();
 8001288:	f000 fab2 	bl	80017f0 <LCD_Init>
}
 800128c:	bd80      	pop	{r7, pc}
 800128e:	bf00      	nop

08001290 <ili9320_SetCursor>:
* 出口参数：无
* 说    明：
* 调用方法：ili9320_SetCursor(10,10);
****************************************************************************/
void ili9320_SetCursor(u16 x,u16 y)
{				
 8001290:	b580      	push	{r7, lr}
 8001292:	b082      	sub	sp, #8
 8001294:	af00      	add	r7, sp, #0
 8001296:	4602      	mov	r2, r0
 8001298:	460b      	mov	r3, r1
 800129a:	80fa      	strh	r2, [r7, #6]
 800129c:	80bb      	strh	r3, [r7, #4]
  //LCD_WR_CMD(0,0x02,x);
  //LCD_WR_CMD(1,0x03,y);  
  
 
  LCD_WR_CMD(32, y);
 800129e:	88bb      	ldrh	r3, [r7, #4]
 80012a0:	f04f 0020 	mov.w	r0, #32
 80012a4:	4619      	mov	r1, r3
 80012a6:	f000 fa59 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(33, 319-x);
 80012aa:	88fb      	ldrh	r3, [r7, #6]
 80012ac:	f5c3 739f 	rsb	r3, r3, #318	; 0x13e
 80012b0:	f103 0301 	add.w	r3, r3, #1
 80012b4:	f04f 0021 	mov.w	r0, #33	; 0x21
 80012b8:	4619      	mov	r1, r3
 80012ba:	f000 fa4f 	bl	800175c <LCD_WR_CMD>
		//*(__IO uint16_t *) (Bank1_LCD_C)= 34;
  //LCD_WR_REG(34);


}
 80012be:	f107 0708 	add.w	r7, r7, #8
 80012c2:	46bd      	mov	sp, r7
 80012c4:	bd80      	pop	{r7, pc}
 80012c6:	bf00      	nop

080012c8 <ili9320_SetWindows>:
* 出口参数：无
* 说    明：
* 调用方法：ili9320_SetWindows(0,0,100,100)；
****************************************************************************/
void ili9320_SetWindows(u16 StartX,u16 StartY,u16 EndX,u16 EndY)
{
 80012c8:	b580      	push	{r7, lr}
 80012ca:	b082      	sub	sp, #8
 80012cc:	af00      	add	r7, sp, #0
 80012ce:	80f8      	strh	r0, [r7, #6]
 80012d0:	80b9      	strh	r1, [r7, #4]
 80012d2:	807a      	strh	r2, [r7, #2]
 80012d4:	803b      	strh	r3, [r7, #0]
  LCD_WR_CMD(0x0050, StartY); // Horizontal GRAM Start Address
 80012d6:	88bb      	ldrh	r3, [r7, #4]
 80012d8:	f04f 0050 	mov.w	r0, #80	; 0x50
 80012dc:	4619      	mov	r1, r3
 80012de:	f000 fa3d 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(0x0051, EndX); // Horizontal GRAM End Address
 80012e2:	887b      	ldrh	r3, [r7, #2]
 80012e4:	f04f 0051 	mov.w	r0, #81	; 0x51
 80012e8:	4619      	mov	r1, r3
 80012ea:	f000 fa37 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(0x0052, 319-StartX); // Vertical GRAM Start Address
 80012ee:	88fb      	ldrh	r3, [r7, #6]
 80012f0:	f5c3 739f 	rsb	r3, r3, #318	; 0x13e
 80012f4:	f103 0301 	add.w	r3, r3, #1
 80012f8:	f04f 0052 	mov.w	r0, #82	; 0x52
 80012fc:	4619      	mov	r1, r3
 80012fe:	f000 fa2d 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(0x0053, EndY); // Vertical GRAM Start Address	 
 8001302:	883b      	ldrh	r3, [r7, #0]
 8001304:	f04f 0053 	mov.w	r0, #83	; 0x53
 8001308:	4619      	mov	r1, r3
 800130a:	f000 fa27 	bl	800175c <LCD_WR_CMD>

  //LCD_WR_REG(34);

  
}
 800130e:	f107 0708 	add.w	r7, r7, #8
 8001312:	46bd      	mov	sp, r7
 8001314:	bd80      	pop	{r7, pc}
 8001316:	bf00      	nop

08001318 <ili9320_Clear>:
* 出口参数：无
* 说    明：
* 调用方法：ili9320_Clear(0xffff);
****************************************************************************/
void ili9320_Clear(u16 dat)
{
 8001318:	b580      	push	{r7, lr}
 800131a:	b084      	sub	sp, #16
 800131c:	af00      	add	r7, sp, #0
 800131e:	4603      	mov	r3, r0
 8001320:	80fb      	strh	r3, [r7, #6]
  u32 i;
  LCD_WR_CMD(0x0050, 0); // Horizontal GRAM Start Address
 8001322:	f04f 0050 	mov.w	r0, #80	; 0x50
 8001326:	f04f 0100 	mov.w	r1, #0
 800132a:	f000 fa17 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(0x0051, 239); // Horizontal GRAM End Address
 800132e:	f04f 0051 	mov.w	r0, #81	; 0x51
 8001332:	f04f 01ef 	mov.w	r1, #239	; 0xef
 8001336:	f000 fa11 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(0x0052, 0); // Vertical GRAM Start Address
 800133a:	f04f 0052 	mov.w	r0, #82	; 0x52
 800133e:	f04f 0100 	mov.w	r1, #0
 8001342:	f000 fa0b 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(0x0053, 319); // Vertical GRAM Start Address	 
 8001346:	f04f 0053 	mov.w	r0, #83	; 0x53
 800134a:	f240 113f 	movw	r1, #319	; 0x13f
 800134e:	f000 fa05 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(32, 0);
 8001352:	f04f 0020 	mov.w	r0, #32
 8001356:	f04f 0100 	mov.w	r1, #0
 800135a:	f000 f9ff 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(33, 0);
 800135e:	f04f 0021 	mov.w	r0, #33	; 0x21
 8001362:	f04f 0100 	mov.w	r1, #0
 8001366:	f000 f9f9 	bl	800175c <LCD_WR_CMD>
		//*(__IO uint16_t *) (Bank1_LCD_C)= 34;
  LCD_WR_REG(34);
 800136a:	f04f 0022 	mov.w	r0, #34	; 0x22
 800136e:	f000 f9e7 	bl	8001740 <LCD_WR_REG>
  for(i=0;i<76800;i++) LCD_WR_Data(dat);  
 8001372:	f04f 0300 	mov.w	r3, #0
 8001376:	60fb      	str	r3, [r7, #12]
 8001378:	e007      	b.n	800138a <ili9320_Clear+0x72>
 800137a:	88fb      	ldrh	r3, [r7, #6]
 800137c:	4618      	mov	r0, r3
 800137e:	f000 fa17 	bl	80017b0 <LCD_WR_Data>
 8001382:	68fb      	ldr	r3, [r7, #12]
 8001384:	f103 0301 	add.w	r3, r3, #1
 8001388:	60fb      	str	r3, [r7, #12]
 800138a:	68fa      	ldr	r2, [r7, #12]
 800138c:	f642 33ff 	movw	r3, #11263	; 0x2bff
 8001390:	f2c0 0301 	movt	r3, #1
 8001394:	429a      	cmp	r2, r3
 8001396:	d9f0      	bls.n	800137a <ili9320_Clear+0x62>
}
 8001398:	f107 0710 	add.w	r7, r7, #16
 800139c:	46bd      	mov	sp, r7
 800139e:	bd80      	pop	{r7, pc}

080013a0 <ili9320_GetPoint>:
* 出口参数：当前座标颜色值
* 说    明：
* 调用方法：i=ili9320_GetPoint(10,10);
****************************************************************************/
u16 ili9320_GetPoint(u16 x,u16 y)
{ 
 80013a0:	b580      	push	{r7, lr}
 80013a2:	b082      	sub	sp, #8
 80013a4:	af00      	add	r7, sp, #0
 80013a6:	4602      	mov	r2, r0
 80013a8:	460b      	mov	r3, r1
 80013aa:	80fa      	strh	r2, [r7, #6]
 80013ac:	80bb      	strh	r3, [r7, #4]
  //u16 temp;
  ili9320_SetCursor(x,y);
 80013ae:	88fa      	ldrh	r2, [r7, #6]
 80013b0:	88bb      	ldrh	r3, [r7, #4]
 80013b2:	4610      	mov	r0, r2
 80013b4:	4619      	mov	r1, r3
 80013b6:	f7ff ff6b 	bl	8001290 <ili9320_SetCursor>
  LCD_WR_REG(34);
 80013ba:	f04f 0022 	mov.w	r0, #34	; 0x22
 80013be:	f000 f9bf 	bl	8001740 <LCD_WR_REG>
  //temp = ili9320_ReadData(); //dummy
  //temp = ili9320_ReadData(); 	

  return (ili9320_BGR2RGB(ili9320_ReadData()));
 80013c2:	f000 f969 	bl	8001698 <ili9320_ReadData>
 80013c6:	4603      	mov	r3, r0
 80013c8:	4618      	mov	r0, r3
 80013ca:	f000 f921 	bl	8001610 <ili9320_BGR2RGB>
 80013ce:	4603      	mov	r3, r0
  //return (ili9320_ReadData());
}
 80013d0:	4618      	mov	r0, r3
 80013d2:	f107 0708 	add.w	r7, r7, #8
 80013d6:	46bd      	mov	sp, r7
 80013d8:	bd80      	pop	{r7, pc}
 80013da:	bf00      	nop

080013dc <ili9320_SetPoint>:
* 出口参数：无
* 说    明：
* 调用方法：ili9320_SetPoint(10,10,0x0fe0);
****************************************************************************/
void ili9320_SetPoint(u16 x,u16 y,u16 point)
{
 80013dc:	b580      	push	{r7, lr}
 80013de:	b082      	sub	sp, #8
 80013e0:	af00      	add	r7, sp, #0
 80013e2:	4613      	mov	r3, r2
 80013e4:	4602      	mov	r2, r0
 80013e6:	80fa      	strh	r2, [r7, #6]
 80013e8:	460a      	mov	r2, r1
 80013ea:	80ba      	strh	r2, [r7, #4]
 80013ec:	807b      	strh	r3, [r7, #2]
  //if ( (x>240)||(y>320) ) return;
  //LCD_WR_CMD(0,0x02,x);
  //LCD_WR_CMD(1,0x03,y);  
  
 
  LCD_WR_CMD(32, y);
 80013ee:	88bb      	ldrh	r3, [r7, #4]
 80013f0:	f04f 0020 	mov.w	r0, #32
 80013f4:	4619      	mov	r1, r3
 80013f6:	f000 f9b1 	bl	800175c <LCD_WR_CMD>
  LCD_WR_CMD(33, 319-x);
 80013fa:	88fb      	ldrh	r3, [r7, #6]
 80013fc:	f5c3 739f 	rsb	r3, r3, #318	; 0x13e
 8001400:	f103 0301 	add.w	r3, r3, #1
 8001404:	f04f 0021 	mov.w	r0, #33	; 0x21
 8001408:	4619      	mov	r1, r3
 800140a:	f000 f9a7 	bl	800175c <LCD_WR_CMD>
		//*(__IO uint16_t *) (Bank1_LCD_C)= 34;
  LCD_WR_REG(34);
 800140e:	f04f 0022 	mov.w	r0, #34	; 0x22
 8001412:	f000 f995 	bl	8001740 <LCD_WR_REG>

  //LCD_WR_CMD(0,0x02,y);
  //LCD_WR_CMD(1,0x03,319-x);  
  //LCD_WR_REG(0x0E); 
  LCD_WR_Data(point);  
 8001416:	887b      	ldrh	r3, [r7, #2]
 8001418:	4618      	mov	r0, r3
 800141a:	f000 f9c9 	bl	80017b0 <LCD_WR_Data>
}
 800141e:	f107 0708 	add.w	r7, r7, #8
 8001422:	46bd      	mov	sp, r7
 8001424:	bd80      	pop	{r7, pc}
 8001426:	bf00      	nop

08001428 <ili9320_DrawPicture>:
* 出口参数：无
* 说    明：图片取模格式为水平扫描，16位颜色模式
* 调用方法：ili9320_DrawPicture(0,0,100,100,(u16*)demo);
****************************************************************************/
void ili9320_DrawPicture(u16 StartX,u16 StartY,u16 EndX,u16 EndY,u16 *pic)
{
 8001428:	b580      	push	{r7, lr}
 800142a:	b084      	sub	sp, #16
 800142c:	af00      	add	r7, sp, #0
 800142e:	80f8      	strh	r0, [r7, #6]
 8001430:	80b9      	strh	r1, [r7, #4]
 8001432:	807a      	strh	r2, [r7, #2]
 8001434:	803b      	strh	r3, [r7, #0]
  u16  i;
  ili9320_SetWindows(StartX,StartY,EndX,EndY);
 8001436:	88f8      	ldrh	r0, [r7, #6]
 8001438:	88b9      	ldrh	r1, [r7, #4]
 800143a:	887a      	ldrh	r2, [r7, #2]
 800143c:	883b      	ldrh	r3, [r7, #0]
 800143e:	f7ff ff43 	bl	80012c8 <ili9320_SetWindows>
  ili9320_SetCursor(StartX,StartY);	    
 8001442:	88fa      	ldrh	r2, [r7, #6]
 8001444:	88bb      	ldrh	r3, [r7, #4]
 8001446:	4610      	mov	r0, r2
 8001448:	4619      	mov	r1, r3
 800144a:	f7ff ff21 	bl	8001290 <ili9320_SetCursor>
  for (i=0;i<(EndX*EndY);i++) LCD_WR_Data(*pic++);
 800144e:	f04f 0300 	mov.w	r3, #0
 8001452:	81fb      	strh	r3, [r7, #14]
 8001454:	e00c      	b.n	8001470 <ili9320_DrawPicture+0x48>
 8001456:	69bb      	ldr	r3, [r7, #24]
 8001458:	881b      	ldrh	r3, [r3, #0]
 800145a:	69ba      	ldr	r2, [r7, #24]
 800145c:	f102 0202 	add.w	r2, r2, #2
 8001460:	61ba      	str	r2, [r7, #24]
 8001462:	4618      	mov	r0, r3
 8001464:	f000 f9a4 	bl	80017b0 <LCD_WR_Data>
 8001468:	89fb      	ldrh	r3, [r7, #14]
 800146a:	f103 0301 	add.w	r3, r3, #1
 800146e:	81fb      	strh	r3, [r7, #14]
 8001470:	89fa      	ldrh	r2, [r7, #14]
 8001472:	887b      	ldrh	r3, [r7, #2]
 8001474:	8839      	ldrh	r1, [r7, #0]
 8001476:	fb01 f303 	mul.w	r3, r1, r3
 800147a:	429a      	cmp	r2, r3
 800147c:	dbeb      	blt.n	8001456 <ili9320_DrawPicture+0x2e>
}
 800147e:	f107 0710 	add.w	r7, r7, #16
 8001482:	46bd      	mov	sp, r7
 8001484:	bd80      	pop	{r7, pc}
 8001486:	bf00      	nop

08001488 <ili9320_PutChar>:
* 出口参数：无
* 说    明：显示范围限定为可显示的ascii码
* 调用方法：ili9320_PutChar(10,10,'a',0x0000,0xffff);
****************************************************************************/
void ili9320_PutChar(u16 x,u16 y,u8 c,u16 charColor,u16 bkColor)
{
 8001488:	b580      	push	{r7, lr}
 800148a:	b084      	sub	sp, #16
 800148c:	af00      	add	r7, sp, #0
 800148e:	80f8      	strh	r0, [r7, #6]
 8001490:	80b9      	strh	r1, [r7, #4]
 8001492:	70fa      	strb	r2, [r7, #3]
 8001494:	803b      	strh	r3, [r7, #0]
  u16 i=0;
 8001496:	f04f 0300 	mov.w	r3, #0
 800149a:	81fb      	strh	r3, [r7, #14]
  u16 j=0;
 800149c:	f04f 0300 	mov.w	r3, #0
 80014a0:	81bb      	strh	r3, [r7, #12]
  
  u8 tmp_char=0;
 80014a2:	f04f 0300 	mov.w	r3, #0
 80014a6:	72fb      	strb	r3, [r7, #11]

  for (i=0;i<16;i++)
 80014a8:	f04f 0300 	mov.w	r3, #0
 80014ac:	81fb      	strh	r3, [r7, #14]
 80014ae:	e043      	b.n	8001538 <ili9320_PutChar+0xb0>
  {
    tmp_char=ascii_8x16[((c-0x20)*16)+i];
 80014b0:	78fb      	ldrb	r3, [r7, #3]
 80014b2:	f1a3 0320 	sub.w	r3, r3, #32
 80014b6:	ea4f 1203 	mov.w	r2, r3, lsl #4
 80014ba:	89fb      	ldrh	r3, [r7, #14]
 80014bc:	18d2      	adds	r2, r2, r3
 80014be:	f644 5390 	movw	r3, #19856	; 0x4d90
 80014c2:	f6c0 0300 	movt	r3, #2048	; 0x800
 80014c6:	5c9b      	ldrb	r3, [r3, r2]
 80014c8:	72fb      	strb	r3, [r7, #11]
    for (j=0;j<8;j++)
 80014ca:	f04f 0300 	mov.w	r3, #0
 80014ce:	81bb      	strh	r3, [r7, #12]
 80014d0:	e02b      	b.n	800152a <ili9320_PutChar+0xa2>
    {
      if ( (tmp_char >> 7-j) & 0x01 == 0x01)
 80014d2:	7afa      	ldrb	r2, [r7, #11]
 80014d4:	89bb      	ldrh	r3, [r7, #12]
 80014d6:	f1c3 0307 	rsb	r3, r3, #7
 80014da:	fa42 f303 	asr.w	r3, r2, r3
 80014de:	f003 0301 	and.w	r3, r3, #1
 80014e2:	b2db      	uxtb	r3, r3
 80014e4:	2b00      	cmp	r3, #0
 80014e6:	d00e      	beq.n	8001506 <ili9320_PutChar+0x7e>
        {
          ili9320_SetPoint(x+j,y+i,charColor); // 字符颜色
 80014e8:	88fa      	ldrh	r2, [r7, #6]
 80014ea:	89bb      	ldrh	r3, [r7, #12]
 80014ec:	18d3      	adds	r3, r2, r3
 80014ee:	b299      	uxth	r1, r3
 80014f0:	88ba      	ldrh	r2, [r7, #4]
 80014f2:	89fb      	ldrh	r3, [r7, #14]
 80014f4:	18d3      	adds	r3, r2, r3
 80014f6:	b29a      	uxth	r2, r3
 80014f8:	883b      	ldrh	r3, [r7, #0]
 80014fa:	4608      	mov	r0, r1
 80014fc:	4611      	mov	r1, r2
 80014fe:	461a      	mov	r2, r3
 8001500:	f7ff ff6c 	bl	80013dc <ili9320_SetPoint>
 8001504:	e00d      	b.n	8001522 <ili9320_PutChar+0x9a>
        }
        else
        {
          ili9320_SetPoint(x+j,y+i,bkColor); // 背景颜色
 8001506:	88fa      	ldrh	r2, [r7, #6]
 8001508:	89bb      	ldrh	r3, [r7, #12]
 800150a:	18d3      	adds	r3, r2, r3
 800150c:	b299      	uxth	r1, r3
 800150e:	88ba      	ldrh	r2, [r7, #4]
 8001510:	89fb      	ldrh	r3, [r7, #14]
 8001512:	18d3      	adds	r3, r2, r3
 8001514:	b29a      	uxth	r2, r3
 8001516:	8b3b      	ldrh	r3, [r7, #24]
 8001518:	4608      	mov	r0, r1
 800151a:	4611      	mov	r1, r2
 800151c:	461a      	mov	r2, r3
 800151e:	f7ff ff5d 	bl	80013dc <ili9320_SetPoint>
  u8 tmp_char=0;

  for (i=0;i<16;i++)
  {
    tmp_char=ascii_8x16[((c-0x20)*16)+i];
    for (j=0;j<8;j++)
 8001522:	89bb      	ldrh	r3, [r7, #12]
 8001524:	f103 0301 	add.w	r3, r3, #1
 8001528:	81bb      	strh	r3, [r7, #12]
 800152a:	89bb      	ldrh	r3, [r7, #12]
 800152c:	2b07      	cmp	r3, #7
 800152e:	d9d0      	bls.n	80014d2 <ili9320_PutChar+0x4a>
  u16 i=0;
  u16 j=0;
  
  u8 tmp_char=0;

  for (i=0;i<16;i++)
 8001530:	89fb      	ldrh	r3, [r7, #14]
 8001532:	f103 0301 	add.w	r3, r3, #1
 8001536:	81fb      	strh	r3, [r7, #14]
 8001538:	89fb      	ldrh	r3, [r7, #14]
 800153a:	2b0f      	cmp	r3, #15
 800153c:	d9b8      	bls.n	80014b0 <ili9320_PutChar+0x28>
        {
          ili9320_SetPoint(x+j,y+i,bkColor); // 背景颜色
        }
    }
  }
}
 800153e:	f107 0710 	add.w	r7, r7, #16
 8001542:	46bd      	mov	sp, r7
 8001544:	bd80      	pop	{r7, pc}
 8001546:	bf00      	nop

08001548 <ili9320_Test>:
* 出口参数：无
* 说    明：显示彩条，测试液晶屏是否正常工作
* 调用方法：ili9320_Test();
****************************************************************************/
void ili9320_Test()
{
 8001548:	b580      	push	{r7, lr}
 800154a:	b082      	sub	sp, #8
 800154c:	af00      	add	r7, sp, #0
  u16 i,j;
  ili9320_SetCursor(0,0);
 800154e:	f04f 0000 	mov.w	r0, #0
 8001552:	f04f 0100 	mov.w	r1, #0
 8001556:	f7ff fe9b 	bl	8001290 <ili9320_SetCursor>
  
  for(i=0;i<320;i++)
 800155a:	f04f 0300 	mov.w	r3, #0
 800155e:	80fb      	strh	r3, [r7, #6]
 8001560:	e04c      	b.n	80015fc <ili9320_Test+0xb4>
    for(j=0;j<240;j++)
 8001562:	f04f 0300 	mov.w	r3, #0
 8001566:	80bb      	strh	r3, [r7, #4]
 8001568:	e041      	b.n	80015ee <ili9320_Test+0xa6>
    {
      if(i>279)LCD_WR_Data(0x0000);
 800156a:	88fa      	ldrh	r2, [r7, #6]
 800156c:	f240 1317 	movw	r3, #279	; 0x117
 8001570:	429a      	cmp	r2, r3
 8001572:	d904      	bls.n	800157e <ili9320_Test+0x36>
 8001574:	f04f 0000 	mov.w	r0, #0
 8001578:	f000 f91a 	bl	80017b0 <LCD_WR_Data>
 800157c:	e033      	b.n	80015e6 <ili9320_Test+0x9e>
      else if(i>239)LCD_WR_Data(0x001f);
 800157e:	88fb      	ldrh	r3, [r7, #6]
 8001580:	2bef      	cmp	r3, #239	; 0xef
 8001582:	d904      	bls.n	800158e <ili9320_Test+0x46>
 8001584:	f04f 001f 	mov.w	r0, #31
 8001588:	f000 f912 	bl	80017b0 <LCD_WR_Data>
 800158c:	e02b      	b.n	80015e6 <ili9320_Test+0x9e>
      else if(i>199)LCD_WR_Data(0x07e0);
 800158e:	88fb      	ldrh	r3, [r7, #6]
 8001590:	2bc7      	cmp	r3, #199	; 0xc7
 8001592:	d904      	bls.n	800159e <ili9320_Test+0x56>
 8001594:	f44f 60fc 	mov.w	r0, #2016	; 0x7e0
 8001598:	f000 f90a 	bl	80017b0 <LCD_WR_Data>
 800159c:	e023      	b.n	80015e6 <ili9320_Test+0x9e>
      else if(i>159)LCD_WR_Data(0x07ff);
 800159e:	88fb      	ldrh	r3, [r7, #6]
 80015a0:	2b9f      	cmp	r3, #159	; 0x9f
 80015a2:	d904      	bls.n	80015ae <ili9320_Test+0x66>
 80015a4:	f240 70ff 	movw	r0, #2047	; 0x7ff
 80015a8:	f000 f902 	bl	80017b0 <LCD_WR_Data>
 80015ac:	e01b      	b.n	80015e6 <ili9320_Test+0x9e>
      else if(i>119)LCD_WR_Data(0xf800);
 80015ae:	88fb      	ldrh	r3, [r7, #6]
 80015b0:	2b77      	cmp	r3, #119	; 0x77
 80015b2:	d904      	bls.n	80015be <ili9320_Test+0x76>
 80015b4:	f44f 4078 	mov.w	r0, #63488	; 0xf800
 80015b8:	f000 f8fa 	bl	80017b0 <LCD_WR_Data>
 80015bc:	e013      	b.n	80015e6 <ili9320_Test+0x9e>
      else if(i>79)LCD_WR_Data(0xf81f);
 80015be:	88fb      	ldrh	r3, [r7, #6]
 80015c0:	2b4f      	cmp	r3, #79	; 0x4f
 80015c2:	d904      	bls.n	80015ce <ili9320_Test+0x86>
 80015c4:	f64f 001f 	movw	r0, #63519	; 0xf81f
 80015c8:	f000 f8f2 	bl	80017b0 <LCD_WR_Data>
 80015cc:	e00b      	b.n	80015e6 <ili9320_Test+0x9e>
      else if(i>39)LCD_WR_Data(0xffe0);
 80015ce:	88fb      	ldrh	r3, [r7, #6]
 80015d0:	2b27      	cmp	r3, #39	; 0x27
 80015d2:	d904      	bls.n	80015de <ili9320_Test+0x96>
 80015d4:	f64f 70e0 	movw	r0, #65504	; 0xffe0
 80015d8:	f000 f8ea 	bl	80017b0 <LCD_WR_Data>
 80015dc:	e003      	b.n	80015e6 <ili9320_Test+0x9e>
      else LCD_WR_Data(0xffff);
 80015de:	f64f 70ff 	movw	r0, #65535	; 0xffff
 80015e2:	f000 f8e5 	bl	80017b0 <LCD_WR_Data>
{
  u16 i,j;
  ili9320_SetCursor(0,0);
  
  for(i=0;i<320;i++)
    for(j=0;j<240;j++)
 80015e6:	88bb      	ldrh	r3, [r7, #4]
 80015e8:	f103 0301 	add.w	r3, r3, #1
 80015ec:	80bb      	strh	r3, [r7, #4]
 80015ee:	88bb      	ldrh	r3, [r7, #4]
 80015f0:	2bef      	cmp	r3, #239	; 0xef
 80015f2:	d9ba      	bls.n	800156a <ili9320_Test+0x22>
void ili9320_Test()
{
  u16 i,j;
  ili9320_SetCursor(0,0);
  
  for(i=0;i<320;i++)
 80015f4:	88fb      	ldrh	r3, [r7, #6]
 80015f6:	f103 0301 	add.w	r3, r3, #1
 80015fa:	80fb      	strh	r3, [r7, #6]
 80015fc:	88fa      	ldrh	r2, [r7, #6]
 80015fe:	f240 133f 	movw	r3, #319	; 0x13f
 8001602:	429a      	cmp	r2, r3
 8001604:	d9ad      	bls.n	8001562 <ili9320_Test+0x1a>
      else if(i>79)LCD_WR_Data(0xf81f);
      else if(i>39)LCD_WR_Data(0xffe0);
      else LCD_WR_Data(0xffff);
    }
  
}
 8001606:	f107 0708 	add.w	r7, r7, #8
 800160a:	46bd      	mov	sp, r7
 800160c:	bd80      	pop	{r7, pc}
 800160e:	bf00      	nop

08001610 <ili9320_BGR2RGB>:
* 出口参数：RGB 颜色值
* 说    明：内部函数调用
* 调用方法：
****************************************************************************/
u16 ili9320_BGR2RGB(u16 c)
{
 8001610:	b480      	push	{r7}
 8001612:	b085      	sub	sp, #20
 8001614:	af00      	add	r7, sp, #0
 8001616:	4603      	mov	r3, r0
 8001618:	80fb      	strh	r3, [r7, #6]
  u16  r, g, b;

  b = (c>>0)  & 0x1f;
 800161a:	88fb      	ldrh	r3, [r7, #6]
 800161c:	f003 031f 	and.w	r3, r3, #31
 8001620:	81fb      	strh	r3, [r7, #14]
  g = (c>>5)  & 0x3f;
 8001622:	88fb      	ldrh	r3, [r7, #6]
 8001624:	ea4f 1353 	mov.w	r3, r3, lsr #5
 8001628:	b29b      	uxth	r3, r3
 800162a:	f003 033f 	and.w	r3, r3, #63	; 0x3f
 800162e:	81bb      	strh	r3, [r7, #12]
  r = (c>>11) & 0x1f;
 8001630:	88fb      	ldrh	r3, [r7, #6]
 8001632:	ea4f 23d3 	mov.w	r3, r3, lsr #11
 8001636:	817b      	strh	r3, [r7, #10]
  
  return( (b<<11) + (g<<5) + (r<<0) );
 8001638:	89fb      	ldrh	r3, [r7, #14]
 800163a:	ea4f 23c3 	mov.w	r3, r3, lsl #11
 800163e:	b29a      	uxth	r2, r3
 8001640:	89bb      	ldrh	r3, [r7, #12]
 8001642:	ea4f 1343 	mov.w	r3, r3, lsl #5
 8001646:	b29b      	uxth	r3, r3
 8001648:	18d3      	adds	r3, r2, r3
 800164a:	b29a      	uxth	r2, r3
 800164c:	897b      	ldrh	r3, [r7, #10]
 800164e:	18d3      	adds	r3, r2, r3
 8001650:	b29b      	uxth	r3, r3
}
 8001652:	4618      	mov	r0, r3
 8001654:	f107 0714 	add.w	r7, r7, #20
 8001658:	46bd      	mov	sp, r7
 800165a:	bc80      	pop	{r7}
 800165c:	4770      	bx	lr
 800165e:	bf00      	nop

08001660 <ili9320_WriteIndex>:
* 出口参数：无
* 说    明：调用前需先选中控制器，内部函数
* 调用方法：ili9320_WriteIndex(0x0000);
****************************************************************************/
void ili9320_WriteIndex(u16 idx)
{
 8001660:	b580      	push	{r7, lr}
 8001662:	b082      	sub	sp, #8
 8001664:	af00      	add	r7, sp, #0
 8001666:	4603      	mov	r3, r0
 8001668:	80fb      	strh	r3, [r7, #6]
  LCD_WR_REG(idx);
 800166a:	88fb      	ldrh	r3, [r7, #6]
 800166c:	b2db      	uxtb	r3, r3
 800166e:	4618      	mov	r0, r3
 8001670:	f000 f866 	bl	8001740 <LCD_WR_REG>
}
 8001674:	f107 0708 	add.w	r7, r7, #8
 8001678:	46bd      	mov	sp, r7
 800167a:	bd80      	pop	{r7, pc}

0800167c <ili9320_WriteData>:
* 出口参数：无
* 说    明：向控制器指定地址写入数据，调用前需先写寄存器地址，内部函数
* 调用方法：ili9320_WriteData(0x1030)
****************************************************************************/
void ili9320_WriteData(u16 dat)
{
 800167c:	b580      	push	{r7, lr}
 800167e:	b082      	sub	sp, #8
 8001680:	af00      	add	r7, sp, #0
 8001682:	4603      	mov	r3, r0
 8001684:	80fb      	strh	r3, [r7, #6]
  LCD_WR_Data(dat);
 8001686:	88fb      	ldrh	r3, [r7, #6]
 8001688:	4618      	mov	r0, r3
 800168a:	f000 f891 	bl	80017b0 <LCD_WR_Data>
}
 800168e:	f107 0708 	add.w	r7, r7, #8
 8001692:	46bd      	mov	sp, r7
 8001694:	bd80      	pop	{r7, pc}
 8001696:	bf00      	nop

08001698 <ili9320_ReadData>:
* 出口参数：返回读取到的数据
* 说    明：内部函数
* 调用方法：i=ili9320_ReadData();
****************************************************************************/
u16 ili9320_ReadData(void)
{
 8001698:	b580      	push	{r7, lr}
 800169a:	b082      	sub	sp, #8
 800169c:	af00      	add	r7, sp, #0
  u16 val=0;
 800169e:	f04f 0300 	mov.w	r3, #0
 80016a2:	80fb      	strh	r3, [r7, #6]
  val=LCD_RD_data();
 80016a4:	f000 f870 	bl	8001788 <LCD_RD_data>
 80016a8:	4603      	mov	r3, r0
 80016aa:	80fb      	strh	r3, [r7, #6]
  return val;
 80016ac:	88fb      	ldrh	r3, [r7, #6]
}
 80016ae:	4618      	mov	r0, r3
 80016b0:	f107 0708 	add.w	r7, r7, #8
 80016b4:	46bd      	mov	sp, r7
 80016b6:	bd80      	pop	{r7, pc}

080016b8 <ili9320_ReadRegister>:
* 出口参数：寄存器值
* 说    明：内部函数
* 调用方法：i=ili9320_ReadRegister(0x0022);
****************************************************************************/
u16 ili9320_ReadRegister(u16 index)
{
 80016b8:	b480      	push	{r7}
 80016ba:	b085      	sub	sp, #20
 80016bc:	af00      	add	r7, sp, #0
 80016be:	4603      	mov	r3, r0
 80016c0:	80fb      	strh	r3, [r7, #6]
  u16 tmp;
  tmp= *(volatile unsigned int *)(0x60000000);
 80016c2:	f04f 43c0 	mov.w	r3, #1610612736	; 0x60000000
 80016c6:	681b      	ldr	r3, [r3, #0]
 80016c8:	81fb      	strh	r3, [r7, #14]
  
  return tmp;
 80016ca:	89fb      	ldrh	r3, [r7, #14]
}
 80016cc:	4618      	mov	r0, r3
 80016ce:	f107 0714 	add.w	r7, r7, #20
 80016d2:	46bd      	mov	sp, r7
 80016d4:	bc80      	pop	{r7}
 80016d6:	4770      	bx	lr

080016d8 <ili9320_WriteRegister>:
* 出口参数：无
* 说    明：内部函数
* 调用方法：ili9320_WriteRegister(0x0000,0x0001);
****************************************************************************/
void ili9320_WriteRegister(u16 index,u16 dat)
{
 80016d8:	b580      	push	{r7, lr}
 80016da:	b082      	sub	sp, #8
 80016dc:	af00      	add	r7, sp, #0
 80016de:	4602      	mov	r2, r0
 80016e0:	460b      	mov	r3, r1
 80016e2:	80fa      	strh	r2, [r7, #6]
 80016e4:	80bb      	strh	r3, [r7, #4]
  ** nWR       --------\_______/--------\_____/-----------------------  **
  ** DB[0:15]  ---------[index]----------[data]-----------------------  **
  **                                                                    **
  ************************************************************************/
  
  LCD_WR_CMD(index,dat);
 80016e6:	88fa      	ldrh	r2, [r7, #6]
 80016e8:	88bb      	ldrh	r3, [r7, #4]
 80016ea:	4610      	mov	r0, r2
 80016ec:	4619      	mov	r1, r3
 80016ee:	f000 f835 	bl	800175c <LCD_WR_CMD>
}
 80016f2:	f107 0708 	add.w	r7, r7, #8
 80016f6:	46bd      	mov	sp, r7
 80016f8:	bd80      	pop	{r7, pc}
 80016fa:	bf00      	nop

080016fc <ili9320_Reset>:
* 出口参数：无
* 说    明：复位控制器，内部函数
* 调用方法：ili9320_Reset()
****************************************************************************/
void ili9320_Reset()
{
 80016fc:	b480      	push	{r7}
 80016fe:	af00      	add	r7, sp, #0
   **                                   **
   **  Tres: Min.1ms                    **
   ***************************************/
    
 
}
 8001700:	46bd      	mov	sp, r7
 8001702:	bc80      	pop	{r7}
 8001704:	4770      	bx	lr
 8001706:	bf00      	nop

08001708 <ili9320_BackLight>:
* 出口参数：无
* 说    明：
* 调用方法：ili9320_BackLight(1);
****************************************************************************/
void ili9320_BackLight(u8 status)
{
 8001708:	b480      	push	{r7}
 800170a:	b083      	sub	sp, #12
 800170c:	af00      	add	r7, sp, #0
 800170e:	4603      	mov	r3, r0
 8001710:	71fb      	strb	r3, [r7, #7]
  }
  else
  {
    //GPIO_ResetBits(GPIOC,LCD_BK);
  }
}
 8001712:	f107 070c 	add.w	r7, r7, #12
 8001716:	46bd      	mov	sp, r7
 8001718:	bc80      	pop	{r7}
 800171a:	4770      	bx	lr

0800171c <ili9320_Delay>:
* 出口参数：无
* 说    明：
* 调用方法：ili9320_Delay(10000);
****************************************************************************/
void ili9320_Delay(vu32 nCount)
{
 800171c:	b480      	push	{r7}
 800171e:	b083      	sub	sp, #12
 8001720:	af00      	add	r7, sp, #0
 8001722:	6078      	str	r0, [r7, #4]
  for(; nCount != 0; nCount--);
 8001724:	e003      	b.n	800172e <ili9320_Delay+0x12>
 8001726:	687b      	ldr	r3, [r7, #4]
 8001728:	f103 33ff 	add.w	r3, r3, #4294967295
 800172c:	607b      	str	r3, [r7, #4]
 800172e:	687b      	ldr	r3, [r7, #4]
 8001730:	2b00      	cmp	r3, #0
 8001732:	d1f8      	bne.n	8001726 <ili9320_Delay+0xa>
}
 8001734:	f107 070c 	add.w	r7, r7, #12
 8001738:	46bd      	mov	sp, r7
 800173a:	bc80      	pop	{r7}
 800173c:	4770      	bx	lr
 800173e:	bf00      	nop

08001740 <LCD_WR_REG>:
extern void lcd_rst(void);
extern void Delay(__IO uint32_t nCount);

//写寄存器地址函数
void LCD_WR_REG(unsigned int index)
{
 8001740:	b480      	push	{r7}
 8001742:	b083      	sub	sp, #12
 8001744:	af00      	add	r7, sp, #0
 8001746:	6078      	str	r0, [r7, #4]
	*(__IO uint16_t *)(Bank1_LCD_C)= index;
 8001748:	f04f 43c0 	mov.w	r3, #1610612736	; 0x60000000
 800174c:	687a      	ldr	r2, [r7, #4]
 800174e:	b292      	uxth	r2, r2
 8001750:	801a      	strh	r2, [r3, #0]

}
 8001752:	f107 070c 	add.w	r7, r7, #12
 8001756:	46bd      	mov	sp, r7
 8001758:	bc80      	pop	{r7}
 800175a:	4770      	bx	lr

0800175c <LCD_WR_CMD>:

//写寄存器数据函数
//输入：dbw 数据位数，1为16位，0为8位。
void LCD_WR_CMD(unsigned int index,unsigned int val)
{	
 800175c:	b480      	push	{r7}
 800175e:	b083      	sub	sp, #12
 8001760:	af00      	add	r7, sp, #0
 8001762:	6078      	str	r0, [r7, #4]
 8001764:	6039      	str	r1, [r7, #0]
	*(__IO uint16_t *)(Bank1_LCD_C)= index;	
 8001766:	f04f 43c0 	mov.w	r3, #1610612736	; 0x60000000
 800176a:	687a      	ldr	r2, [r7, #4]
 800176c:	b292      	uxth	r2, r2
 800176e:	801a      	strh	r2, [r3, #0]
	*(__IO uint16_t *)(Bank1_LCD_D)= val;
 8001770:	f04f 0300 	mov.w	r3, #0
 8001774:	f2c6 0302 	movt	r3, #24578	; 0x6002
 8001778:	683a      	ldr	r2, [r7, #0]
 800177a:	b292      	uxth	r2, r2
 800177c:	801a      	strh	r2, [r3, #0]
}
 800177e:	f107 070c 	add.w	r7, r7, #12
 8001782:	46bd      	mov	sp, r7
 8001784:	bc80      	pop	{r7}
 8001786:	4770      	bx	lr

08001788 <LCD_RD_data>:

unsigned int LCD_RD_data(void){
 8001788:	b480      	push	{r7}
 800178a:	b083      	sub	sp, #12
 800178c:	af00      	add	r7, sp, #0
	unsigned int a=0;
 800178e:	f04f 0300 	mov.w	r3, #0
 8001792:	607b      	str	r3, [r7, #4]
	a=*(__IO uint16_t *) (Bank1_LCD_D); //L
 8001794:	f04f 0300 	mov.w	r3, #0
 8001798:	f2c6 0302 	movt	r3, #24578	; 0x6002
 800179c:	881b      	ldrh	r3, [r3, #0]
 800179e:	b29b      	uxth	r3, r3
 80017a0:	607b      	str	r3, [r7, #4]

	return(a);	
 80017a2:	687b      	ldr	r3, [r7, #4]
}
 80017a4:	4618      	mov	r0, r3
 80017a6:	f107 070c 	add.w	r7, r7, #12
 80017aa:	46bd      	mov	sp, r7
 80017ac:	bc80      	pop	{r7}
 80017ae:	4770      	bx	lr

080017b0 <LCD_WR_Data>:

//写16位数据函数
void LCD_WR_Data(unsigned int val)
{   
 80017b0:	b480      	push	{r7}
 80017b2:	b083      	sub	sp, #12
 80017b4:	af00      	add	r7, sp, #0
 80017b6:	6078      	str	r0, [r7, #4]
	*(__IO uint16_t *) (Bank1_LCD_D)= val; 	
 80017b8:	f04f 0300 	mov.w	r3, #0
 80017bc:	f2c6 0302 	movt	r3, #24578	; 0x6002
 80017c0:	687a      	ldr	r2, [r7, #4]
 80017c2:	b292      	uxth	r2, r2
 80017c4:	801a      	strh	r2, [r3, #0]
}
 80017c6:	f107 070c 	add.w	r7, r7, #12
 80017ca:	46bd      	mov	sp, r7
 80017cc:	bc80      	pop	{r7}
 80017ce:	4770      	bx	lr

080017d0 <LCD_WR_Data_8>:

void LCD_WR_Data_8(unsigned int val)
{
 80017d0:	b480      	push	{r7}
 80017d2:	b083      	sub	sp, #12
 80017d4:	af00      	add	r7, sp, #0
 80017d6:	6078      	str	r0, [r7, #4]
	*(__IO uint16_t *) (Bank1_LCD_D)= val;
 80017d8:	f04f 0300 	mov.w	r3, #0
 80017dc:	f2c6 0302 	movt	r3, #24578	; 0x6002
 80017e0:	687a      	ldr	r2, [r7, #4]
 80017e2:	b292      	uxth	r2, r2
 80017e4:	801a      	strh	r2, [r3, #0]
}
 80017e6:	f107 070c 	add.w	r7, r7, #12
 80017ea:	46bd      	mov	sp, r7
 80017ec:	bc80      	pop	{r7}
 80017ee:	4770      	bx	lr

080017f0 <LCD_Init>:


//初始化函数
void LCD_Init(void)
{
 80017f0:	b580      	push	{r7, lr}
 80017f2:	af00      	add	r7, sp, #0
	lcd_rst();	 
 80017f4:	f7fe fd56 	bl	80002a4 <lcd_rst>

	LCD_WR_CMD(0x00E3, 0x3008); // Set internal timing
 80017f8:	f04f 00e3 	mov.w	r0, #227	; 0xe3
 80017fc:	f243 0108 	movw	r1, #12296	; 0x3008
 8001800:	f7ff ffac 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x00E7, 0x0012); // Set internal timing
 8001804:	f04f 00e7 	mov.w	r0, #231	; 0xe7
 8001808:	f04f 0112 	mov.w	r1, #18
 800180c:	f7ff ffa6 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x00EF, 0x1231); // Set internal timing
 8001810:	f04f 00ef 	mov.w	r0, #239	; 0xef
 8001814:	f241 2131 	movw	r1, #4657	; 0x1231
 8001818:	f7ff ffa0 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0000, 0x0001); // Start Oscillation
 800181c:	f04f 0000 	mov.w	r0, #0
 8001820:	f04f 0101 	mov.w	r1, #1
 8001824:	f7ff ff9a 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0001, 0x0100); // set SS and SM bit
 8001828:	f04f 0001 	mov.w	r0, #1
 800182c:	f44f 7180 	mov.w	r1, #256	; 0x100
 8001830:	f7ff ff94 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0002, 0x0700); // set 1 line inversion
 8001834:	f04f 0002 	mov.w	r0, #2
 8001838:	f44f 61e0 	mov.w	r1, #1792	; 0x700
 800183c:	f7ff ff8e 	bl	800175c <LCD_WR_CMD>

	LCD_WR_CMD(0x0003, 0x1018); // set GRAM write direction and BGR=0,262K colors,1 transfers/pixel.
 8001840:	f04f 0003 	mov.w	r0, #3
 8001844:	f241 0118 	movw	r1, #4120	; 0x1018
 8001848:	f7ff ff88 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0004, 0x0000); // Resize register
 800184c:	f04f 0004 	mov.w	r0, #4
 8001850:	f04f 0100 	mov.w	r1, #0
 8001854:	f7ff ff82 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0008, 0x0202); // set the back porch and front porch
 8001858:	f04f 0008 	mov.w	r0, #8
 800185c:	f240 2102 	movw	r1, #514	; 0x202
 8001860:	f7ff ff7c 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0009, 0x0000); // set non-display area refresh cycle ISC[3:0]
 8001864:	f04f 0009 	mov.w	r0, #9
 8001868:	f04f 0100 	mov.w	r1, #0
 800186c:	f7ff ff76 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x000A, 0x0000); // FMARK function
 8001870:	f04f 000a 	mov.w	r0, #10
 8001874:	f04f 0100 	mov.w	r1, #0
 8001878:	f7ff ff70 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x000C, 0x0000); // RGB interface setting
 800187c:	f04f 000c 	mov.w	r0, #12
 8001880:	f04f 0100 	mov.w	r1, #0
 8001884:	f7ff ff6a 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x000D, 0x0000); // Frame marker Position
 8001888:	f04f 000d 	mov.w	r0, #13
 800188c:	f04f 0100 	mov.w	r1, #0
 8001890:	f7ff ff64 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x000F, 0x0000); // RGB interface polarity
 8001894:	f04f 000f 	mov.w	r0, #15
 8001898:	f04f 0100 	mov.w	r1, #0
 800189c:	f7ff ff5e 	bl	800175c <LCD_WR_CMD>
	//Power On sequence 
	LCD_WR_CMD(0x0010, 0x0000); // SAP, BT[3:0], AP, DSTB, SLP, STB
 80018a0:	f04f 0010 	mov.w	r0, #16
 80018a4:	f04f 0100 	mov.w	r1, #0
 80018a8:	f7ff ff58 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0011, 0x0007); // DC1[2:0], DC0[2:0], VC[2:0]
 80018ac:	f04f 0011 	mov.w	r0, #17
 80018b0:	f04f 0107 	mov.w	r1, #7
 80018b4:	f7ff ff52 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0012, 0x0000); // VREG1OUT voltage
 80018b8:	f04f 0012 	mov.w	r0, #18
 80018bc:	f04f 0100 	mov.w	r1, #0
 80018c0:	f7ff ff4c 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0013, 0x0000); // VDV[4:0] for VCOM amplitude
 80018c4:	f04f 0013 	mov.w	r0, #19
 80018c8:	f04f 0100 	mov.w	r1, #0
 80018cc:	f7ff ff46 	bl	800175c <LCD_WR_CMD>
	Delay(200); // Dis-charge capacitor power voltage
 80018d0:	f04f 00c8 	mov.w	r0, #200	; 0xc8
 80018d4:	f7fe fd02 	bl	80002dc <Delay>
	LCD_WR_CMD(0x0010, 0x1690); // SAP, BT[3:0], AP, DSTB, SLP, STB
 80018d8:	f04f 0010 	mov.w	r0, #16
 80018dc:	f241 6190 	movw	r1, #5776	; 0x1690
 80018e0:	f7ff ff3c 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0011, 0x0227); // R11h=0x0221 at VCI=3.3V, DC1[2:0], DC0[2:0], VC[2:0]
 80018e4:	f04f 0011 	mov.w	r0, #17
 80018e8:	f240 2127 	movw	r1, #551	; 0x227
 80018ec:	f7ff ff36 	bl	800175c <LCD_WR_CMD>
	Delay(50); // Delay 50ms
 80018f0:	f04f 0032 	mov.w	r0, #50	; 0x32
 80018f4:	f7fe fcf2 	bl	80002dc <Delay>
	LCD_WR_CMD(0x0012, 0x001C); // External reference voltage= Vci;
 80018f8:	f04f 0012 	mov.w	r0, #18
 80018fc:	f04f 011c 	mov.w	r1, #28
 8001900:	f7ff ff2c 	bl	800175c <LCD_WR_CMD>
	Delay(50); // Delay 50ms
 8001904:	f04f 0032 	mov.w	r0, #50	; 0x32
 8001908:	f7fe fce8 	bl	80002dc <Delay>
	LCD_WR_CMD(0x0013, 0x1800); // R13=1200 when R12=009D;VDV[4:0] for VCOM amplitude
 800190c:	f04f 0013 	mov.w	r0, #19
 8001910:	f44f 51c0 	mov.w	r1, #6144	; 0x1800
 8001914:	f7ff ff22 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0029, 0x001C); // R29=000C when R12=009D;VCM[5:0] for VCOMH
 8001918:	f04f 0029 	mov.w	r0, #41	; 0x29
 800191c:	f04f 011c 	mov.w	r1, #28
 8001920:	f7ff ff1c 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x002B, 0x000D); // Frame Rate = 91Hz
 8001924:	f04f 002b 	mov.w	r0, #43	; 0x2b
 8001928:	f04f 010d 	mov.w	r1, #13
 800192c:	f7ff ff16 	bl	800175c <LCD_WR_CMD>
	Delay(50); // Delay 50ms
 8001930:	f04f 0032 	mov.w	r0, #50	; 0x32
 8001934:	f7fe fcd2 	bl	80002dc <Delay>
	LCD_WR_CMD(0x0020, 0x0000); // GRAM horizontal Address
 8001938:	f04f 0020 	mov.w	r0, #32
 800193c:	f04f 0100 	mov.w	r1, #0
 8001940:	f7ff ff0c 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0021, 0x0000); // GRAM Vertical Address
 8001944:	f04f 0021 	mov.w	r0, #33	; 0x21
 8001948:	f04f 0100 	mov.w	r1, #0
 800194c:	f7ff ff06 	bl	800175c <LCD_WR_CMD>
	// ----------- Adjust the Gamma Curve ----------//
	LCD_WR_CMD(0x0030, 0x0007);
 8001950:	f04f 0030 	mov.w	r0, #48	; 0x30
 8001954:	f04f 0107 	mov.w	r1, #7
 8001958:	f7ff ff00 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0031, 0x0302);
 800195c:	f04f 0031 	mov.w	r0, #49	; 0x31
 8001960:	f240 3102 	movw	r1, #770	; 0x302
 8001964:	f7ff fefa 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0032, 0x0105);
 8001968:	f04f 0032 	mov.w	r0, #50	; 0x32
 800196c:	f240 1105 	movw	r1, #261	; 0x105
 8001970:	f7ff fef4 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0035, 0x0206);
 8001974:	f04f 0035 	mov.w	r0, #53	; 0x35
 8001978:	f240 2106 	movw	r1, #518	; 0x206
 800197c:	f7ff feee 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0036, 0x0808);
 8001980:	f04f 0036 	mov.w	r0, #54	; 0x36
 8001984:	f640 0108 	movw	r1, #2056	; 0x808
 8001988:	f7ff fee8 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0037, 0x0206);
 800198c:	f04f 0037 	mov.w	r0, #55	; 0x37
 8001990:	f240 2106 	movw	r1, #518	; 0x206
 8001994:	f7ff fee2 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0038, 0x0504);
 8001998:	f04f 0038 	mov.w	r0, #56	; 0x38
 800199c:	f240 5104 	movw	r1, #1284	; 0x504
 80019a0:	f7ff fedc 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0039, 0x0007);
 80019a4:	f04f 0039 	mov.w	r0, #57	; 0x39
 80019a8:	f04f 0107 	mov.w	r1, #7
 80019ac:	f7ff fed6 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x003C, 0x0105);
 80019b0:	f04f 003c 	mov.w	r0, #60	; 0x3c
 80019b4:	f240 1105 	movw	r1, #261	; 0x105
 80019b8:	f7ff fed0 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x003D, 0x0808);
 80019bc:	f04f 003d 	mov.w	r0, #61	; 0x3d
 80019c0:	f640 0108 	movw	r1, #2056	; 0x808
 80019c4:	f7ff feca 	bl	800175c <LCD_WR_CMD>
	//------------------ Set GRAM area ---------------//
	LCD_WR_CMD(0x0050, 0x0000); // Horizontal GRAM Start Address
 80019c8:	f04f 0050 	mov.w	r0, #80	; 0x50
 80019cc:	f04f 0100 	mov.w	r1, #0
 80019d0:	f7ff fec4 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0051, 0x00EF); // Horizontal GRAM End Address
 80019d4:	f04f 0051 	mov.w	r0, #81	; 0x51
 80019d8:	f04f 01ef 	mov.w	r1, #239	; 0xef
 80019dc:	f7ff febe 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0052, 0x0000); // Vertical GRAM Start Address
 80019e0:	f04f 0052 	mov.w	r0, #82	; 0x52
 80019e4:	f04f 0100 	mov.w	r1, #0
 80019e8:	f7ff feb8 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0053, 0x013F); // Vertical GRAM Start Address
 80019ec:	f04f 0053 	mov.w	r0, #83	; 0x53
 80019f0:	f240 113f 	movw	r1, #319	; 0x13f
 80019f4:	f7ff feb2 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0060, 0xA700); // Gate Scan Line
 80019f8:	f04f 0060 	mov.w	r0, #96	; 0x60
 80019fc:	f44f 4127 	mov.w	r1, #42752	; 0xa700
 8001a00:	f7ff feac 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0061, 0x0001); // NDL,VLE, REV
 8001a04:	f04f 0061 	mov.w	r0, #97	; 0x61
 8001a08:	f04f 0101 	mov.w	r1, #1
 8001a0c:	f7ff fea6 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x006A, 0x0000); // set scrolling line
 8001a10:	f04f 006a 	mov.w	r0, #106	; 0x6a
 8001a14:	f04f 0100 	mov.w	r1, #0
 8001a18:	f7ff fea0 	bl	800175c <LCD_WR_CMD>
	//-------------- Partial Display Control ---------//
	LCD_WR_CMD(0x0080, 0x0000);
 8001a1c:	f04f 0080 	mov.w	r0, #128	; 0x80
 8001a20:	f04f 0100 	mov.w	r1, #0
 8001a24:	f7ff fe9a 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0081, 0x0000);
 8001a28:	f04f 0081 	mov.w	r0, #129	; 0x81
 8001a2c:	f04f 0100 	mov.w	r1, #0
 8001a30:	f7ff fe94 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0082, 0x0000);
 8001a34:	f04f 0082 	mov.w	r0, #130	; 0x82
 8001a38:	f04f 0100 	mov.w	r1, #0
 8001a3c:	f7ff fe8e 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0083, 0x0000);
 8001a40:	f04f 0083 	mov.w	r0, #131	; 0x83
 8001a44:	f04f 0100 	mov.w	r1, #0
 8001a48:	f7ff fe88 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0084, 0x0000);
 8001a4c:	f04f 0084 	mov.w	r0, #132	; 0x84
 8001a50:	f04f 0100 	mov.w	r1, #0
 8001a54:	f7ff fe82 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0085, 0x0000);
 8001a58:	f04f 0085 	mov.w	r0, #133	; 0x85
 8001a5c:	f04f 0100 	mov.w	r1, #0
 8001a60:	f7ff fe7c 	bl	800175c <LCD_WR_CMD>
	//-------------- Panel Control -------------------//
	LCD_WR_CMD(0x0090, 0x0010);
 8001a64:	f04f 0090 	mov.w	r0, #144	; 0x90
 8001a68:	f04f 0110 	mov.w	r1, #16
 8001a6c:	f7ff fe76 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0092, 0x0000);
 8001a70:	f04f 0092 	mov.w	r0, #146	; 0x92
 8001a74:	f04f 0100 	mov.w	r1, #0
 8001a78:	f7ff fe70 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0093, 0x0003);
 8001a7c:	f04f 0093 	mov.w	r0, #147	; 0x93
 8001a80:	f04f 0103 	mov.w	r1, #3
 8001a84:	f7ff fe6a 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0095, 0x0110);
 8001a88:	f04f 0095 	mov.w	r0, #149	; 0x95
 8001a8c:	f44f 7188 	mov.w	r1, #272	; 0x110
 8001a90:	f7ff fe64 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0097, 0x0000);
 8001a94:	f04f 0097 	mov.w	r0, #151	; 0x97
 8001a98:	f04f 0100 	mov.w	r1, #0
 8001a9c:	f7ff fe5e 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0098, 0x0000);
 8001aa0:	f04f 0098 	mov.w	r0, #152	; 0x98
 8001aa4:	f04f 0100 	mov.w	r1, #0
 8001aa8:	f7ff fe58 	bl	800175c <LCD_WR_CMD>
	LCD_WR_CMD(0x0007, 0x0133); // 262K color and display ON
 8001aac:	f04f 0007 	mov.w	r0, #7
 8001ab0:	f240 1133 	movw	r1, #307	; 0x133
 8001ab4:	f7ff fe52 	bl	800175c <LCD_WR_CMD>

    LCD_WR_CMD(32, 0);
 8001ab8:	f04f 0020 	mov.w	r0, #32
 8001abc:	f04f 0100 	mov.w	r1, #0
 8001ac0:	f7ff fe4c 	bl	800175c <LCD_WR_CMD>
    LCD_WR_CMD(33, 0x013F);
 8001ac4:	f04f 0021 	mov.w	r0, #33	; 0x21
 8001ac8:	f240 113f 	movw	r1, #319	; 0x13f
 8001acc:	f7ff fe46 	bl	800175c <LCD_WR_CMD>
	*(__IO uint16_t *) (Bank1_LCD_C)= 34;
 8001ad0:	f04f 43c0 	mov.w	r3, #1610612736	; 0x60000000
 8001ad4:	f04f 0222 	mov.w	r2, #34	; 0x22
 8001ad8:	801a      	strh	r2, [r3, #0]

	for(color1=0;color1<76800;color1++)
 8001ada:	f240 0328 	movw	r3, #40	; 0x28
 8001ade:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8001ae2:	f04f 0200 	mov.w	r2, #0
 8001ae6:	601a      	str	r2, [r3, #0]
 8001ae8:	e00f      	b.n	8001b0a <LCD_Init+0x31a>
	{
		LCD_WR_Data(0xffff);
 8001aea:	f64f 70ff 	movw	r0, #65535	; 0xffff
 8001aee:	f7ff fe5f 	bl	80017b0 <LCD_WR_Data>

    LCD_WR_CMD(32, 0);
    LCD_WR_CMD(33, 0x013F);
	*(__IO uint16_t *) (Bank1_LCD_C)= 34;

	for(color1=0;color1<76800;color1++)
 8001af2:	f240 0328 	movw	r3, #40	; 0x28
 8001af6:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8001afa:	681b      	ldr	r3, [r3, #0]
 8001afc:	f103 0201 	add.w	r2, r3, #1
 8001b00:	f240 0328 	movw	r3, #40	; 0x28
 8001b04:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8001b08:	601a      	str	r2, [r3, #0]
 8001b0a:	f240 0328 	movw	r3, #40	; 0x28
 8001b0e:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8001b12:	681a      	ldr	r2, [r3, #0]
 8001b14:	f642 33ff 	movw	r3, #11263	; 0x2bff
 8001b18:	f2c0 0301 	movt	r3, #1
 8001b1c:	429a      	cmp	r2, r3
 8001b1e:	d9e4      	bls.n	8001aea <LCD_Init+0x2fa>
	{
		LCD_WR_Data(0xffff);
	}
	color1=0;				
 8001b20:	f240 0328 	movw	r3, #40	; 0x28
 8001b24:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8001b28:	f04f 0200 	mov.w	r2, #0
 8001b2c:	601a      	str	r2, [r3, #0]

}
 8001b2e:	bd80      	pop	{r7, pc}

08001b30 <xatoi>:
typedef unsigned long   ULONG;
typedef unsigned long   DWORD;

extern void put_char(char ch);
int xatoi (char **str, long *res)
{
 8001b30:	b480      	push	{r7}
 8001b32:	b085      	sub	sp, #20
 8001b34:	af00      	add	r7, sp, #0
 8001b36:	6078      	str	r0, [r7, #4]
 8001b38:	6039      	str	r1, [r7, #0]
	DWORD val;
	BYTE c, radix, s = 0;
 8001b3a:	f04f 0300 	mov.w	r3, #0
 8001b3e:	727b      	strb	r3, [r7, #9]


	while ((c = **str) == ' ') (*str)++;
 8001b40:	e005      	b.n	8001b4e <xatoi+0x1e>
 8001b42:	687b      	ldr	r3, [r7, #4]
 8001b44:	681b      	ldr	r3, [r3, #0]
 8001b46:	f103 0201 	add.w	r2, r3, #1
 8001b4a:	687b      	ldr	r3, [r7, #4]
 8001b4c:	601a      	str	r2, [r3, #0]
 8001b4e:	687b      	ldr	r3, [r7, #4]
 8001b50:	681b      	ldr	r3, [r3, #0]
 8001b52:	781b      	ldrb	r3, [r3, #0]
 8001b54:	72fb      	strb	r3, [r7, #11]
 8001b56:	7afb      	ldrb	r3, [r7, #11]
 8001b58:	2b20      	cmp	r3, #32
 8001b5a:	d0f2      	beq.n	8001b42 <xatoi+0x12>
	if (c == '-') {
 8001b5c:	7afb      	ldrb	r3, [r7, #11]
 8001b5e:	2b2d      	cmp	r3, #45	; 0x2d
 8001b60:	d10c      	bne.n	8001b7c <xatoi+0x4c>
		s = 1;
 8001b62:	f04f 0301 	mov.w	r3, #1
 8001b66:	727b      	strb	r3, [r7, #9]
		c = *(++(*str));
 8001b68:	687b      	ldr	r3, [r7, #4]
 8001b6a:	681b      	ldr	r3, [r3, #0]
 8001b6c:	f103 0201 	add.w	r2, r3, #1
 8001b70:	687b      	ldr	r3, [r7, #4]
 8001b72:	601a      	str	r2, [r3, #0]
 8001b74:	687b      	ldr	r3, [r7, #4]
 8001b76:	681b      	ldr	r3, [r3, #0]
 8001b78:	781b      	ldrb	r3, [r3, #0]
 8001b7a:	72fb      	strb	r3, [r7, #11]
	}
	if (c == '0') {
 8001b7c:	7afb      	ldrb	r3, [r7, #11]
 8001b7e:	2b30      	cmp	r3, #48	; 0x30
 8001b80:	d142      	bne.n	8001c08 <xatoi+0xd8>
		c = *(++(*str));
 8001b82:	687b      	ldr	r3, [r7, #4]
 8001b84:	681b      	ldr	r3, [r3, #0]
 8001b86:	f103 0201 	add.w	r2, r3, #1
 8001b8a:	687b      	ldr	r3, [r7, #4]
 8001b8c:	601a      	str	r2, [r3, #0]
 8001b8e:	687b      	ldr	r3, [r7, #4]
 8001b90:	681b      	ldr	r3, [r3, #0]
 8001b92:	781b      	ldrb	r3, [r3, #0]
 8001b94:	72fb      	strb	r3, [r7, #11]
		if (c <= ' ') {
 8001b96:	7afb      	ldrb	r3, [r7, #11]
 8001b98:	2b20      	cmp	r3, #32
 8001b9a:	d806      	bhi.n	8001baa <xatoi+0x7a>
			*res = 0; return 1;
 8001b9c:	683b      	ldr	r3, [r7, #0]
 8001b9e:	f04f 0200 	mov.w	r2, #0
 8001ba2:	601a      	str	r2, [r3, #0]
 8001ba4:	f04f 0301 	mov.w	r3, #1
 8001ba8:	e07d      	b.n	8001ca6 <xatoi+0x176>
		}
		if (c == 'x') {
 8001baa:	7afb      	ldrb	r3, [r7, #11]
 8001bac:	2b78      	cmp	r3, #120	; 0x78
 8001bae:	d10d      	bne.n	8001bcc <xatoi+0x9c>
			radix = 16;
 8001bb0:	f04f 0310 	mov.w	r3, #16
 8001bb4:	72bb      	strb	r3, [r7, #10]
			c = *(++(*str));
 8001bb6:	687b      	ldr	r3, [r7, #4]
 8001bb8:	681b      	ldr	r3, [r3, #0]
 8001bba:	f103 0201 	add.w	r2, r3, #1
 8001bbe:	687b      	ldr	r3, [r7, #4]
 8001bc0:	601a      	str	r2, [r3, #0]
 8001bc2:	687b      	ldr	r3, [r7, #4]
 8001bc4:	681b      	ldr	r3, [r3, #0]
 8001bc6:	781b      	ldrb	r3, [r3, #0]
 8001bc8:	72fb      	strb	r3, [r7, #11]
				c = *(++(*str));
			} else {
				if ((c >= '0')&&(c <= '9'))
					radix = 8;
				else
					return 0;
 8001bca:	e029      	b.n	8001c20 <xatoi+0xf0>
		}
		if (c == 'x') {
			radix = 16;
			c = *(++(*str));
		} else {
			if (c == 'b') {
 8001bcc:	7afb      	ldrb	r3, [r7, #11]
 8001bce:	2b62      	cmp	r3, #98	; 0x62
 8001bd0:	d10d      	bne.n	8001bee <xatoi+0xbe>
				radix = 2;
 8001bd2:	f04f 0302 	mov.w	r3, #2
 8001bd6:	72bb      	strb	r3, [r7, #10]
				c = *(++(*str));
 8001bd8:	687b      	ldr	r3, [r7, #4]
 8001bda:	681b      	ldr	r3, [r3, #0]
 8001bdc:	f103 0201 	add.w	r2, r3, #1
 8001be0:	687b      	ldr	r3, [r7, #4]
 8001be2:	601a      	str	r2, [r3, #0]
 8001be4:	687b      	ldr	r3, [r7, #4]
 8001be6:	681b      	ldr	r3, [r3, #0]
 8001be8:	781b      	ldrb	r3, [r3, #0]
 8001bea:	72fb      	strb	r3, [r7, #11]
			} else {
				if ((c >= '0')&&(c <= '9'))
					radix = 8;
				else
					return 0;
 8001bec:	e018      	b.n	8001c20 <xatoi+0xf0>
		} else {
			if (c == 'b') {
				radix = 2;
				c = *(++(*str));
			} else {
				if ((c >= '0')&&(c <= '9'))
 8001bee:	7afb      	ldrb	r3, [r7, #11]
 8001bf0:	2b2f      	cmp	r3, #47	; 0x2f
 8001bf2:	d906      	bls.n	8001c02 <xatoi+0xd2>
 8001bf4:	7afb      	ldrb	r3, [r7, #11]
 8001bf6:	2b39      	cmp	r3, #57	; 0x39
 8001bf8:	d803      	bhi.n	8001c02 <xatoi+0xd2>
					radix = 8;
 8001bfa:	f04f 0308 	mov.w	r3, #8
 8001bfe:	72bb      	strb	r3, [r7, #10]
 8001c00:	e00e      	b.n	8001c20 <xatoi+0xf0>
				else
					return 0;
 8001c02:	f04f 0300 	mov.w	r3, #0
 8001c06:	e04e      	b.n	8001ca6 <xatoi+0x176>
			}
		}
	} else {
		if ((c < '1')||(c > '9'))
 8001c08:	7afb      	ldrb	r3, [r7, #11]
 8001c0a:	2b30      	cmp	r3, #48	; 0x30
 8001c0c:	d902      	bls.n	8001c14 <xatoi+0xe4>
 8001c0e:	7afb      	ldrb	r3, [r7, #11]
 8001c10:	2b39      	cmp	r3, #57	; 0x39
 8001c12:	d902      	bls.n	8001c1a <xatoi+0xea>
			return 0;
 8001c14:	f04f 0300 	mov.w	r3, #0
 8001c18:	e045      	b.n	8001ca6 <xatoi+0x176>
		radix = 10;
 8001c1a:	f04f 030a 	mov.w	r3, #10
 8001c1e:	72bb      	strb	r3, [r7, #10]
	}
	val = 0;
 8001c20:	f04f 0300 	mov.w	r3, #0
 8001c24:	60fb      	str	r3, [r7, #12]
	while (c > ' ') {
 8001c26:	e02f      	b.n	8001c88 <xatoi+0x158>
		if (c >= 'a') c -= 0x20;
 8001c28:	7afb      	ldrb	r3, [r7, #11]
 8001c2a:	2b60      	cmp	r3, #96	; 0x60
 8001c2c:	d903      	bls.n	8001c36 <xatoi+0x106>
 8001c2e:	7afb      	ldrb	r3, [r7, #11]
 8001c30:	f1a3 0320 	sub.w	r3, r3, #32
 8001c34:	72fb      	strb	r3, [r7, #11]
		c -= '0';
 8001c36:	7afb      	ldrb	r3, [r7, #11]
 8001c38:	f1a3 0330 	sub.w	r3, r3, #48	; 0x30
 8001c3c:	72fb      	strb	r3, [r7, #11]
		if (c >= 17) {
 8001c3e:	7afb      	ldrb	r3, [r7, #11]
 8001c40:	2b10      	cmp	r3, #16
 8001c42:	d909      	bls.n	8001c58 <xatoi+0x128>
			c -= 7;
 8001c44:	7afb      	ldrb	r3, [r7, #11]
 8001c46:	f1a3 0307 	sub.w	r3, r3, #7
 8001c4a:	72fb      	strb	r3, [r7, #11]
			if (c <= 9) return 0;
 8001c4c:	7afb      	ldrb	r3, [r7, #11]
 8001c4e:	2b09      	cmp	r3, #9
 8001c50:	d802      	bhi.n	8001c58 <xatoi+0x128>
 8001c52:	f04f 0300 	mov.w	r3, #0
 8001c56:	e026      	b.n	8001ca6 <xatoi+0x176>
		}
		if (c >= radix) return 0;
 8001c58:	7afa      	ldrb	r2, [r7, #11]
 8001c5a:	7abb      	ldrb	r3, [r7, #10]
 8001c5c:	429a      	cmp	r2, r3
 8001c5e:	d302      	bcc.n	8001c66 <xatoi+0x136>
 8001c60:	f04f 0300 	mov.w	r3, #0
 8001c64:	e01f      	b.n	8001ca6 <xatoi+0x176>
		val = val * radix + c;
 8001c66:	7abb      	ldrb	r3, [r7, #10]
 8001c68:	68fa      	ldr	r2, [r7, #12]
 8001c6a:	fb02 f203 	mul.w	r2, r2, r3
 8001c6e:	7afb      	ldrb	r3, [r7, #11]
 8001c70:	18d3      	adds	r3, r2, r3
 8001c72:	60fb      	str	r3, [r7, #12]
		c = *(++(*str));
 8001c74:	687b      	ldr	r3, [r7, #4]
 8001c76:	681b      	ldr	r3, [r3, #0]
 8001c78:	f103 0201 	add.w	r2, r3, #1
 8001c7c:	687b      	ldr	r3, [r7, #4]
 8001c7e:	601a      	str	r2, [r3, #0]
 8001c80:	687b      	ldr	r3, [r7, #4]
 8001c82:	681b      	ldr	r3, [r3, #0]
 8001c84:	781b      	ldrb	r3, [r3, #0]
 8001c86:	72fb      	strb	r3, [r7, #11]
		if ((c < '1')||(c > '9'))
			return 0;
		radix = 10;
	}
	val = 0;
	while (c > ' ') {
 8001c88:	7afb      	ldrb	r3, [r7, #11]
 8001c8a:	2b20      	cmp	r3, #32
 8001c8c:	d8cc      	bhi.n	8001c28 <xatoi+0xf8>
		}
		if (c >= radix) return 0;
		val = val * radix + c;
		c = *(++(*str));
	}
	if (s) val = -val;
 8001c8e:	7a7b      	ldrb	r3, [r7, #9]
 8001c90:	2b00      	cmp	r3, #0
 8001c92:	d003      	beq.n	8001c9c <xatoi+0x16c>
 8001c94:	68fb      	ldr	r3, [r7, #12]
 8001c96:	f1c3 0300 	rsb	r3, r3, #0
 8001c9a:	60fb      	str	r3, [r7, #12]
	*res = val;
 8001c9c:	68fa      	ldr	r2, [r7, #12]
 8001c9e:	683b      	ldr	r3, [r7, #0]
 8001ca0:	601a      	str	r2, [r3, #0]
	return 1;
 8001ca2:	f04f 0301 	mov.w	r3, #1
}
 8001ca6:	4618      	mov	r0, r3
 8001ca8:	f107 0714 	add.w	r7, r7, #20
 8001cac:	46bd      	mov	sp, r7
 8001cae:	bc80      	pop	{r7}
 8001cb0:	4770      	bx	lr
 8001cb2:	bf00      	nop

08001cb4 <put_char>:

void put_char(char ch)
{
 8001cb4:	b580      	push	{r7, lr}
 8001cb6:	b082      	sub	sp, #8
 8001cb8:	af00      	add	r7, sp, #0
 8001cba:	4603      	mov	r3, r0
 8001cbc:	71fb      	strb	r3, [r7, #7]
  	USART_SendData(USART1, (unsigned char) ch);
 8001cbe:	79fb      	ldrb	r3, [r7, #7]
 8001cc0:	b29b      	uxth	r3, r3
 8001cc2:	f44f 5060 	mov.w	r0, #14336	; 0x3800
 8001cc6:	f2c4 0001 	movt	r0, #16385	; 0x4001
 8001cca:	4619      	mov	r1, r3
 8001ccc:	f002 fd52 	bl	8004774 <USART_SendData>
  	while (!(USART1->SR & USART_FLAG_TXE));
 8001cd0:	bf00      	nop
 8001cd2:	f44f 5360 	mov.w	r3, #14336	; 0x3800
 8001cd6:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8001cda:	881b      	ldrh	r3, [r3, #0]
 8001cdc:	b29b      	uxth	r3, r3
 8001cde:	f003 0380 	and.w	r3, r3, #128	; 0x80
 8001ce2:	2b00      	cmp	r3, #0
 8001ce4:	d0f5      	beq.n	8001cd2 <put_char+0x1e>
}
 8001ce6:	f107 0708 	add.w	r7, r7, #8
 8001cea:	46bd      	mov	sp, r7
 8001cec:	bd80      	pop	{r7, pc}
 8001cee:	bf00      	nop

08001cf0 <xputc>:

void xputc (char c)
{
 8001cf0:	b580      	push	{r7, lr}
 8001cf2:	b082      	sub	sp, #8
 8001cf4:	af00      	add	r7, sp, #0
 8001cf6:	4603      	mov	r3, r0
 8001cf8:	71fb      	strb	r3, [r7, #7]
	if (c == '\n') put_char('\r');
 8001cfa:	79fb      	ldrb	r3, [r7, #7]
 8001cfc:	2b0a      	cmp	r3, #10
 8001cfe:	d103      	bne.n	8001d08 <xputc+0x18>
 8001d00:	f04f 000d 	mov.w	r0, #13
 8001d04:	f7ff ffd6 	bl	8001cb4 <put_char>
	put_char(c);
 8001d08:	79fb      	ldrb	r3, [r7, #7]
 8001d0a:	4618      	mov	r0, r3
 8001d0c:	f7ff ffd2 	bl	8001cb4 <put_char>
}
 8001d10:	f107 0708 	add.w	r7, r7, #8
 8001d14:	46bd      	mov	sp, r7
 8001d16:	bd80      	pop	{r7, pc}

08001d18 <xputs>:

void xputs (const char* str)
{
 8001d18:	b580      	push	{r7, lr}
 8001d1a:	b082      	sub	sp, #8
 8001d1c:	af00      	add	r7, sp, #0
 8001d1e:	6078      	str	r0, [r7, #4]
	while (*str)
 8001d20:	e008      	b.n	8001d34 <xputs+0x1c>
		xputc(*str++);
 8001d22:	687b      	ldr	r3, [r7, #4]
 8001d24:	781b      	ldrb	r3, [r3, #0]
 8001d26:	687a      	ldr	r2, [r7, #4]
 8001d28:	f102 0201 	add.w	r2, r2, #1
 8001d2c:	607a      	str	r2, [r7, #4]
 8001d2e:	4618      	mov	r0, r3
 8001d30:	f7ff ffde 	bl	8001cf0 <xputc>
	put_char(c);
}

void xputs (const char* str)
{
	while (*str)
 8001d34:	687b      	ldr	r3, [r7, #4]
 8001d36:	781b      	ldrb	r3, [r3, #0]
 8001d38:	2b00      	cmp	r3, #0
 8001d3a:	d1f2      	bne.n	8001d22 <xputs+0xa>
		xputc(*str++);
}
 8001d3c:	f107 0708 	add.w	r7, r7, #8
 8001d40:	46bd      	mov	sp, r7
 8001d42:	bd80      	pop	{r7, pc}

08001d44 <xitoa>:

void xitoa (long val, int radix, int len)
{
 8001d44:	b580      	push	{r7, lr}
 8001d46:	b08c      	sub	sp, #48	; 0x30
 8001d48:	af00      	add	r7, sp, #0
 8001d4a:	60f8      	str	r0, [r7, #12]
 8001d4c:	60b9      	str	r1, [r7, #8]
 8001d4e:	607a      	str	r2, [r7, #4]
	BYTE c, r, sgn = 0, pad = ' ';
 8001d50:	f04f 0300 	mov.w	r3, #0
 8001d54:	f887 302e 	strb.w	r3, [r7, #46]	; 0x2e
 8001d58:	f04f 0320 	mov.w	r3, #32
 8001d5c:	f887 302d 	strb.w	r3, [r7, #45]	; 0x2d
	BYTE s[20], i = 0;
 8001d60:	f04f 0300 	mov.w	r3, #0
 8001d64:	f887 302c 	strb.w	r3, [r7, #44]	; 0x2c
	DWORD v;


	if (radix < 0) {
 8001d68:	68bb      	ldr	r3, [r7, #8]
 8001d6a:	2b00      	cmp	r3, #0
 8001d6c:	da0e      	bge.n	8001d8c <xitoa+0x48>
		radix = -radix;
 8001d6e:	68bb      	ldr	r3, [r7, #8]
 8001d70:	f1c3 0300 	rsb	r3, r3, #0
 8001d74:	60bb      	str	r3, [r7, #8]
		if (val < 0) {
 8001d76:	68fb      	ldr	r3, [r7, #12]
 8001d78:	2b00      	cmp	r3, #0
 8001d7a:	da07      	bge.n	8001d8c <xitoa+0x48>
			val = -val;
 8001d7c:	68fb      	ldr	r3, [r7, #12]
 8001d7e:	f1c3 0300 	rsb	r3, r3, #0
 8001d82:	60fb      	str	r3, [r7, #12]
			sgn = '-';
 8001d84:	f04f 032d 	mov.w	r3, #45	; 0x2d
 8001d88:	f887 302e 	strb.w	r3, [r7, #46]	; 0x2e
		}
	}
	v = val;
 8001d8c:	68fb      	ldr	r3, [r7, #12]
 8001d8e:	62bb      	str	r3, [r7, #40]	; 0x28
	r = radix;
 8001d90:	68bb      	ldr	r3, [r7, #8]
 8001d92:	f887 3027 	strb.w	r3, [r7, #39]	; 0x27
	if (len < 0) {
 8001d96:	687b      	ldr	r3, [r7, #4]
 8001d98:	2b00      	cmp	r3, #0
 8001d9a:	da07      	bge.n	8001dac <xitoa+0x68>
		len = -len;
 8001d9c:	687b      	ldr	r3, [r7, #4]
 8001d9e:	f1c3 0300 	rsb	r3, r3, #0
 8001da2:	607b      	str	r3, [r7, #4]
		pad = '0';
 8001da4:	f04f 0330 	mov.w	r3, #48	; 0x30
 8001da8:	f887 302d 	strb.w	r3, [r7, #45]	; 0x2d
	}
	if (len > 20) return;
 8001dac:	687b      	ldr	r3, [r7, #4]
 8001dae:	2b14      	cmp	r3, #20
 8001db0:	dc70      	bgt.n	8001e94 <xitoa+0x150>
	do {
		c = (BYTE)(v % r);
 8001db2:	f897 2027 	ldrb.w	r2, [r7, #39]	; 0x27
 8001db6:	6abb      	ldr	r3, [r7, #40]	; 0x28
 8001db8:	fbb3 f1f2 	udiv	r1, r3, r2
 8001dbc:	fb02 f201 	mul.w	r2, r2, r1
 8001dc0:	1a9b      	subs	r3, r3, r2
 8001dc2:	f887 302f 	strb.w	r3, [r7, #47]	; 0x2f
		if (c >= 10) c += 7;
 8001dc6:	f897 302f 	ldrb.w	r3, [r7, #47]	; 0x2f
 8001dca:	2b09      	cmp	r3, #9
 8001dcc:	d905      	bls.n	8001dda <xitoa+0x96>
 8001dce:	f897 302f 	ldrb.w	r3, [r7, #47]	; 0x2f
 8001dd2:	f103 0307 	add.w	r3, r3, #7
 8001dd6:	f887 302f 	strb.w	r3, [r7, #47]	; 0x2f
		c += '0';
 8001dda:	f897 302f 	ldrb.w	r3, [r7, #47]	; 0x2f
 8001dde:	f103 0330 	add.w	r3, r3, #48	; 0x30
 8001de2:	f887 302f 	strb.w	r3, [r7, #47]	; 0x2f
		s[i++] = c;
 8001de6:	f897 302c 	ldrb.w	r3, [r7, #44]	; 0x2c
 8001dea:	f107 0230 	add.w	r2, r7, #48	; 0x30
 8001dee:	18d3      	adds	r3, r2, r3
 8001df0:	f897 202f 	ldrb.w	r2, [r7, #47]	; 0x2f
 8001df4:	f803 2c20 	strb.w	r2, [r3, #-32]
 8001df8:	f897 302c 	ldrb.w	r3, [r7, #44]	; 0x2c
 8001dfc:	f103 0301 	add.w	r3, r3, #1
 8001e00:	f887 302c 	strb.w	r3, [r7, #44]	; 0x2c
		v /= r;
 8001e04:	f897 3027 	ldrb.w	r3, [r7, #39]	; 0x27
 8001e08:	6aba      	ldr	r2, [r7, #40]	; 0x28
 8001e0a:	fbb2 f3f3 	udiv	r3, r2, r3
 8001e0e:	62bb      	str	r3, [r7, #40]	; 0x28
	} while (v);
 8001e10:	6abb      	ldr	r3, [r7, #40]	; 0x28
 8001e12:	2b00      	cmp	r3, #0
 8001e14:	d1cd      	bne.n	8001db2 <xitoa+0x6e>
	if (sgn) s[i++] = sgn;
 8001e16:	f897 302e 	ldrb.w	r3, [r7, #46]	; 0x2e
 8001e1a:	2b00      	cmp	r3, #0
 8001e1c:	d01f      	beq.n	8001e5e <xitoa+0x11a>
 8001e1e:	f897 302c 	ldrb.w	r3, [r7, #44]	; 0x2c
 8001e22:	f107 0230 	add.w	r2, r7, #48	; 0x30
 8001e26:	18d3      	adds	r3, r2, r3
 8001e28:	f897 202e 	ldrb.w	r2, [r7, #46]	; 0x2e
 8001e2c:	f803 2c20 	strb.w	r2, [r3, #-32]
 8001e30:	f897 302c 	ldrb.w	r3, [r7, #44]	; 0x2c
 8001e34:	f103 0301 	add.w	r3, r3, #1
 8001e38:	f887 302c 	strb.w	r3, [r7, #44]	; 0x2c
	while (i < len)
 8001e3c:	e00f      	b.n	8001e5e <xitoa+0x11a>
		s[i++] = pad;
 8001e3e:	f897 302c 	ldrb.w	r3, [r7, #44]	; 0x2c
 8001e42:	f107 0230 	add.w	r2, r7, #48	; 0x30
 8001e46:	18d3      	adds	r3, r2, r3
 8001e48:	f897 202d 	ldrb.w	r2, [r7, #45]	; 0x2d
 8001e4c:	f803 2c20 	strb.w	r2, [r3, #-32]
 8001e50:	f897 302c 	ldrb.w	r3, [r7, #44]	; 0x2c
 8001e54:	f103 0301 	add.w	r3, r3, #1
 8001e58:	f887 302c 	strb.w	r3, [r7, #44]	; 0x2c
 8001e5c:	e000      	b.n	8001e60 <xitoa+0x11c>
		c += '0';
		s[i++] = c;
		v /= r;
	} while (v);
	if (sgn) s[i++] = sgn;
	while (i < len)
 8001e5e:	bf00      	nop
 8001e60:	f897 202c 	ldrb.w	r2, [r7, #44]	; 0x2c
 8001e64:	687b      	ldr	r3, [r7, #4]
 8001e66:	429a      	cmp	r2, r3
 8001e68:	dbe9      	blt.n	8001e3e <xitoa+0xfa>
		s[i++] = pad;
	do
		xputc(s[--i]);
 8001e6a:	f897 302c 	ldrb.w	r3, [r7, #44]	; 0x2c
 8001e6e:	f103 33ff 	add.w	r3, r3, #4294967295
 8001e72:	f887 302c 	strb.w	r3, [r7, #44]	; 0x2c
 8001e76:	f897 302c 	ldrb.w	r3, [r7, #44]	; 0x2c
 8001e7a:	f107 0230 	add.w	r2, r7, #48	; 0x30
 8001e7e:	18d3      	adds	r3, r2, r3
 8001e80:	f813 3c20 	ldrb.w	r3, [r3, #-32]
 8001e84:	4618      	mov	r0, r3
 8001e86:	f7ff ff33 	bl	8001cf0 <xputc>
	while (i);
 8001e8a:	f897 302c 	ldrb.w	r3, [r7, #44]	; 0x2c
 8001e8e:	2b00      	cmp	r3, #0
 8001e90:	d1eb      	bne.n	8001e6a <xitoa+0x126>
 8001e92:	e000      	b.n	8001e96 <xitoa+0x152>
	r = radix;
	if (len < 0) {
		len = -len;
		pad = '0';
	}
	if (len > 20) return;
 8001e94:	bf00      	nop
	while (i < len)
		s[i++] = pad;
	do
		xputc(s[--i]);
	while (i);
}
 8001e96:	f107 0730 	add.w	r7, r7, #48	; 0x30
 8001e9a:	46bd      	mov	sp, r7
 8001e9c:	bd80      	pop	{r7, pc}
 8001e9e:	bf00      	nop

08001ea0 <xprintf>:

void xprintf (const char* str, ...)
{
 8001ea0:	b40f      	push	{r0, r1, r2, r3}
 8001ea2:	b580      	push	{r7, lr}
 8001ea4:	b086      	sub	sp, #24
 8001ea6:	af00      	add	r7, sp, #0
	va_list arp;
	int d, r, w, s, l;


	va_start(arp, str);
 8001ea8:	f107 0324 	add.w	r3, r7, #36	; 0x24
 8001eac:	603b      	str	r3, [r7, #0]

	while ((d = *str++) != 0) {
 8001eae:	e0b6      	b.n	800201e <xprintf+0x17e>
		if (d != '%') {
 8001eb0:	697b      	ldr	r3, [r7, #20]
 8001eb2:	2b25      	cmp	r3, #37	; 0x25
 8001eb4:	d005      	beq.n	8001ec2 <xprintf+0x22>
			xputc(d); continue;
 8001eb6:	697b      	ldr	r3, [r7, #20]
 8001eb8:	b2db      	uxtb	r3, r3
 8001eba:	4618      	mov	r0, r3
 8001ebc:	f7ff ff18 	bl	8001cf0 <xputc>
 8001ec0:	e0ad      	b.n	800201e <xprintf+0x17e>
		}
		d = *str++; w = r = s = l = 0;
 8001ec2:	6a3b      	ldr	r3, [r7, #32]
 8001ec4:	781b      	ldrb	r3, [r3, #0]
 8001ec6:	617b      	str	r3, [r7, #20]
 8001ec8:	6a3b      	ldr	r3, [r7, #32]
 8001eca:	f103 0301 	add.w	r3, r3, #1
 8001ece:	623b      	str	r3, [r7, #32]
 8001ed0:	f04f 0300 	mov.w	r3, #0
 8001ed4:	607b      	str	r3, [r7, #4]
 8001ed6:	687b      	ldr	r3, [r7, #4]
 8001ed8:	60bb      	str	r3, [r7, #8]
 8001eda:	68bb      	ldr	r3, [r7, #8]
 8001edc:	613b      	str	r3, [r7, #16]
 8001ede:	693b      	ldr	r3, [r7, #16]
 8001ee0:	60fb      	str	r3, [r7, #12]
		if (d == '0') {
 8001ee2:	697b      	ldr	r3, [r7, #20]
 8001ee4:	2b30      	cmp	r3, #48	; 0x30
 8001ee6:	d120      	bne.n	8001f2a <xprintf+0x8a>
			d = *str++; s = 1;
 8001ee8:	6a3b      	ldr	r3, [r7, #32]
 8001eea:	781b      	ldrb	r3, [r3, #0]
 8001eec:	617b      	str	r3, [r7, #20]
 8001eee:	6a3b      	ldr	r3, [r7, #32]
 8001ef0:	f103 0301 	add.w	r3, r3, #1
 8001ef4:	623b      	str	r3, [r7, #32]
 8001ef6:	f04f 0301 	mov.w	r3, #1
 8001efa:	60bb      	str	r3, [r7, #8]
		}
		while ((d >= '0')&&(d <= '9')) {
 8001efc:	e015      	b.n	8001f2a <xprintf+0x8a>
			w += w * 10 + (d - '0');
 8001efe:	68fa      	ldr	r2, [r7, #12]
 8001f00:	4613      	mov	r3, r2
 8001f02:	ea4f 0383 	mov.w	r3, r3, lsl #2
 8001f06:	189b      	adds	r3, r3, r2
 8001f08:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8001f0c:	461a      	mov	r2, r3
 8001f0e:	697b      	ldr	r3, [r7, #20]
 8001f10:	f1a3 0330 	sub.w	r3, r3, #48	; 0x30
 8001f14:	18d3      	adds	r3, r2, r3
 8001f16:	68fa      	ldr	r2, [r7, #12]
 8001f18:	18d3      	adds	r3, r2, r3
 8001f1a:	60fb      	str	r3, [r7, #12]
			d = *str++;
 8001f1c:	6a3b      	ldr	r3, [r7, #32]
 8001f1e:	781b      	ldrb	r3, [r3, #0]
 8001f20:	617b      	str	r3, [r7, #20]
 8001f22:	6a3b      	ldr	r3, [r7, #32]
 8001f24:	f103 0301 	add.w	r3, r3, #1
 8001f28:	623b      	str	r3, [r7, #32]
		}
		d = *str++; w = r = s = l = 0;
		if (d == '0') {
			d = *str++; s = 1;
		}
		while ((d >= '0')&&(d <= '9')) {
 8001f2a:	697b      	ldr	r3, [r7, #20]
 8001f2c:	2b2f      	cmp	r3, #47	; 0x2f
 8001f2e:	dd02      	ble.n	8001f36 <xprintf+0x96>
 8001f30:	697b      	ldr	r3, [r7, #20]
 8001f32:	2b39      	cmp	r3, #57	; 0x39
 8001f34:	dde3      	ble.n	8001efe <xprintf+0x5e>
			w += w * 10 + (d - '0');
			d = *str++;
		}
		if (s) w = -w;
 8001f36:	68bb      	ldr	r3, [r7, #8]
 8001f38:	2b00      	cmp	r3, #0
 8001f3a:	d003      	beq.n	8001f44 <xprintf+0xa4>
 8001f3c:	68fb      	ldr	r3, [r7, #12]
 8001f3e:	f1c3 0300 	rsb	r3, r3, #0
 8001f42:	60fb      	str	r3, [r7, #12]
		if (d == 'l') {
 8001f44:	697b      	ldr	r3, [r7, #20]
 8001f46:	2b6c      	cmp	r3, #108	; 0x6c
 8001f48:	d109      	bne.n	8001f5e <xprintf+0xbe>
			l = 1;
 8001f4a:	f04f 0301 	mov.w	r3, #1
 8001f4e:	607b      	str	r3, [r7, #4]
			d = *str++;
 8001f50:	6a3b      	ldr	r3, [r7, #32]
 8001f52:	781b      	ldrb	r3, [r3, #0]
 8001f54:	617b      	str	r3, [r7, #20]
 8001f56:	6a3b      	ldr	r3, [r7, #32]
 8001f58:	f103 0301 	add.w	r3, r3, #1
 8001f5c:	623b      	str	r3, [r7, #32]
		}
		if (!d) break;
 8001f5e:	697b      	ldr	r3, [r7, #20]
 8001f60:	2b00      	cmp	r3, #0
 8001f62:	d06d      	beq.n	8002040 <xprintf+0x1a0>
		if (d == 's') {
 8001f64:	697b      	ldr	r3, [r7, #20]
 8001f66:	2b73      	cmp	r3, #115	; 0x73
 8001f68:	d108      	bne.n	8001f7c <xprintf+0xdc>
			xputs(va_arg(arp, char*));
 8001f6a:	683b      	ldr	r3, [r7, #0]
 8001f6c:	f103 0204 	add.w	r2, r3, #4
 8001f70:	603a      	str	r2, [r7, #0]
 8001f72:	681b      	ldr	r3, [r3, #0]
 8001f74:	4618      	mov	r0, r3
 8001f76:	f7ff fecf 	bl	8001d18 <xputs>
			continue;
 8001f7a:	e050      	b.n	800201e <xprintf+0x17e>
		}
		if (d == 'c') {
 8001f7c:	697b      	ldr	r3, [r7, #20]
 8001f7e:	2b63      	cmp	r3, #99	; 0x63
 8001f80:	d109      	bne.n	8001f96 <xprintf+0xf6>
			xputc((char)va_arg(arp, int));
 8001f82:	683b      	ldr	r3, [r7, #0]
 8001f84:	f103 0204 	add.w	r2, r3, #4
 8001f88:	603a      	str	r2, [r7, #0]
 8001f8a:	681b      	ldr	r3, [r3, #0]
 8001f8c:	b2db      	uxtb	r3, r3
 8001f8e:	4618      	mov	r0, r3
 8001f90:	f7ff feae 	bl	8001cf0 <xputc>
			continue;
 8001f94:	e043      	b.n	800201e <xprintf+0x17e>
		}
		if (d == 'u') r = 10;
 8001f96:	697b      	ldr	r3, [r7, #20]
 8001f98:	2b75      	cmp	r3, #117	; 0x75
 8001f9a:	d102      	bne.n	8001fa2 <xprintf+0x102>
 8001f9c:	f04f 030a 	mov.w	r3, #10
 8001fa0:	613b      	str	r3, [r7, #16]
		if (d == 'd') r = -10;
 8001fa2:	697b      	ldr	r3, [r7, #20]
 8001fa4:	2b64      	cmp	r3, #100	; 0x64
 8001fa6:	d102      	bne.n	8001fae <xprintf+0x10e>
 8001fa8:	f06f 0309 	mvn.w	r3, #9
 8001fac:	613b      	str	r3, [r7, #16]
		if (d == 'X' || d == 'x') r = 16; // 'x' added by mthomas in increase compatibility
 8001fae:	697b      	ldr	r3, [r7, #20]
 8001fb0:	2b58      	cmp	r3, #88	; 0x58
 8001fb2:	d002      	beq.n	8001fba <xprintf+0x11a>
 8001fb4:	697b      	ldr	r3, [r7, #20]
 8001fb6:	2b78      	cmp	r3, #120	; 0x78
 8001fb8:	d102      	bne.n	8001fc0 <xprintf+0x120>
 8001fba:	f04f 0310 	mov.w	r3, #16
 8001fbe:	613b      	str	r3, [r7, #16]
		if (d == 'b') r = 2;
 8001fc0:	697b      	ldr	r3, [r7, #20]
 8001fc2:	2b62      	cmp	r3, #98	; 0x62
 8001fc4:	d102      	bne.n	8001fcc <xprintf+0x12c>
 8001fc6:	f04f 0302 	mov.w	r3, #2
 8001fca:	613b      	str	r3, [r7, #16]
		if (!r) break;
 8001fcc:	693b      	ldr	r3, [r7, #16]
 8001fce:	2b00      	cmp	r3, #0
 8001fd0:	d038      	beq.n	8002044 <xprintf+0x1a4>
		if (l) {
 8001fd2:	687b      	ldr	r3, [r7, #4]
 8001fd4:	2b00      	cmp	r3, #0
 8001fd6:	d00a      	beq.n	8001fee <xprintf+0x14e>
			xitoa((long)va_arg(arp, long), r, w);
 8001fd8:	683b      	ldr	r3, [r7, #0]
 8001fda:	f103 0204 	add.w	r2, r3, #4
 8001fde:	603a      	str	r2, [r7, #0]
 8001fe0:	681b      	ldr	r3, [r3, #0]
 8001fe2:	4618      	mov	r0, r3
 8001fe4:	6939      	ldr	r1, [r7, #16]
 8001fe6:	68fa      	ldr	r2, [r7, #12]
 8001fe8:	f7ff feac 	bl	8001d44 <xitoa>
 8001fec:	e017      	b.n	800201e <xprintf+0x17e>
		} else {
			if (r > 0)
 8001fee:	693b      	ldr	r3, [r7, #16]
 8001ff0:	2b00      	cmp	r3, #0
 8001ff2:	dd0a      	ble.n	800200a <xprintf+0x16a>
				xitoa((unsigned long)va_arg(arp, int), r, w);
 8001ff4:	683b      	ldr	r3, [r7, #0]
 8001ff6:	f103 0204 	add.w	r2, r3, #4
 8001ffa:	603a      	str	r2, [r7, #0]
 8001ffc:	681b      	ldr	r3, [r3, #0]
 8001ffe:	4618      	mov	r0, r3
 8002000:	6939      	ldr	r1, [r7, #16]
 8002002:	68fa      	ldr	r2, [r7, #12]
 8002004:	f7ff fe9e 	bl	8001d44 <xitoa>
 8002008:	e009      	b.n	800201e <xprintf+0x17e>
			else
				xitoa((long)va_arg(arp, int), r, w);
 800200a:	683b      	ldr	r3, [r7, #0]
 800200c:	f103 0204 	add.w	r2, r3, #4
 8002010:	603a      	str	r2, [r7, #0]
 8002012:	681b      	ldr	r3, [r3, #0]
 8002014:	4618      	mov	r0, r3
 8002016:	6939      	ldr	r1, [r7, #16]
 8002018:	68fa      	ldr	r2, [r7, #12]
 800201a:	f7ff fe93 	bl	8001d44 <xitoa>
	int d, r, w, s, l;


	va_start(arp, str);

	while ((d = *str++) != 0) {
 800201e:	6a3b      	ldr	r3, [r7, #32]
 8002020:	781b      	ldrb	r3, [r3, #0]
 8002022:	617b      	str	r3, [r7, #20]
 8002024:	697b      	ldr	r3, [r7, #20]
 8002026:	2b00      	cmp	r3, #0
 8002028:	bf0c      	ite	eq
 800202a:	2300      	moveq	r3, #0
 800202c:	2301      	movne	r3, #1
 800202e:	b2db      	uxtb	r3, r3
 8002030:	6a3a      	ldr	r2, [r7, #32]
 8002032:	f102 0201 	add.w	r2, r2, #1
 8002036:	623a      	str	r2, [r7, #32]
 8002038:	2b00      	cmp	r3, #0
 800203a:	f47f af39 	bne.w	8001eb0 <xprintf+0x10>
 800203e:	e002      	b.n	8002046 <xprintf+0x1a6>
		if (s) w = -w;
		if (d == 'l') {
			l = 1;
			d = *str++;
		}
		if (!d) break;
 8002040:	bf00      	nop
 8002042:	e000      	b.n	8002046 <xprintf+0x1a6>
		}
		if (d == 'u') r = 10;
		if (d == 'd') r = -10;
		if (d == 'X' || d == 'x') r = 16; // 'x' added by mthomas in increase compatibility
		if (d == 'b') r = 2;
		if (!r) break;
 8002044:	bf00      	nop
				xitoa((long)va_arg(arp, int), r, w);
		}
	}

	va_end(arp);
}
 8002046:	f107 0718 	add.w	r7, r7, #24
 800204a:	46bd      	mov	sp, r7
 800204c:	e8bd 4080 	ldmia.w	sp!, {r7, lr}
 8002050:	b004      	add	sp, #16
 8002052:	4770      	bx	lr

08002054 <put_dump>:

void put_dump (const BYTE *buff, DWORD ofs, int cnt)
{
 8002054:	b580      	push	{r7, lr}
 8002056:	b086      	sub	sp, #24
 8002058:	af00      	add	r7, sp, #0
 800205a:	60f8      	str	r0, [r7, #12]
 800205c:	60b9      	str	r1, [r7, #8]
 800205e:	607a      	str	r2, [r7, #4]
	BYTE n;


	xprintf("%08lX ", ofs);
 8002060:	f245 3090 	movw	r0, #21392	; 0x5390
 8002064:	f6c0 0000 	movt	r0, #2048	; 0x800
 8002068:	68b9      	ldr	r1, [r7, #8]
 800206a:	f7ff ff19 	bl	8001ea0 <xprintf>
	for(n = 0; n < cnt; n++)
 800206e:	f04f 0300 	mov.w	r3, #0
 8002072:	75fb      	strb	r3, [r7, #23]
 8002074:	e00e      	b.n	8002094 <put_dump+0x40>
		xprintf(" %02X", buff[n]);
 8002076:	7dfb      	ldrb	r3, [r7, #23]
 8002078:	68fa      	ldr	r2, [r7, #12]
 800207a:	18d3      	adds	r3, r2, r3
 800207c:	781b      	ldrb	r3, [r3, #0]
 800207e:	f245 3098 	movw	r0, #21400	; 0x5398
 8002082:	f6c0 0000 	movt	r0, #2048	; 0x800
 8002086:	4619      	mov	r1, r3
 8002088:	f7ff ff0a 	bl	8001ea0 <xprintf>
{
	BYTE n;


	xprintf("%08lX ", ofs);
	for(n = 0; n < cnt; n++)
 800208c:	7dfb      	ldrb	r3, [r7, #23]
 800208e:	f103 0301 	add.w	r3, r3, #1
 8002092:	75fb      	strb	r3, [r7, #23]
 8002094:	7dfa      	ldrb	r2, [r7, #23]
 8002096:	687b      	ldr	r3, [r7, #4]
 8002098:	429a      	cmp	r2, r3
 800209a:	dbec      	blt.n	8002076 <put_dump+0x22>
		xprintf(" %02X", buff[n]);
	xputc(' ');
 800209c:	f04f 0020 	mov.w	r0, #32
 80020a0:	f7ff fe26 	bl	8001cf0 <xputc>
	for(n = 0; n < cnt; n++) {
 80020a4:	f04f 0300 	mov.w	r3, #0
 80020a8:	75fb      	strb	r3, [r7, #23]
 80020aa:	e01b      	b.n	80020e4 <put_dump+0x90>
		if ((buff[n] < 0x20)||(buff[n] >= 0x7F))
 80020ac:	7dfb      	ldrb	r3, [r7, #23]
 80020ae:	68fa      	ldr	r2, [r7, #12]
 80020b0:	18d3      	adds	r3, r2, r3
 80020b2:	781b      	ldrb	r3, [r3, #0]
 80020b4:	2b1f      	cmp	r3, #31
 80020b6:	d905      	bls.n	80020c4 <put_dump+0x70>
 80020b8:	7dfb      	ldrb	r3, [r7, #23]
 80020ba:	68fa      	ldr	r2, [r7, #12]
 80020bc:	18d3      	adds	r3, r2, r3
 80020be:	781b      	ldrb	r3, [r3, #0]
 80020c0:	2b7e      	cmp	r3, #126	; 0x7e
 80020c2:	d904      	bls.n	80020ce <put_dump+0x7a>
			xputc('.');
 80020c4:	f04f 002e 	mov.w	r0, #46	; 0x2e
 80020c8:	f7ff fe12 	bl	8001cf0 <xputc>
 80020cc:	e006      	b.n	80020dc <put_dump+0x88>
		else
			xputc(buff[n]);
 80020ce:	7dfb      	ldrb	r3, [r7, #23]
 80020d0:	68fa      	ldr	r2, [r7, #12]
 80020d2:	18d3      	adds	r3, r2, r3
 80020d4:	781b      	ldrb	r3, [r3, #0]
 80020d6:	4618      	mov	r0, r3
 80020d8:	f7ff fe0a 	bl	8001cf0 <xputc>

	xprintf("%08lX ", ofs);
	for(n = 0; n < cnt; n++)
		xprintf(" %02X", buff[n]);
	xputc(' ');
	for(n = 0; n < cnt; n++) {
 80020dc:	7dfb      	ldrb	r3, [r7, #23]
 80020de:	f103 0301 	add.w	r3, r3, #1
 80020e2:	75fb      	strb	r3, [r7, #23]
 80020e4:	7dfa      	ldrb	r2, [r7, #23]
 80020e6:	687b      	ldr	r3, [r7, #4]
 80020e8:	429a      	cmp	r2, r3
 80020ea:	dbdf      	blt.n	80020ac <put_dump+0x58>
		if ((buff[n] < 0x20)||(buff[n] >= 0x7F))
			xputc('.');
		else
			xputc(buff[n]);
	}
	xputc('\n');
 80020ec:	f04f 000a 	mov.w	r0, #10
 80020f0:	f7ff fdfe 	bl	8001cf0 <xputc>
}
 80020f4:	f107 0718 	add.w	r7, r7, #24
 80020f8:	46bd      	mov	sp, r7
 80020fa:	bd80      	pop	{r7, pc}

080020fc <memcpy>:
 80020fc:	2a0f      	cmp	r2, #15
 80020fe:	b4f0      	push	{r4, r5, r6, r7}
 8002100:	bf98      	it	ls
 8002102:	4603      	movls	r3, r0
 8002104:	d931      	bls.n	800216a <memcpy+0x6e>
 8002106:	ea41 0300 	orr.w	r3, r1, r0
 800210a:	079b      	lsls	r3, r3, #30
 800210c:	d137      	bne.n	800217e <memcpy+0x82>
 800210e:	460c      	mov	r4, r1
 8002110:	4603      	mov	r3, r0
 8002112:	4615      	mov	r5, r2
 8002114:	6826      	ldr	r6, [r4, #0]
 8002116:	3d10      	subs	r5, #16
 8002118:	601e      	str	r6, [r3, #0]
 800211a:	6866      	ldr	r6, [r4, #4]
 800211c:	605e      	str	r6, [r3, #4]
 800211e:	68a6      	ldr	r6, [r4, #8]
 8002120:	609e      	str	r6, [r3, #8]
 8002122:	68e6      	ldr	r6, [r4, #12]
 8002124:	3410      	adds	r4, #16
 8002126:	60de      	str	r6, [r3, #12]
 8002128:	3310      	adds	r3, #16
 800212a:	2d0f      	cmp	r5, #15
 800212c:	d8f2      	bhi.n	8002114 <memcpy+0x18>
 800212e:	f1a2 0410 	sub.w	r4, r2, #16
 8002132:	f024 040f 	bic.w	r4, r4, #15
 8002136:	f002 020f 	and.w	r2, r2, #15
 800213a:	3410      	adds	r4, #16
 800213c:	2a03      	cmp	r2, #3
 800213e:	eb00 0304 	add.w	r3, r0, r4
 8002142:	4421      	add	r1, r4
 8002144:	d911      	bls.n	800216a <memcpy+0x6e>
 8002146:	1f0e      	subs	r6, r1, #4
 8002148:	461d      	mov	r5, r3
 800214a:	4614      	mov	r4, r2
 800214c:	f856 7f04 	ldr.w	r7, [r6, #4]!
 8002150:	3c04      	subs	r4, #4
 8002152:	2c03      	cmp	r4, #3
 8002154:	f845 7b04 	str.w	r7, [r5], #4
 8002158:	d8f8      	bhi.n	800214c <memcpy+0x50>
 800215a:	1f14      	subs	r4, r2, #4
 800215c:	f024 0403 	bic.w	r4, r4, #3
 8002160:	3404      	adds	r4, #4
 8002162:	f002 0203 	and.w	r2, r2, #3
 8002166:	1909      	adds	r1, r1, r4
 8002168:	191b      	adds	r3, r3, r4
 800216a:	b132      	cbz	r2, 800217a <memcpy+0x7e>
 800216c:	3901      	subs	r1, #1
 800216e:	f811 4f01 	ldrb.w	r4, [r1, #1]!
 8002172:	3a01      	subs	r2, #1
 8002174:	f803 4b01 	strb.w	r4, [r3], #1
 8002178:	d1f9      	bne.n	800216e <memcpy+0x72>
 800217a:	bcf0      	pop	{r4, r5, r6, r7}
 800217c:	4770      	bx	lr
 800217e:	4603      	mov	r3, r0
 8002180:	e7f4      	b.n	800216c <memcpy+0x70>
 8002182:	bf00      	nop

08002184 <SystemInit>:
  * @note   This function should be used only after reset.
  * @param  None
  * @retval None
  */
void SystemInit (void)
{
 8002184:	b580      	push	{r7, lr}
 8002186:	af00      	add	r7, sp, #0
  /* Reset the RCC clock configuration to the default reset state(for debug purpose) */
  /* Set HSION bit */
  RCC->CR |= (uint32_t)0x00000001;
 8002188:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 800218c:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002190:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8002194:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002198:	6812      	ldr	r2, [r2, #0]
 800219a:	f042 0201 	orr.w	r2, r2, #1
 800219e:	601a      	str	r2, [r3, #0]

  /* Reset SW, HPRE, PPRE1, PPRE2, ADCPRE and MCO bits */
#ifndef STM32F10X_CL
  RCC->CFGR &= (uint32_t)0xF8FF0000;
 80021a0:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80021a4:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80021a8:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80021ac:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80021b0:	6859      	ldr	r1, [r3, #4]
 80021b2:	f04f 0300 	mov.w	r3, #0
 80021b6:	f6cf 03ff 	movt	r3, #63743	; 0xf8ff
 80021ba:	400b      	ands	r3, r1
 80021bc:	6053      	str	r3, [r2, #4]
#else
  RCC->CFGR &= (uint32_t)0xF0FF0000;
#endif /* STM32F10X_CL */   
  
  /* Reset HSEON, CSSON and PLLON bits */
  RCC->CR &= (uint32_t)0xFEF6FFFF;
 80021be:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80021c2:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80021c6:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80021ca:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80021ce:	6812      	ldr	r2, [r2, #0]
 80021d0:	f022 7284 	bic.w	r2, r2, #17301504	; 0x1080000
 80021d4:	f422 3280 	bic.w	r2, r2, #65536	; 0x10000
 80021d8:	601a      	str	r2, [r3, #0]

  /* Reset HSEBYP bit */
  RCC->CR &= (uint32_t)0xFFFBFFFF;
 80021da:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80021de:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80021e2:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80021e6:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80021ea:	6812      	ldr	r2, [r2, #0]
 80021ec:	f422 2280 	bic.w	r2, r2, #262144	; 0x40000
 80021f0:	601a      	str	r2, [r3, #0]

  /* Reset PLLSRC, PLLXTPRE, PLLMUL and USBPRE/OTGFSPRE bits */
  RCC->CFGR &= (uint32_t)0xFF80FFFF;
 80021f2:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80021f6:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80021fa:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80021fe:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002202:	6852      	ldr	r2, [r2, #4]
 8002204:	f422 02fe 	bic.w	r2, r2, #8323072	; 0x7f0000
 8002208:	605a      	str	r2, [r3, #4]

  /* Reset CFGR2 register */
  RCC->CFGR2 = 0x00000000;      
#else
  /* Disable all interrupts and clear pending bits  */
  RCC->CIR = 0x009F0000;
 800220a:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 800220e:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002212:	f44f 021f 	mov.w	r2, #10420224	; 0x9f0000
 8002216:	609a      	str	r2, [r3, #8]
  #endif /* DATA_IN_ExtSRAM */
#endif 

  /* Configure the System clock frequency, HCLK, PCLK2 and PCLK1 prescalers */
  /* Configure the Flash Latency cycles and enable prefetch buffer */
  SetSysClock();
 8002218:	f000 f8ac 	bl	8002374 <SetSysClock>

#ifdef VECT_TAB_SRAM
  SCB->VTOR = SRAM_BASE | VECT_TAB_OFFSET; /* Vector Table Relocation in Internal SRAM. */
#else
  SCB->VTOR = FLASH_BASE | VECT_TAB_OFFSET; /* Vector Table Relocation in Internal FLASH. */
 800221c:	f44f 436d 	mov.w	r3, #60672	; 0xed00
 8002220:	f2ce 0300 	movt	r3, #57344	; 0xe000
 8002224:	f04f 6200 	mov.w	r2, #134217728	; 0x8000000
 8002228:	609a      	str	r2, [r3, #8]
#endif 
}
 800222a:	bd80      	pop	{r7, pc}

0800222c <SystemCoreClockUpdate>:
  *           value for HSE crystal.
  * @param  None
  * @retval None
  */
void SystemCoreClockUpdate (void)
{
 800222c:	b480      	push	{r7}
 800222e:	b085      	sub	sp, #20
 8002230:	af00      	add	r7, sp, #0
  uint32_t tmp = 0, pllmull = 0, pllsource = 0;
 8002232:	f04f 0300 	mov.w	r3, #0
 8002236:	60fb      	str	r3, [r7, #12]
 8002238:	f04f 0300 	mov.w	r3, #0
 800223c:	60bb      	str	r3, [r7, #8]
 800223e:	f04f 0300 	mov.w	r3, #0
 8002242:	607b      	str	r3, [r7, #4]
#if defined (STM32F10X_LD_VL) || defined (STM32F10X_MD_VL) || (defined STM32F10X_HD_VL)
  uint32_t prediv1factor = 0;
#endif /* STM32F10X_LD_VL or STM32F10X_MD_VL or STM32F10X_HD_VL */
    
  /* Get SYSCLK source -------------------------------------------------------*/
  tmp = RCC->CFGR & RCC_CFGR_SWS;
 8002244:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8002248:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800224c:	685b      	ldr	r3, [r3, #4]
 800224e:	f003 030c 	and.w	r3, r3, #12
 8002252:	60fb      	str	r3, [r7, #12]
  
  switch (tmp)
 8002254:	68fb      	ldr	r3, [r7, #12]
 8002256:	2b04      	cmp	r3, #4
 8002258:	d00d      	beq.n	8002276 <SystemCoreClockUpdate+0x4a>
 800225a:	2b08      	cmp	r3, #8
 800225c:	d015      	beq.n	800228a <SystemCoreClockUpdate+0x5e>
 800225e:	2b00      	cmp	r3, #0
 8002260:	d15c      	bne.n	800231c <SystemCoreClockUpdate+0xf0>
  {
    case 0x00:  /* HSI used as system clock */
      SystemCoreClock = HSI_VALUE;
 8002262:	f240 0300 	movw	r3, #0
 8002266:	f2c2 0300 	movt	r3, #8192	; 0x2000
 800226a:	f44f 5290 	mov.w	r2, #4608	; 0x1200
 800226e:	f2c0 027a 	movt	r2, #122	; 0x7a
 8002272:	601a      	str	r2, [r3, #0]
      break;
 8002274:	e05c      	b.n	8002330 <SystemCoreClockUpdate+0x104>
    case 0x04:  /* HSE used as system clock */
      SystemCoreClock = HSE_VALUE;
 8002276:	f240 0300 	movw	r3, #0
 800227a:	f2c2 0300 	movt	r3, #8192	; 0x2000
 800227e:	f44f 5290 	mov.w	r2, #4608	; 0x1200
 8002282:	f2c0 027a 	movt	r2, #122	; 0x7a
 8002286:	601a      	str	r2, [r3, #0]
      break;
 8002288:	e052      	b.n	8002330 <SystemCoreClockUpdate+0x104>
    case 0x08:  /* PLL used as system clock */

      /* Get PLL clock source and multiplication factor ----------------------*/
      pllmull = RCC->CFGR & RCC_CFGR_PLLMULL;
 800228a:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 800228e:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002292:	685b      	ldr	r3, [r3, #4]
 8002294:	f403 1370 	and.w	r3, r3, #3932160	; 0x3c0000
 8002298:	60bb      	str	r3, [r7, #8]
      pllsource = RCC->CFGR & RCC_CFGR_PLLSRC;
 800229a:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 800229e:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80022a2:	685b      	ldr	r3, [r3, #4]
 80022a4:	f403 3380 	and.w	r3, r3, #65536	; 0x10000
 80022a8:	607b      	str	r3, [r7, #4]
      
#ifndef STM32F10X_CL      
      pllmull = ( pllmull >> 18) + 2;
 80022aa:	68bb      	ldr	r3, [r7, #8]
 80022ac:	ea4f 4393 	mov.w	r3, r3, lsr #18
 80022b0:	f103 0302 	add.w	r3, r3, #2
 80022b4:	60bb      	str	r3, [r7, #8]
      
      if (pllsource == 0x00)
 80022b6:	687b      	ldr	r3, [r7, #4]
 80022b8:	2b00      	cmp	r3, #0
 80022ba:	d10c      	bne.n	80022d6 <SystemCoreClockUpdate+0xaa>
      {
        /* HSI oscillator clock divided by 2 selected as PLL clock entry */
        SystemCoreClock = (HSI_VALUE >> 1) * pllmull;
 80022bc:	68ba      	ldr	r2, [r7, #8]
 80022be:	f44f 6310 	mov.w	r3, #2304	; 0x900
 80022c2:	f2c0 033d 	movt	r3, #61	; 0x3d
 80022c6:	fb03 f202 	mul.w	r2, r3, r2
 80022ca:	f240 0300 	movw	r3, #0
 80022ce:	f2c2 0300 	movt	r3, #8192	; 0x2000
 80022d2:	601a      	str	r2, [r3, #0]
          pll2mull = ((RCC->CFGR2 & RCC_CFGR2_PLL2MUL) >> 8 ) + 2; 
          SystemCoreClock = (((HSE_VALUE / prediv2factor) * pll2mull) / prediv1factor) * pllmull;                         
        }
      }
#endif /* STM32F10X_CL */ 
      break;
 80022d4:	e02c      	b.n	8002330 <SystemCoreClockUpdate+0x104>
       prediv1factor = (RCC->CFGR2 & RCC_CFGR2_PREDIV1) + 1;
       /* HSE oscillator clock selected as PREDIV1 clock entry */
       SystemCoreClock = (HSE_VALUE / prediv1factor) * pllmull; 
 #else
        /* HSE selected as PLL clock entry */
        if ((RCC->CFGR & RCC_CFGR_PLLXTPRE) != (uint32_t)RESET)
 80022d6:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80022da:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80022de:	685b      	ldr	r3, [r3, #4]
 80022e0:	f403 3300 	and.w	r3, r3, #131072	; 0x20000
 80022e4:	2b00      	cmp	r3, #0
 80022e6:	d00c      	beq.n	8002302 <SystemCoreClockUpdate+0xd6>
        {/* HSE oscillator clock divided by 2 */
          SystemCoreClock = (HSE_VALUE >> 1) * pllmull;
 80022e8:	68ba      	ldr	r2, [r7, #8]
 80022ea:	f44f 6310 	mov.w	r3, #2304	; 0x900
 80022ee:	f2c0 033d 	movt	r3, #61	; 0x3d
 80022f2:	fb03 f202 	mul.w	r2, r3, r2
 80022f6:	f240 0300 	movw	r3, #0
 80022fa:	f2c2 0300 	movt	r3, #8192	; 0x2000
 80022fe:	601a      	str	r2, [r3, #0]
          pll2mull = ((RCC->CFGR2 & RCC_CFGR2_PLL2MUL) >> 8 ) + 2; 
          SystemCoreClock = (((HSE_VALUE / prediv2factor) * pll2mull) / prediv1factor) * pllmull;                         
        }
      }
#endif /* STM32F10X_CL */ 
      break;
 8002300:	e016      	b.n	8002330 <SystemCoreClockUpdate+0x104>
        {/* HSE oscillator clock divided by 2 */
          SystemCoreClock = (HSE_VALUE >> 1) * pllmull;
        }
        else
        {
          SystemCoreClock = HSE_VALUE * pllmull;
 8002302:	68ba      	ldr	r2, [r7, #8]
 8002304:	f44f 5390 	mov.w	r3, #4608	; 0x1200
 8002308:	f2c0 037a 	movt	r3, #122	; 0x7a
 800230c:	fb03 f202 	mul.w	r2, r3, r2
 8002310:	f240 0300 	movw	r3, #0
 8002314:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8002318:	601a      	str	r2, [r3, #0]
          pll2mull = ((RCC->CFGR2 & RCC_CFGR2_PLL2MUL) >> 8 ) + 2; 
          SystemCoreClock = (((HSE_VALUE / prediv2factor) * pll2mull) / prediv1factor) * pllmull;                         
        }
      }
#endif /* STM32F10X_CL */ 
      break;
 800231a:	e009      	b.n	8002330 <SystemCoreClockUpdate+0x104>

    default:
      SystemCoreClock = HSI_VALUE;
 800231c:	f240 0300 	movw	r3, #0
 8002320:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8002324:	f44f 5290 	mov.w	r2, #4608	; 0x1200
 8002328:	f2c0 027a 	movt	r2, #122	; 0x7a
 800232c:	601a      	str	r2, [r3, #0]
      break;
 800232e:	bf00      	nop
  }
  
  /* Compute HCLK clock frequency ----------------*/
  /* Get HCLK prescaler */
  tmp = AHBPrescTable[((RCC->CFGR & RCC_CFGR_HPRE) >> 4)];
 8002330:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8002334:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002338:	685b      	ldr	r3, [r3, #4]
 800233a:	f003 03f0 	and.w	r3, r3, #240	; 0xf0
 800233e:	ea4f 1213 	mov.w	r2, r3, lsr #4
 8002342:	f240 0304 	movw	r3, #4
 8002346:	f2c2 0300 	movt	r3, #8192	; 0x2000
 800234a:	5c9b      	ldrb	r3, [r3, r2]
 800234c:	b2db      	uxtb	r3, r3
 800234e:	60fb      	str	r3, [r7, #12]
  /* HCLK clock frequency */
  SystemCoreClock >>= tmp;  
 8002350:	f240 0300 	movw	r3, #0
 8002354:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8002358:	681a      	ldr	r2, [r3, #0]
 800235a:	68fb      	ldr	r3, [r7, #12]
 800235c:	fa22 f203 	lsr.w	r2, r2, r3
 8002360:	f240 0300 	movw	r3, #0
 8002364:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8002368:	601a      	str	r2, [r3, #0]
}
 800236a:	f107 0714 	add.w	r7, r7, #20
 800236e:	46bd      	mov	sp, r7
 8002370:	bc80      	pop	{r7}
 8002372:	4770      	bx	lr

08002374 <SetSysClock>:
  * @brief  Configures the System clock frequency, HCLK, PCLK2 and PCLK1 prescalers.
  * @param  None
  * @retval None
  */
static void SetSysClock(void)
{
 8002374:	b580      	push	{r7, lr}
 8002376:	af00      	add	r7, sp, #0
#elif defined SYSCLK_FREQ_48MHz
  SetSysClockTo48();
#elif defined SYSCLK_FREQ_56MHz
  SetSysClockTo56();  
#elif defined SYSCLK_FREQ_72MHz
  SetSysClockTo72();
 8002378:	f000 f802 	bl	8002380 <SetSysClockTo72>
#endif
 
 /* If none of the define above is enabled, the HSI is used as System clock
    source (default after reset) */ 
}
 800237c:	bd80      	pop	{r7, pc}
 800237e:	bf00      	nop

08002380 <SetSysClockTo72>:
  * @note   This function should be used only after reset.
  * @param  None
  * @retval None
  */
static void SetSysClockTo72(void)
{
 8002380:	b480      	push	{r7}
 8002382:	b083      	sub	sp, #12
 8002384:	af00      	add	r7, sp, #0
  __IO uint32_t StartUpCounter = 0, HSEStatus = 0;
 8002386:	f04f 0300 	mov.w	r3, #0
 800238a:	607b      	str	r3, [r7, #4]
 800238c:	f04f 0300 	mov.w	r3, #0
 8002390:	603b      	str	r3, [r7, #0]
  
  /* SYSCLK, HCLK, PCLK2 and PCLK1 configuration ---------------------------*/    
  /* Enable HSE */    
  RCC->CR |= ((uint32_t)RCC_CR_HSEON);
 8002392:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8002396:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800239a:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 800239e:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80023a2:	6812      	ldr	r2, [r2, #0]
 80023a4:	f442 3280 	orr.w	r2, r2, #65536	; 0x10000
 80023a8:	601a      	str	r2, [r3, #0]
 
  /* Wait till HSE is ready and if Time out is reached exit */
  do
  {
    HSEStatus = RCC->CR & RCC_CR_HSERDY;
 80023aa:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80023ae:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80023b2:	681b      	ldr	r3, [r3, #0]
 80023b4:	f403 3300 	and.w	r3, r3, #131072	; 0x20000
 80023b8:	603b      	str	r3, [r7, #0]
    StartUpCounter++;  
 80023ba:	687b      	ldr	r3, [r7, #4]
 80023bc:	f103 0301 	add.w	r3, r3, #1
 80023c0:	607b      	str	r3, [r7, #4]
  } while((HSEStatus == 0) && (StartUpCounter != HSE_STARTUP_TIMEOUT));
 80023c2:	683b      	ldr	r3, [r7, #0]
 80023c4:	2b00      	cmp	r3, #0
 80023c6:	d103      	bne.n	80023d0 <SetSysClockTo72+0x50>
 80023c8:	687b      	ldr	r3, [r7, #4]
 80023ca:	f5b3 6fa0 	cmp.w	r3, #1280	; 0x500
 80023ce:	d1ec      	bne.n	80023aa <SetSysClockTo72+0x2a>

  if ((RCC->CR & RCC_CR_HSERDY) != RESET)
 80023d0:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80023d4:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80023d8:	681b      	ldr	r3, [r3, #0]
 80023da:	f403 3300 	and.w	r3, r3, #131072	; 0x20000
 80023de:	2b00      	cmp	r3, #0
 80023e0:	d003      	beq.n	80023ea <SetSysClockTo72+0x6a>
  {
    HSEStatus = (uint32_t)0x01;
 80023e2:	f04f 0301 	mov.w	r3, #1
 80023e6:	603b      	str	r3, [r7, #0]
 80023e8:	e002      	b.n	80023f0 <SetSysClockTo72+0x70>
  }
  else
  {
    HSEStatus = (uint32_t)0x00;
 80023ea:	f04f 0300 	mov.w	r3, #0
 80023ee:	603b      	str	r3, [r7, #0]
  }  

  if (HSEStatus == (uint32_t)0x01)
 80023f0:	683b      	ldr	r3, [r7, #0]
 80023f2:	2b01      	cmp	r3, #1
 80023f4:	f040 8094 	bne.w	8002520 <SetSysClockTo72+0x1a0>
  {
    /* Enable Prefetch Buffer */
    FLASH->ACR |= FLASH_ACR_PRFTBE;
 80023f8:	f44f 5300 	mov.w	r3, #8192	; 0x2000
 80023fc:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002400:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 8002404:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002408:	6812      	ldr	r2, [r2, #0]
 800240a:	f042 0210 	orr.w	r2, r2, #16
 800240e:	601a      	str	r2, [r3, #0]

    /* Flash 2 wait state */
    FLASH->ACR &= (uint32_t)((uint32_t)~FLASH_ACR_LATENCY);
 8002410:	f44f 5300 	mov.w	r3, #8192	; 0x2000
 8002414:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002418:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 800241c:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002420:	6812      	ldr	r2, [r2, #0]
 8002422:	f022 0203 	bic.w	r2, r2, #3
 8002426:	601a      	str	r2, [r3, #0]
    FLASH->ACR |= (uint32_t)FLASH_ACR_LATENCY_2;    
 8002428:	f44f 5300 	mov.w	r3, #8192	; 0x2000
 800242c:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002430:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 8002434:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002438:	6812      	ldr	r2, [r2, #0]
 800243a:	f042 0202 	orr.w	r2, r2, #2
 800243e:	601a      	str	r2, [r3, #0]

 
    /* HCLK = SYSCLK */
    RCC->CFGR |= (uint32_t)RCC_CFGR_HPRE_DIV1;
 8002440:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8002444:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002448:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 800244c:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002450:	6852      	ldr	r2, [r2, #4]
 8002452:	605a      	str	r2, [r3, #4]
      
    /* PCLK2 = HCLK */
    RCC->CFGR |= (uint32_t)RCC_CFGR_PPRE2_DIV1;
 8002454:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8002458:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800245c:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8002460:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002464:	6852      	ldr	r2, [r2, #4]
 8002466:	605a      	str	r2, [r3, #4]
    
    /* PCLK1 = HCLK */
    RCC->CFGR |= (uint32_t)RCC_CFGR_PPRE1_DIV2;
 8002468:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 800246c:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002470:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8002474:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002478:	6852      	ldr	r2, [r2, #4]
 800247a:	f442 6280 	orr.w	r2, r2, #1024	; 0x400
 800247e:	605a      	str	r2, [r3, #4]
    RCC->CFGR &= (uint32_t)~(RCC_CFGR_PLLXTPRE | RCC_CFGR_PLLSRC | RCC_CFGR_PLLMULL);
    RCC->CFGR |= (uint32_t)(RCC_CFGR_PLLXTPRE_PREDIV1 | RCC_CFGR_PLLSRC_PREDIV1 | 
                            RCC_CFGR_PLLMULL9); 
#else    
    /*  PLL configuration: PLLCLK = HSE * 9 = 72 MHz */
    RCC->CFGR &= (uint32_t)((uint32_t)~(RCC_CFGR_PLLSRC | RCC_CFGR_PLLXTPRE |
 8002480:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8002484:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002488:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 800248c:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002490:	6852      	ldr	r2, [r2, #4]
 8002492:	f422 127c 	bic.w	r2, r2, #4128768	; 0x3f0000
 8002496:	605a      	str	r2, [r3, #4]
                                        RCC_CFGR_PLLMULL));
    RCC->CFGR |= (uint32_t)(RCC_CFGR_PLLSRC_HSE | RCC_CFGR_PLLMULL9);
 8002498:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 800249c:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80024a0:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80024a4:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80024a8:	6852      	ldr	r2, [r2, #4]
 80024aa:	f442 12e8 	orr.w	r2, r2, #1900544	; 0x1d0000
 80024ae:	605a      	str	r2, [r3, #4]
#endif /* STM32F10X_CL */

    /* Enable PLL */
    RCC->CR |= RCC_CR_PLLON;
 80024b0:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80024b4:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80024b8:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80024bc:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80024c0:	6812      	ldr	r2, [r2, #0]
 80024c2:	f042 7280 	orr.w	r2, r2, #16777216	; 0x1000000
 80024c6:	601a      	str	r2, [r3, #0]

    /* Wait till PLL is ready */
    while((RCC->CR & RCC_CR_PLLRDY) == 0)
 80024c8:	bf00      	nop
 80024ca:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80024ce:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80024d2:	681b      	ldr	r3, [r3, #0]
 80024d4:	f003 7300 	and.w	r3, r3, #33554432	; 0x2000000
 80024d8:	2b00      	cmp	r3, #0
 80024da:	d0f6      	beq.n	80024ca <SetSysClockTo72+0x14a>
    {
    }
    
    /* Select PLL as system clock source */
    RCC->CFGR &= (uint32_t)((uint32_t)~(RCC_CFGR_SW));
 80024dc:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80024e0:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80024e4:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80024e8:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80024ec:	6852      	ldr	r2, [r2, #4]
 80024ee:	f022 0203 	bic.w	r2, r2, #3
 80024f2:	605a      	str	r2, [r3, #4]
    RCC->CFGR |= (uint32_t)RCC_CFGR_SW_PLL;    
 80024f4:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80024f8:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80024fc:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8002500:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8002504:	6852      	ldr	r2, [r2, #4]
 8002506:	f042 0202 	orr.w	r2, r2, #2
 800250a:	605a      	str	r2, [r3, #4]

    /* Wait till PLL is used as system clock source */
    while ((RCC->CFGR & (uint32_t)RCC_CFGR_SWS) != (uint32_t)0x08)
 800250c:	bf00      	nop
 800250e:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8002512:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8002516:	685b      	ldr	r3, [r3, #4]
 8002518:	f003 030c 	and.w	r3, r3, #12
 800251c:	2b08      	cmp	r3, #8
 800251e:	d1f6      	bne.n	800250e <SetSysClockTo72+0x18e>
  }
  else
  { /* If HSE fails to start-up, the application will have wrong clock 
         configuration. User can add here some code to deal with this error */
  }
}
 8002520:	f107 070c 	add.w	r7, r7, #12
 8002524:	46bd      	mov	sp, r7
 8002526:	bc80      	pop	{r7}
 8002528:	4770      	bx	lr
 800252a:	bf00      	nop

0800252c <FSMC_NORSRAMDeInit>:
  *     @arg FSMC_Bank1_NORSRAM3: FSMC Bank1 NOR/SRAM3 
  *     @arg FSMC_Bank1_NORSRAM4: FSMC Bank1 NOR/SRAM4 
  * @retval None
  */
void FSMC_NORSRAMDeInit(uint32_t FSMC_Bank)
{
 800252c:	b480      	push	{r7}
 800252e:	b083      	sub	sp, #12
 8002530:	af00      	add	r7, sp, #0
 8002532:	6078      	str	r0, [r7, #4]
  /* Check the parameter */
  assert_param(IS_FSMC_NORSRAM_BANK(FSMC_Bank));
  
  /* FSMC_Bank1_NORSRAM1 */
  if(FSMC_Bank == FSMC_Bank1_NORSRAM1)
 8002534:	687b      	ldr	r3, [r7, #4]
 8002536:	2b00      	cmp	r3, #0
 8002538:	d107      	bne.n	800254a <FSMC_NORSRAMDeInit+0x1e>
  {
    FSMC_Bank1->BTCR[FSMC_Bank] = 0x000030DB;    
 800253a:	f04f 4320 	mov.w	r3, #2684354560	; 0xa0000000
 800253e:	687a      	ldr	r2, [r7, #4]
 8002540:	f243 01db 	movw	r1, #12507	; 0x30db
 8002544:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
 8002548:	e006      	b.n	8002558 <FSMC_NORSRAMDeInit+0x2c>
  }
  /* FSMC_Bank1_NORSRAM2,  FSMC_Bank1_NORSRAM3 or FSMC_Bank1_NORSRAM4 */
  else
  {   
    FSMC_Bank1->BTCR[FSMC_Bank] = 0x000030D2; 
 800254a:	f04f 4320 	mov.w	r3, #2684354560	; 0xa0000000
 800254e:	687a      	ldr	r2, [r7, #4]
 8002550:	f243 01d2 	movw	r1, #12498	; 0x30d2
 8002554:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
  }
  FSMC_Bank1->BTCR[FSMC_Bank + 1] = 0x0FFFFFFF;
 8002558:	f04f 4320 	mov.w	r3, #2684354560	; 0xa0000000
 800255c:	687a      	ldr	r2, [r7, #4]
 800255e:	f102 0201 	add.w	r2, r2, #1
 8002562:	f06f 4170 	mvn.w	r1, #4026531840	; 0xf0000000
 8002566:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
  FSMC_Bank1E->BWTR[FSMC_Bank] = 0x0FFFFFFF;  
 800256a:	f44f 7382 	mov.w	r3, #260	; 0x104
 800256e:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002572:	687a      	ldr	r2, [r7, #4]
 8002574:	f06f 4170 	mvn.w	r1, #4026531840	; 0xf0000000
 8002578:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
}
 800257c:	f107 070c 	add.w	r7, r7, #12
 8002580:	46bd      	mov	sp, r7
 8002582:	bc80      	pop	{r7}
 8002584:	4770      	bx	lr
 8002586:	bf00      	nop

08002588 <FSMC_NANDDeInit>:
  *     @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
  *     @arg FSMC_Bank3_NAND: FSMC Bank3 NAND 
  * @retval None
  */
void FSMC_NANDDeInit(uint32_t FSMC_Bank)
{
 8002588:	b480      	push	{r7}
 800258a:	b083      	sub	sp, #12
 800258c:	af00      	add	r7, sp, #0
 800258e:	6078      	str	r0, [r7, #4]
  /* Check the parameter */
  assert_param(IS_FSMC_NAND_BANK(FSMC_Bank));
  
  if(FSMC_Bank == FSMC_Bank2_NAND)
 8002590:	687b      	ldr	r3, [r7, #4]
 8002592:	2b10      	cmp	r3, #16
 8002594:	d11c      	bne.n	80025d0 <FSMC_NANDDeInit+0x48>
  {
    /* Set the FSMC_Bank2 registers to their reset values */
    FSMC_Bank2->PCR2 = 0x00000018;
 8002596:	f04f 0360 	mov.w	r3, #96	; 0x60
 800259a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 800259e:	f04f 0218 	mov.w	r2, #24
 80025a2:	601a      	str	r2, [r3, #0]
    FSMC_Bank2->SR2 = 0x00000040;
 80025a4:	f04f 0360 	mov.w	r3, #96	; 0x60
 80025a8:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80025ac:	f04f 0240 	mov.w	r2, #64	; 0x40
 80025b0:	605a      	str	r2, [r3, #4]
    FSMC_Bank2->PMEM2 = 0xFCFCFCFC;
 80025b2:	f04f 0360 	mov.w	r3, #96	; 0x60
 80025b6:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80025ba:	f04f 32fc 	mov.w	r2, #4244438268	; 0xfcfcfcfc
 80025be:	609a      	str	r2, [r3, #8]
    FSMC_Bank2->PATT2 = 0xFCFCFCFC;  
 80025c0:	f04f 0360 	mov.w	r3, #96	; 0x60
 80025c4:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80025c8:	f04f 32fc 	mov.w	r2, #4244438268	; 0xfcfcfcfc
 80025cc:	60da      	str	r2, [r3, #12]
 80025ce:	e01b      	b.n	8002608 <FSMC_NANDDeInit+0x80>
  }
  /* FSMC_Bank3_NAND */  
  else
  {
    /* Set the FSMC_Bank3 registers to their reset values */
    FSMC_Bank3->PCR3 = 0x00000018;
 80025d0:	f04f 0380 	mov.w	r3, #128	; 0x80
 80025d4:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80025d8:	f04f 0218 	mov.w	r2, #24
 80025dc:	601a      	str	r2, [r3, #0]
    FSMC_Bank3->SR3 = 0x00000040;
 80025de:	f04f 0380 	mov.w	r3, #128	; 0x80
 80025e2:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80025e6:	f04f 0240 	mov.w	r2, #64	; 0x40
 80025ea:	605a      	str	r2, [r3, #4]
    FSMC_Bank3->PMEM3 = 0xFCFCFCFC;
 80025ec:	f04f 0380 	mov.w	r3, #128	; 0x80
 80025f0:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80025f4:	f04f 32fc 	mov.w	r2, #4244438268	; 0xfcfcfcfc
 80025f8:	609a      	str	r2, [r3, #8]
    FSMC_Bank3->PATT3 = 0xFCFCFCFC; 
 80025fa:	f04f 0380 	mov.w	r3, #128	; 0x80
 80025fe:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002602:	f04f 32fc 	mov.w	r2, #4244438268	; 0xfcfcfcfc
 8002606:	60da      	str	r2, [r3, #12]
  }  
}
 8002608:	f107 070c 	add.w	r7, r7, #12
 800260c:	46bd      	mov	sp, r7
 800260e:	bc80      	pop	{r7}
 8002610:	4770      	bx	lr
 8002612:	bf00      	nop

08002614 <FSMC_PCCARDDeInit>:
  * @brief  Deinitializes the FSMC PCCARD Bank registers to their default reset values.
  * @param  None                       
  * @retval None
  */
void FSMC_PCCARDDeInit(void)
{
 8002614:	b480      	push	{r7}
 8002616:	af00      	add	r7, sp, #0
  /* Set the FSMC_Bank4 registers to their reset values */
  FSMC_Bank4->PCR4 = 0x00000018; 
 8002618:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 800261c:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002620:	f04f 0218 	mov.w	r2, #24
 8002624:	601a      	str	r2, [r3, #0]
  FSMC_Bank4->SR4 = 0x00000000;	
 8002626:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 800262a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 800262e:	f04f 0200 	mov.w	r2, #0
 8002632:	605a      	str	r2, [r3, #4]
  FSMC_Bank4->PMEM4 = 0xFCFCFCFC;
 8002634:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 8002638:	f2ca 0300 	movt	r3, #40960	; 0xa000
 800263c:	f04f 32fc 	mov.w	r2, #4244438268	; 0xfcfcfcfc
 8002640:	609a      	str	r2, [r3, #8]
  FSMC_Bank4->PATT4 = 0xFCFCFCFC;
 8002642:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 8002646:	f2ca 0300 	movt	r3, #40960	; 0xa000
 800264a:	f04f 32fc 	mov.w	r2, #4244438268	; 0xfcfcfcfc
 800264e:	60da      	str	r2, [r3, #12]
  FSMC_Bank4->PIO4 = 0xFCFCFCFC;
 8002650:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 8002654:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002658:	f04f 32fc 	mov.w	r2, #4244438268	; 0xfcfcfcfc
 800265c:	611a      	str	r2, [r3, #16]
}
 800265e:	46bd      	mov	sp, r7
 8002660:	bc80      	pop	{r7}
 8002662:	4770      	bx	lr

08002664 <FSMC_NORSRAMInit>:
  *         structure that contains the configuration information for 
  *        the FSMC NOR/SRAM specified Banks.                       
  * @retval None
  */
void FSMC_NORSRAMInit(FSMC_NORSRAMInitTypeDef* FSMC_NORSRAMInitStruct)
{ 
 8002664:	b480      	push	{r7}
 8002666:	b083      	sub	sp, #12
 8002668:	af00      	add	r7, sp, #0
 800266a:	6078      	str	r0, [r7, #4]
  assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision));
  assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency));
  assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode)); 
  
  /* Bank1 NOR/SRAM control register configuration */ 
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
 800266c:	f04f 4320 	mov.w	r3, #2684354560	; 0xa0000000
 8002670:	687a      	ldr	r2, [r7, #4]
 8002672:	6812      	ldr	r2, [r2, #0]
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_DataAddressMux |
 8002674:	6879      	ldr	r1, [r7, #4]
 8002676:	6848      	ldr	r0, [r1, #4]
            FSMC_NORSRAMInitStruct->FSMC_MemoryType |
 8002678:	6879      	ldr	r1, [r7, #4]
 800267a:	6889      	ldr	r1, [r1, #8]
  assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency));
  assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode)); 
  
  /* Bank1 NOR/SRAM control register configuration */ 
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_DataAddressMux |
 800267c:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_MemoryType |
            FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
 800267e:	6879      	ldr	r1, [r7, #4]
 8002680:	68c9      	ldr	r1, [r1, #12]
  assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode)); 
  
  /* Bank1 NOR/SRAM control register configuration */ 
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_DataAddressMux |
            FSMC_NORSRAMInitStruct->FSMC_MemoryType |
 8002682:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
            FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
 8002684:	6879      	ldr	r1, [r7, #4]
 8002686:	6909      	ldr	r1, [r1, #16]
  
  /* Bank1 NOR/SRAM control register configuration */ 
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_DataAddressMux |
            FSMC_NORSRAMInitStruct->FSMC_MemoryType |
            FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
 8002688:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
            FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait |
 800268a:	6879      	ldr	r1, [r7, #4]
 800268c:	6949      	ldr	r1, [r1, #20]
  /* Bank1 NOR/SRAM control register configuration */ 
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_DataAddressMux |
            FSMC_NORSRAMInitStruct->FSMC_MemoryType |
            FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
            FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
 800268e:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
 8002690:	6879      	ldr	r1, [r7, #4]
 8002692:	6989      	ldr	r1, [r1, #24]
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_DataAddressMux |
            FSMC_NORSRAMInitStruct->FSMC_MemoryType |
            FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
            FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
            FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait |
 8002694:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
            FSMC_NORSRAMInitStruct->FSMC_WrapMode |
 8002696:	6879      	ldr	r1, [r7, #4]
 8002698:	69c9      	ldr	r1, [r1, #28]
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_DataAddressMux |
            FSMC_NORSRAMInitStruct->FSMC_MemoryType |
            FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
            FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
            FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
 800269a:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_WrapMode |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive |
 800269c:	6879      	ldr	r1, [r7, #4]
 800269e:	6a09      	ldr	r1, [r1, #32]
            FSMC_NORSRAMInitStruct->FSMC_MemoryType |
            FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
            FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
            FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
            FSMC_NORSRAMInitStruct->FSMC_WrapMode |
 80026a0:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive |
            FSMC_NORSRAMInitStruct->FSMC_WriteOperation |
 80026a2:	6879      	ldr	r1, [r7, #4]
 80026a4:	6a49      	ldr	r1, [r1, #36]	; 0x24
            FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth |
            FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
            FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
            FSMC_NORSRAMInitStruct->FSMC_WrapMode |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive |
 80026a6:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_WriteOperation |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignal |
 80026a8:	6879      	ldr	r1, [r7, #4]
 80026aa:	6a89      	ldr	r1, [r1, #40]	; 0x28
            FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode |
            FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
            FSMC_NORSRAMInitStruct->FSMC_WrapMode |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive |
            FSMC_NORSRAMInitStruct->FSMC_WriteOperation |
 80026ac:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_WaitSignal |
            FSMC_NORSRAMInitStruct->FSMC_ExtendedMode |
 80026ae:	6879      	ldr	r1, [r7, #4]
 80026b0:	6ac9      	ldr	r1, [r1, #44]	; 0x2c
            FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
            FSMC_NORSRAMInitStruct->FSMC_WrapMode |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive |
            FSMC_NORSRAMInitStruct->FSMC_WriteOperation |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignal |
 80026b2:	4308      	orrs	r0, r1
            FSMC_NORSRAMInitStruct->FSMC_ExtendedMode |
            FSMC_NORSRAMInitStruct->FSMC_WriteBurst;
 80026b4:	6879      	ldr	r1, [r7, #4]
 80026b6:	6b09      	ldr	r1, [r1, #48]	; 0x30
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity |
            FSMC_NORSRAMInitStruct->FSMC_WrapMode |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive |
            FSMC_NORSRAMInitStruct->FSMC_WriteOperation |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignal |
            FSMC_NORSRAMInitStruct->FSMC_ExtendedMode |
 80026b8:	4301      	orrs	r1, r0
  assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision));
  assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency));
  assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode)); 
  
  /* Bank1 NOR/SRAM control register configuration */ 
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
 80026ba:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
            FSMC_NORSRAMInitStruct->FSMC_WriteOperation |
            FSMC_NORSRAMInitStruct->FSMC_WaitSignal |
            FSMC_NORSRAMInitStruct->FSMC_ExtendedMode |
            FSMC_NORSRAMInitStruct->FSMC_WriteBurst;

  if(FSMC_NORSRAMInitStruct->FSMC_MemoryType == FSMC_MemoryType_NOR)
 80026be:	687b      	ldr	r3, [r7, #4]
 80026c0:	689b      	ldr	r3, [r3, #8]
 80026c2:	2b08      	cmp	r3, #8
 80026c4:	d10d      	bne.n	80026e2 <FSMC_NORSRAMInit+0x7e>
  {
    FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] |= (uint32_t)BCR_FACCEN_Set;
 80026c6:	f04f 4320 	mov.w	r3, #2684354560	; 0xa0000000
 80026ca:	687a      	ldr	r2, [r7, #4]
 80026cc:	6812      	ldr	r2, [r2, #0]
 80026ce:	f04f 4120 	mov.w	r1, #2684354560	; 0xa0000000
 80026d2:	6878      	ldr	r0, [r7, #4]
 80026d4:	6800      	ldr	r0, [r0, #0]
 80026d6:	f851 1020 	ldr.w	r1, [r1, r0, lsl #2]
 80026da:	f041 0140 	orr.w	r1, r1, #64	; 0x40
 80026de:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
  }
  
  /* Bank1 NOR/SRAM timing register configuration */
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank+1] = 
 80026e2:	f04f 4320 	mov.w	r3, #2684354560	; 0xa0000000
 80026e6:	687a      	ldr	r2, [r7, #4]
 80026e8:	6812      	ldr	r2, [r2, #0]
 80026ea:	f102 0201 	add.w	r2, r2, #1
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime |
 80026ee:	6879      	ldr	r1, [r7, #4]
 80026f0:	6b49      	ldr	r1, [r1, #52]	; 0x34
 80026f2:	6808      	ldr	r0, [r1, #0]
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime << 4) |
 80026f4:	6879      	ldr	r1, [r7, #4]
 80026f6:	6b49      	ldr	r1, [r1, #52]	; 0x34
 80026f8:	6849      	ldr	r1, [r1, #4]
 80026fa:	ea4f 1101 	mov.w	r1, r1, lsl #4
    FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] |= (uint32_t)BCR_FACCEN_Set;
  }
  
  /* Bank1 NOR/SRAM timing register configuration */
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank+1] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime |
 80026fe:	4308      	orrs	r0, r1
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime << 4) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime << 8) |
 8002700:	6879      	ldr	r1, [r7, #4]
 8002702:	6b49      	ldr	r1, [r1, #52]	; 0x34
 8002704:	6889      	ldr	r1, [r1, #8]
 8002706:	ea4f 2101 	mov.w	r1, r1, lsl #8
  }
  
  /* Bank1 NOR/SRAM timing register configuration */
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank+1] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime << 4) |
 800270a:	4308      	orrs	r0, r1
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime << 8) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration << 16) |
 800270c:	6879      	ldr	r1, [r7, #4]
 800270e:	6b49      	ldr	r1, [r1, #52]	; 0x34
 8002710:	68c9      	ldr	r1, [r1, #12]
 8002712:	ea4f 4101 	mov.w	r1, r1, lsl #16
  
  /* Bank1 NOR/SRAM timing register configuration */
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank+1] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime << 4) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime << 8) |
 8002716:	4308      	orrs	r0, r1
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration << 16) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision << 20) |
 8002718:	6879      	ldr	r1, [r7, #4]
 800271a:	6b49      	ldr	r1, [r1, #52]	; 0x34
 800271c:	6909      	ldr	r1, [r1, #16]
 800271e:	ea4f 5101 	mov.w	r1, r1, lsl #20
  /* Bank1 NOR/SRAM timing register configuration */
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank+1] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime << 4) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime << 8) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration << 16) |
 8002722:	4308      	orrs	r0, r1
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision << 20) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency << 24) |
 8002724:	6879      	ldr	r1, [r7, #4]
 8002726:	6b49      	ldr	r1, [r1, #52]	; 0x34
 8002728:	6949      	ldr	r1, [r1, #20]
 800272a:	ea4f 6101 	mov.w	r1, r1, lsl #24
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank+1] = 
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime << 4) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime << 8) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration << 16) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision << 20) |
 800272e:	4308      	orrs	r0, r1
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency << 24) |
             FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode;
 8002730:	6879      	ldr	r1, [r7, #4]
 8002732:	6b49      	ldr	r1, [r1, #52]	; 0x34
 8002734:	6989      	ldr	r1, [r1, #24]
            (uint32_t)FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime << 4) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime << 8) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration << 16) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision << 20) |
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency << 24) |
 8002736:	4301      	orrs	r1, r0
  {
    FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank] |= (uint32_t)BCR_FACCEN_Set;
  }
  
  /* Bank1 NOR/SRAM timing register configuration */
  FSMC_Bank1->BTCR[FSMC_NORSRAMInitStruct->FSMC_Bank+1] = 
 8002738:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
            (FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency << 24) |
             FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode;
            
    
  /* Bank1 NOR/SRAM timing register for write configuration, if extended mode is used */
  if(FSMC_NORSRAMInitStruct->FSMC_ExtendedMode == FSMC_ExtendedMode_Enable)
 800273c:	687b      	ldr	r3, [r7, #4]
 800273e:	6adb      	ldr	r3, [r3, #44]	; 0x2c
 8002740:	f5b3 4f80 	cmp.w	r3, #16384	; 0x4000
 8002744:	d127      	bne.n	8002796 <FSMC_NORSRAMInit+0x132>
    assert_param(IS_FSMC_ADDRESS_HOLD_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime));
    assert_param(IS_FSMC_DATASETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime));
    assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision));
    assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency));
    assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode));
    FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
 8002746:	f44f 7382 	mov.w	r3, #260	; 0x104
 800274a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 800274e:	687a      	ldr	r2, [r7, #4]
 8002750:	6812      	ldr	r2, [r2, #0]
              (uint32_t)FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime |
 8002752:	6879      	ldr	r1, [r7, #4]
 8002754:	6b89      	ldr	r1, [r1, #56]	; 0x38
 8002756:	6808      	ldr	r0, [r1, #0]
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime << 4 )|
 8002758:	6879      	ldr	r1, [r7, #4]
 800275a:	6b89      	ldr	r1, [r1, #56]	; 0x38
 800275c:	6849      	ldr	r1, [r1, #4]
 800275e:	ea4f 1101 	mov.w	r1, r1, lsl #4
    assert_param(IS_FSMC_DATASETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime));
    assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision));
    assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency));
    assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode));
    FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
              (uint32_t)FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime |
 8002762:	4308      	orrs	r0, r1
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime << 4 )|
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime << 8) |
 8002764:	6879      	ldr	r1, [r7, #4]
 8002766:	6b89      	ldr	r1, [r1, #56]	; 0x38
 8002768:	6889      	ldr	r1, [r1, #8]
 800276a:	ea4f 2101 	mov.w	r1, r1, lsl #8
    assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision));
    assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency));
    assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode));
    FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
              (uint32_t)FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime |
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime << 4 )|
 800276e:	4308      	orrs	r0, r1
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime << 8) |
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision << 20) |
 8002770:	6879      	ldr	r1, [r7, #4]
 8002772:	6b89      	ldr	r1, [r1, #56]	; 0x38
 8002774:	6909      	ldr	r1, [r1, #16]
 8002776:	ea4f 5101 	mov.w	r1, r1, lsl #20
    assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency));
    assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode));
    FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
              (uint32_t)FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime |
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime << 4 )|
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime << 8) |
 800277a:	4308      	orrs	r0, r1
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision << 20) |
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency << 24) |
 800277c:	6879      	ldr	r1, [r7, #4]
 800277e:	6b89      	ldr	r1, [r1, #56]	; 0x38
 8002780:	6949      	ldr	r1, [r1, #20]
 8002782:	ea4f 6101 	mov.w	r1, r1, lsl #24
    assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode));
    FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
              (uint32_t)FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime |
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime << 4 )|
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime << 8) |
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision << 20) |
 8002786:	4308      	orrs	r0, r1
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency << 24) |
               FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode;
 8002788:	6879      	ldr	r1, [r7, #4]
 800278a:	6b89      	ldr	r1, [r1, #56]	; 0x38
 800278c:	6989      	ldr	r1, [r1, #24]
    FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
              (uint32_t)FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime |
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime << 4 )|
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime << 8) |
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision << 20) |
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency << 24) |
 800278e:	4301      	orrs	r1, r0
    assert_param(IS_FSMC_ADDRESS_HOLD_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime));
    assert_param(IS_FSMC_DATASETUP_TIME(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime));
    assert_param(IS_FSMC_CLK_DIV(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision));
    assert_param(IS_FSMC_DATA_LATENCY(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency));
    assert_param(IS_FSMC_ACCESS_MODE(FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode));
    FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 
 8002790:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
 8002794:	e009      	b.n	80027aa <FSMC_NORSRAMInit+0x146>
              (FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency << 24) |
               FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode;
  }
  else
  {
    FSMC_Bank1E->BWTR[FSMC_NORSRAMInitStruct->FSMC_Bank] = 0x0FFFFFFF;
 8002796:	f44f 7382 	mov.w	r3, #260	; 0x104
 800279a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 800279e:	687a      	ldr	r2, [r7, #4]
 80027a0:	6812      	ldr	r2, [r2, #0]
 80027a2:	f06f 4170 	mvn.w	r1, #4026531840	; 0xf0000000
 80027a6:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
  }
}
 80027aa:	f107 070c 	add.w	r7, r7, #12
 80027ae:	46bd      	mov	sp, r7
 80027b0:	bc80      	pop	{r7}
 80027b2:	4770      	bx	lr

080027b4 <FSMC_NANDInit>:
  *         structure that contains the configuration information for the FSMC 
  *         NAND specified Banks.                       
  * @retval None
  */
void FSMC_NANDInit(FSMC_NANDInitTypeDef* FSMC_NANDInitStruct)
{
 80027b4:	b480      	push	{r7}
 80027b6:	b087      	sub	sp, #28
 80027b8:	af00      	add	r7, sp, #0
 80027ba:	6078      	str	r0, [r7, #4]
  uint32_t tmppcr = 0x00000000, tmppmem = 0x00000000, tmppatt = 0x00000000; 
 80027bc:	f04f 0300 	mov.w	r3, #0
 80027c0:	617b      	str	r3, [r7, #20]
 80027c2:	f04f 0300 	mov.w	r3, #0
 80027c6:	613b      	str	r3, [r7, #16]
 80027c8:	f04f 0300 	mov.w	r3, #0
 80027cc:	60fb      	str	r3, [r7, #12]
  assert_param(IS_FSMC_WAIT_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime));
  assert_param(IS_FSMC_HOLD_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime));
  assert_param(IS_FSMC_HIZ_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime));
  
  /* Set the tmppcr value according to FSMC_NANDInitStruct parameters */
  tmppcr = (uint32_t)FSMC_NANDInitStruct->FSMC_Waitfeature |
 80027ce:	687b      	ldr	r3, [r7, #4]
 80027d0:	685a      	ldr	r2, [r3, #4]
            PCR_MemoryType_NAND |
            FSMC_NANDInitStruct->FSMC_MemoryDataWidth |
 80027d2:	687b      	ldr	r3, [r7, #4]
 80027d4:	689b      	ldr	r3, [r3, #8]
  assert_param(IS_FSMC_HOLD_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime));
  assert_param(IS_FSMC_HIZ_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime));
  
  /* Set the tmppcr value according to FSMC_NANDInitStruct parameters */
  tmppcr = (uint32_t)FSMC_NANDInitStruct->FSMC_Waitfeature |
            PCR_MemoryType_NAND |
 80027d6:	431a      	orrs	r2, r3
            FSMC_NANDInitStruct->FSMC_MemoryDataWidth |
            FSMC_NANDInitStruct->FSMC_ECC |
 80027d8:	687b      	ldr	r3, [r7, #4]
 80027da:	68db      	ldr	r3, [r3, #12]
  assert_param(IS_FSMC_HIZ_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime));
  
  /* Set the tmppcr value according to FSMC_NANDInitStruct parameters */
  tmppcr = (uint32_t)FSMC_NANDInitStruct->FSMC_Waitfeature |
            PCR_MemoryType_NAND |
            FSMC_NANDInitStruct->FSMC_MemoryDataWidth |
 80027dc:	431a      	orrs	r2, r3
            FSMC_NANDInitStruct->FSMC_ECC |
            FSMC_NANDInitStruct->FSMC_ECCPageSize |
 80027de:	687b      	ldr	r3, [r7, #4]
 80027e0:	691b      	ldr	r3, [r3, #16]
  
  /* Set the tmppcr value according to FSMC_NANDInitStruct parameters */
  tmppcr = (uint32_t)FSMC_NANDInitStruct->FSMC_Waitfeature |
            PCR_MemoryType_NAND |
            FSMC_NANDInitStruct->FSMC_MemoryDataWidth |
            FSMC_NANDInitStruct->FSMC_ECC |
 80027e2:	431a      	orrs	r2, r3
            FSMC_NANDInitStruct->FSMC_ECCPageSize |
            (FSMC_NANDInitStruct->FSMC_TCLRSetupTime << 9 )|
 80027e4:	687b      	ldr	r3, [r7, #4]
 80027e6:	695b      	ldr	r3, [r3, #20]
 80027e8:	ea4f 2343 	mov.w	r3, r3, lsl #9
  /* Set the tmppcr value according to FSMC_NANDInitStruct parameters */
  tmppcr = (uint32_t)FSMC_NANDInitStruct->FSMC_Waitfeature |
            PCR_MemoryType_NAND |
            FSMC_NANDInitStruct->FSMC_MemoryDataWidth |
            FSMC_NANDInitStruct->FSMC_ECC |
            FSMC_NANDInitStruct->FSMC_ECCPageSize |
 80027ec:	431a      	orrs	r2, r3
            (FSMC_NANDInitStruct->FSMC_TCLRSetupTime << 9 )|
            (FSMC_NANDInitStruct->FSMC_TARSetupTime << 13);
 80027ee:	687b      	ldr	r3, [r7, #4]
 80027f0:	699b      	ldr	r3, [r3, #24]
 80027f2:	ea4f 3343 	mov.w	r3, r3, lsl #13
  tmppcr = (uint32_t)FSMC_NANDInitStruct->FSMC_Waitfeature |
            PCR_MemoryType_NAND |
            FSMC_NANDInitStruct->FSMC_MemoryDataWidth |
            FSMC_NANDInitStruct->FSMC_ECC |
            FSMC_NANDInitStruct->FSMC_ECCPageSize |
            (FSMC_NANDInitStruct->FSMC_TCLRSetupTime << 9 )|
 80027f6:	4313      	orrs	r3, r2
  assert_param(IS_FSMC_WAIT_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime));
  assert_param(IS_FSMC_HOLD_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime));
  assert_param(IS_FSMC_HIZ_TIME(FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime));
  
  /* Set the tmppcr value according to FSMC_NANDInitStruct parameters */
  tmppcr = (uint32_t)FSMC_NANDInitStruct->FSMC_Waitfeature |
 80027f8:	f043 0308 	orr.w	r3, r3, #8
 80027fc:	617b      	str	r3, [r7, #20]
            FSMC_NANDInitStruct->FSMC_ECCPageSize |
            (FSMC_NANDInitStruct->FSMC_TCLRSetupTime << 9 )|
            (FSMC_NANDInitStruct->FSMC_TARSetupTime << 13);
            
  /* Set tmppmem value according to FSMC_CommonSpaceTimingStructure parameters */
  tmppmem = (uint32_t)FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
 80027fe:	687b      	ldr	r3, [r7, #4]
 8002800:	69db      	ldr	r3, [r3, #28]
 8002802:	681a      	ldr	r2, [r3, #0]
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 8002804:	687b      	ldr	r3, [r7, #4]
 8002806:	69db      	ldr	r3, [r3, #28]
 8002808:	685b      	ldr	r3, [r3, #4]
 800280a:	ea4f 2303 	mov.w	r3, r3, lsl #8
            FSMC_NANDInitStruct->FSMC_ECCPageSize |
            (FSMC_NANDInitStruct->FSMC_TCLRSetupTime << 9 )|
            (FSMC_NANDInitStruct->FSMC_TARSetupTime << 13);
            
  /* Set tmppmem value according to FSMC_CommonSpaceTimingStructure parameters */
  tmppmem = (uint32_t)FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
 800280e:	431a      	orrs	r2, r3
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
 8002810:	687b      	ldr	r3, [r7, #4]
 8002812:	69db      	ldr	r3, [r3, #28]
 8002814:	689b      	ldr	r3, [r3, #8]
 8002816:	ea4f 4303 	mov.w	r3, r3, lsl #16
            (FSMC_NANDInitStruct->FSMC_TCLRSetupTime << 9 )|
            (FSMC_NANDInitStruct->FSMC_TARSetupTime << 13);
            
  /* Set tmppmem value according to FSMC_CommonSpaceTimingStructure parameters */
  tmppmem = (uint32_t)FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 800281a:	431a      	orrs	r2, r3
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
 800281c:	687b      	ldr	r3, [r7, #4]
 800281e:	69db      	ldr	r3, [r3, #28]
 8002820:	68db      	ldr	r3, [r3, #12]
 8002822:	ea4f 6303 	mov.w	r3, r3, lsl #24
            FSMC_NANDInitStruct->FSMC_ECCPageSize |
            (FSMC_NANDInitStruct->FSMC_TCLRSetupTime << 9 )|
            (FSMC_NANDInitStruct->FSMC_TARSetupTime << 13);
            
  /* Set tmppmem value according to FSMC_CommonSpaceTimingStructure parameters */
  tmppmem = (uint32_t)FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
 8002826:	4313      	orrs	r3, r2
 8002828:	613b      	str	r3, [r7, #16]
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
            
  /* Set tmppatt value according to FSMC_AttributeSpaceTimingStructure parameters */
  tmppatt = (uint32_t)FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
 800282a:	687b      	ldr	r3, [r7, #4]
 800282c:	6a1b      	ldr	r3, [r3, #32]
 800282e:	681a      	ldr	r2, [r3, #0]
            (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 8002830:	687b      	ldr	r3, [r7, #4]
 8002832:	6a1b      	ldr	r3, [r3, #32]
 8002834:	685b      	ldr	r3, [r3, #4]
 8002836:	ea4f 2303 	mov.w	r3, r3, lsl #8
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
            
  /* Set tmppatt value according to FSMC_AttributeSpaceTimingStructure parameters */
  tmppatt = (uint32_t)FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
 800283a:	431a      	orrs	r2, r3
            (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
            (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
 800283c:	687b      	ldr	r3, [r7, #4]
 800283e:	6a1b      	ldr	r3, [r3, #32]
 8002840:	689b      	ldr	r3, [r3, #8]
 8002842:	ea4f 4303 	mov.w	r3, r3, lsl #16
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
            
  /* Set tmppatt value according to FSMC_AttributeSpaceTimingStructure parameters */
  tmppatt = (uint32_t)FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
            (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 8002846:	431a      	orrs	r2, r3
            (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
            (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);
 8002848:	687b      	ldr	r3, [r7, #4]
 800284a:	6a1b      	ldr	r3, [r3, #32]
 800284c:	68db      	ldr	r3, [r3, #12]
 800284e:	ea4f 6303 	mov.w	r3, r3, lsl #24
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
            (FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
            
  /* Set tmppatt value according to FSMC_AttributeSpaceTimingStructure parameters */
  tmppatt = (uint32_t)FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
 8002852:	4313      	orrs	r3, r2
 8002854:	60fb      	str	r3, [r7, #12]
            (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
            (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
            (FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);
  
  if(FSMC_NANDInitStruct->FSMC_Bank == FSMC_Bank2_NAND)
 8002856:	687b      	ldr	r3, [r7, #4]
 8002858:	681b      	ldr	r3, [r3, #0]
 800285a:	2b10      	cmp	r3, #16
 800285c:	d112      	bne.n	8002884 <FSMC_NANDInit+0xd0>
  {
    /* FSMC_Bank2_NAND registers configuration */
    FSMC_Bank2->PCR2 = tmppcr;
 800285e:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002862:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002866:	697a      	ldr	r2, [r7, #20]
 8002868:	601a      	str	r2, [r3, #0]
    FSMC_Bank2->PMEM2 = tmppmem;
 800286a:	f04f 0360 	mov.w	r3, #96	; 0x60
 800286e:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002872:	693a      	ldr	r2, [r7, #16]
 8002874:	609a      	str	r2, [r3, #8]
    FSMC_Bank2->PATT2 = tmppatt;
 8002876:	f04f 0360 	mov.w	r3, #96	; 0x60
 800287a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 800287e:	68fa      	ldr	r2, [r7, #12]
 8002880:	60da      	str	r2, [r3, #12]
 8002882:	e011      	b.n	80028a8 <FSMC_NANDInit+0xf4>
  }
  else
  {
    /* FSMC_Bank3_NAND registers configuration */
    FSMC_Bank3->PCR3 = tmppcr;
 8002884:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002888:	f2ca 0300 	movt	r3, #40960	; 0xa000
 800288c:	697a      	ldr	r2, [r7, #20]
 800288e:	601a      	str	r2, [r3, #0]
    FSMC_Bank3->PMEM3 = tmppmem;
 8002890:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002894:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002898:	693a      	ldr	r2, [r7, #16]
 800289a:	609a      	str	r2, [r3, #8]
    FSMC_Bank3->PATT3 = tmppatt;
 800289c:	f04f 0380 	mov.w	r3, #128	; 0x80
 80028a0:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80028a4:	68fa      	ldr	r2, [r7, #12]
 80028a6:	60da      	str	r2, [r3, #12]
  }
}
 80028a8:	f107 071c 	add.w	r7, r7, #28
 80028ac:	46bd      	mov	sp, r7
 80028ae:	bc80      	pop	{r7}
 80028b0:	4770      	bx	lr
 80028b2:	bf00      	nop

080028b4 <FSMC_PCCARDInit>:
  *         structure that contains the configuration information for the FSMC 
  *         PCCARD Bank.                       
  * @retval None
  */
void FSMC_PCCARDInit(FSMC_PCCARDInitTypeDef* FSMC_PCCARDInitStruct)
{
 80028b4:	b480      	push	{r7}
 80028b6:	b083      	sub	sp, #12
 80028b8:	af00      	add	r7, sp, #0
 80028ba:	6078      	str	r0, [r7, #4]
  assert_param(IS_FSMC_WAIT_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime));
  assert_param(IS_FSMC_HOLD_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime));
  assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime));
  
  /* Set the PCR4 register value according to FSMC_PCCARDInitStruct parameters */
  FSMC_Bank4->PCR4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_Waitfeature |
 80028bc:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 80028c0:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80028c4:	687a      	ldr	r2, [r7, #4]
 80028c6:	6811      	ldr	r1, [r2, #0]
                     FSMC_MemoryDataWidth_16b |  
                     (FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime << 9) |
 80028c8:	687a      	ldr	r2, [r7, #4]
 80028ca:	6852      	ldr	r2, [r2, #4]
 80028cc:	ea4f 2242 	mov.w	r2, r2, lsl #9
  assert_param(IS_FSMC_HOLD_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime));
  assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime));
  
  /* Set the PCR4 register value according to FSMC_PCCARDInitStruct parameters */
  FSMC_Bank4->PCR4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_Waitfeature |
                     FSMC_MemoryDataWidth_16b |  
 80028d0:	4311      	orrs	r1, r2
                     (FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime << 9) |
                     (FSMC_PCCARDInitStruct->FSMC_TARSetupTime << 13);
 80028d2:	687a      	ldr	r2, [r7, #4]
 80028d4:	6892      	ldr	r2, [r2, #8]
 80028d6:	ea4f 3242 	mov.w	r2, r2, lsl #13
  assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime));
  
  /* Set the PCR4 register value according to FSMC_PCCARDInitStruct parameters */
  FSMC_Bank4->PCR4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_Waitfeature |
                     FSMC_MemoryDataWidth_16b |  
                     (FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime << 9) |
 80028da:	430a      	orrs	r2, r1
 80028dc:	f042 0210 	orr.w	r2, r2, #16
  assert_param(IS_FSMC_WAIT_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime));
  assert_param(IS_FSMC_HOLD_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime));
  assert_param(IS_FSMC_HIZ_TIME(FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime));
  
  /* Set the PCR4 register value according to FSMC_PCCARDInitStruct parameters */
  FSMC_Bank4->PCR4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_Waitfeature |
 80028e0:	601a      	str	r2, [r3, #0]
                     FSMC_MemoryDataWidth_16b |  
                     (FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime << 9) |
                     (FSMC_PCCARDInitStruct->FSMC_TARSetupTime << 13);
            
  /* Set PMEM4 register value according to FSMC_CommonSpaceTimingStructure parameters */
  FSMC_Bank4->PMEM4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
 80028e2:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 80028e6:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80028ea:	687a      	ldr	r2, [r7, #4]
 80028ec:	68d2      	ldr	r2, [r2, #12]
 80028ee:	6811      	ldr	r1, [r2, #0]
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 80028f0:	687a      	ldr	r2, [r7, #4]
 80028f2:	68d2      	ldr	r2, [r2, #12]
 80028f4:	6852      	ldr	r2, [r2, #4]
 80028f6:	ea4f 2202 	mov.w	r2, r2, lsl #8
                     FSMC_MemoryDataWidth_16b |  
                     (FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime << 9) |
                     (FSMC_PCCARDInitStruct->FSMC_TARSetupTime << 13);
            
  /* Set PMEM4 register value according to FSMC_CommonSpaceTimingStructure parameters */
  FSMC_Bank4->PMEM4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
 80028fa:	4311      	orrs	r1, r2
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
 80028fc:	687a      	ldr	r2, [r7, #4]
 80028fe:	68d2      	ldr	r2, [r2, #12]
 8002900:	6892      	ldr	r2, [r2, #8]
 8002902:	ea4f 4202 	mov.w	r2, r2, lsl #16
                     (FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime << 9) |
                     (FSMC_PCCARDInitStruct->FSMC_TARSetupTime << 13);
            
  /* Set PMEM4 register value according to FSMC_CommonSpaceTimingStructure parameters */
  FSMC_Bank4->PMEM4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 8002906:	4311      	orrs	r1, r2
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
 8002908:	687a      	ldr	r2, [r7, #4]
 800290a:	68d2      	ldr	r2, [r2, #12]
 800290c:	68d2      	ldr	r2, [r2, #12]
 800290e:	ea4f 6202 	mov.w	r2, r2, lsl #24
                     (FSMC_PCCARDInitStruct->FSMC_TARSetupTime << 13);
            
  /* Set PMEM4 register value according to FSMC_CommonSpaceTimingStructure parameters */
  FSMC_Bank4->PMEM4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
 8002912:	430a      	orrs	r2, r1
                     FSMC_MemoryDataWidth_16b |  
                     (FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime << 9) |
                     (FSMC_PCCARDInitStruct->FSMC_TARSetupTime << 13);
            
  /* Set PMEM4 register value according to FSMC_CommonSpaceTimingStructure parameters */
  FSMC_Bank4->PMEM4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime |
 8002914:	609a      	str	r2, [r3, #8]
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
            
  /* Set PATT4 register value according to FSMC_AttributeSpaceTimingStructure parameters */
  FSMC_Bank4->PATT4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
 8002916:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 800291a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 800291e:	687a      	ldr	r2, [r7, #4]
 8002920:	6912      	ldr	r2, [r2, #16]
 8002922:	6811      	ldr	r1, [r2, #0]
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 8002924:	687a      	ldr	r2, [r7, #4]
 8002926:	6912      	ldr	r2, [r2, #16]
 8002928:	6852      	ldr	r2, [r2, #4]
 800292a:	ea4f 2202 	mov.w	r2, r2, lsl #8
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
            
  /* Set PATT4 register value according to FSMC_AttributeSpaceTimingStructure parameters */
  FSMC_Bank4->PATT4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
 800292e:	4311      	orrs	r1, r2
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
 8002930:	687a      	ldr	r2, [r7, #4]
 8002932:	6912      	ldr	r2, [r2, #16]
 8002934:	6892      	ldr	r2, [r2, #8]
 8002936:	ea4f 4202 	mov.w	r2, r2, lsl #16
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
            
  /* Set PATT4 register value according to FSMC_AttributeSpaceTimingStructure parameters */
  FSMC_Bank4->PATT4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 800293a:	4311      	orrs	r1, r2
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);	
 800293c:	687a      	ldr	r2, [r7, #4]
 800293e:	6912      	ldr	r2, [r2, #16]
 8002940:	68d2      	ldr	r2, [r2, #12]
 8002942:	ea4f 6202 	mov.w	r2, r2, lsl #24
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
            
  /* Set PATT4 register value according to FSMC_AttributeSpaceTimingStructure parameters */
  FSMC_Bank4->PATT4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
 8002946:	430a      	orrs	r2, r1
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime << 24); 
            
  /* Set PATT4 register value according to FSMC_AttributeSpaceTimingStructure parameters */
  FSMC_Bank4->PATT4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime |
 8002948:	60da      	str	r2, [r3, #12]
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);	
            
  /* Set PIO4 register value according to FSMC_IOSpaceTimingStructure parameters */
  FSMC_Bank4->PIO4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime |
 800294a:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 800294e:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002952:	687a      	ldr	r2, [r7, #4]
 8002954:	6952      	ldr	r2, [r2, #20]
 8002956:	6811      	ldr	r1, [r2, #0]
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 8002958:	687a      	ldr	r2, [r7, #4]
 800295a:	6952      	ldr	r2, [r2, #20]
 800295c:	6852      	ldr	r2, [r2, #4]
 800295e:	ea4f 2202 	mov.w	r2, r2, lsl #8
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);	
            
  /* Set PIO4 register value according to FSMC_IOSpaceTimingStructure parameters */
  FSMC_Bank4->PIO4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime |
 8002962:	4311      	orrs	r1, r2
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
 8002964:	687a      	ldr	r2, [r7, #4]
 8002966:	6952      	ldr	r2, [r2, #20]
 8002968:	6892      	ldr	r2, [r2, #8]
 800296a:	ea4f 4202 	mov.w	r2, r2, lsl #16
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);	
            
  /* Set PIO4 register value according to FSMC_IOSpaceTimingStructure parameters */
  FSMC_Bank4->PIO4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime |
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
 800296e:	4311      	orrs	r1, r2
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime << 24);             
 8002970:	687a      	ldr	r2, [r7, #4]
 8002972:	6952      	ldr	r2, [r2, #20]
 8002974:	68d2      	ldr	r2, [r2, #12]
 8002976:	ea4f 6202 	mov.w	r2, r2, lsl #24
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);	
            
  /* Set PIO4 register value according to FSMC_IOSpaceTimingStructure parameters */
  FSMC_Bank4->PIO4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime |
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
 800297a:	430a      	orrs	r2, r1
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                      (FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime << 24);	
            
  /* Set PIO4 register value according to FSMC_IOSpaceTimingStructure parameters */
  FSMC_Bank4->PIO4 = (uint32_t)FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime |
 800297c:	611a      	str	r2, [r3, #16]
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime << 8) |
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime << 16)|
                     (FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime << 24);             
}
 800297e:	f107 070c 	add.w	r7, r7, #12
 8002982:	46bd      	mov	sp, r7
 8002984:	bc80      	pop	{r7}
 8002986:	4770      	bx	lr

08002988 <FSMC_NORSRAMStructInit>:
  * @param  FSMC_NORSRAMInitStruct: pointer to a FSMC_NORSRAMInitTypeDef 
  *         structure which will be initialized.
  * @retval None
  */
void FSMC_NORSRAMStructInit(FSMC_NORSRAMInitTypeDef* FSMC_NORSRAMInitStruct)
{  
 8002988:	b480      	push	{r7}
 800298a:	b083      	sub	sp, #12
 800298c:	af00      	add	r7, sp, #0
 800298e:	6078      	str	r0, [r7, #4]
  /* Reset NOR/SRAM Init structure parameters values */
  FSMC_NORSRAMInitStruct->FSMC_Bank = FSMC_Bank1_NORSRAM1;
 8002990:	687b      	ldr	r3, [r7, #4]
 8002992:	f04f 0200 	mov.w	r2, #0
 8002996:	601a      	str	r2, [r3, #0]
  FSMC_NORSRAMInitStruct->FSMC_DataAddressMux = FSMC_DataAddressMux_Enable;
 8002998:	687b      	ldr	r3, [r7, #4]
 800299a:	f04f 0202 	mov.w	r2, #2
 800299e:	605a      	str	r2, [r3, #4]
  FSMC_NORSRAMInitStruct->FSMC_MemoryType = FSMC_MemoryType_SRAM;
 80029a0:	687b      	ldr	r3, [r7, #4]
 80029a2:	f04f 0200 	mov.w	r2, #0
 80029a6:	609a      	str	r2, [r3, #8]
  FSMC_NORSRAMInitStruct->FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_8b;
 80029a8:	687b      	ldr	r3, [r7, #4]
 80029aa:	f04f 0200 	mov.w	r2, #0
 80029ae:	60da      	str	r2, [r3, #12]
  FSMC_NORSRAMInitStruct->FSMC_BurstAccessMode = FSMC_BurstAccessMode_Disable;
 80029b0:	687b      	ldr	r3, [r7, #4]
 80029b2:	f04f 0200 	mov.w	r2, #0
 80029b6:	611a      	str	r2, [r3, #16]
  FSMC_NORSRAMInitStruct->FSMC_AsynchronousWait = FSMC_AsynchronousWait_Disable;
 80029b8:	687b      	ldr	r3, [r7, #4]
 80029ba:	f04f 0200 	mov.w	r2, #0
 80029be:	615a      	str	r2, [r3, #20]
  FSMC_NORSRAMInitStruct->FSMC_WaitSignalPolarity = FSMC_WaitSignalPolarity_Low;
 80029c0:	687b      	ldr	r3, [r7, #4]
 80029c2:	f04f 0200 	mov.w	r2, #0
 80029c6:	619a      	str	r2, [r3, #24]
  FSMC_NORSRAMInitStruct->FSMC_WrapMode = FSMC_WrapMode_Disable;
 80029c8:	687b      	ldr	r3, [r7, #4]
 80029ca:	f04f 0200 	mov.w	r2, #0
 80029ce:	61da      	str	r2, [r3, #28]
  FSMC_NORSRAMInitStruct->FSMC_WaitSignalActive = FSMC_WaitSignalActive_BeforeWaitState;
 80029d0:	687b      	ldr	r3, [r7, #4]
 80029d2:	f04f 0200 	mov.w	r2, #0
 80029d6:	621a      	str	r2, [r3, #32]
  FSMC_NORSRAMInitStruct->FSMC_WriteOperation = FSMC_WriteOperation_Enable;
 80029d8:	687b      	ldr	r3, [r7, #4]
 80029da:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80029de:	625a      	str	r2, [r3, #36]	; 0x24
  FSMC_NORSRAMInitStruct->FSMC_WaitSignal = FSMC_WaitSignal_Enable;
 80029e0:	687b      	ldr	r3, [r7, #4]
 80029e2:	f44f 5200 	mov.w	r2, #8192	; 0x2000
 80029e6:	629a      	str	r2, [r3, #40]	; 0x28
  FSMC_NORSRAMInitStruct->FSMC_ExtendedMode = FSMC_ExtendedMode_Disable;
 80029e8:	687b      	ldr	r3, [r7, #4]
 80029ea:	f04f 0200 	mov.w	r2, #0
 80029ee:	62da      	str	r2, [r3, #44]	; 0x2c
  FSMC_NORSRAMInitStruct->FSMC_WriteBurst = FSMC_WriteBurst_Disable;
 80029f0:	687b      	ldr	r3, [r7, #4]
 80029f2:	f04f 0200 	mov.w	r2, #0
 80029f6:	631a      	str	r2, [r3, #48]	; 0x30
  FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressSetupTime = 0xF;
 80029f8:	687b      	ldr	r3, [r7, #4]
 80029fa:	6b5b      	ldr	r3, [r3, #52]	; 0x34
 80029fc:	f04f 020f 	mov.w	r2, #15
 8002a00:	601a      	str	r2, [r3, #0]
  FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AddressHoldTime = 0xF;
 8002a02:	687b      	ldr	r3, [r7, #4]
 8002a04:	6b5b      	ldr	r3, [r3, #52]	; 0x34
 8002a06:	f04f 020f 	mov.w	r2, #15
 8002a0a:	605a      	str	r2, [r3, #4]
  FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataSetupTime = 0xFF;
 8002a0c:	687b      	ldr	r3, [r7, #4]
 8002a0e:	6b5b      	ldr	r3, [r3, #52]	; 0x34
 8002a10:	f04f 02ff 	mov.w	r2, #255	; 0xff
 8002a14:	609a      	str	r2, [r3, #8]
  FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_BusTurnAroundDuration = 0xF;
 8002a16:	687b      	ldr	r3, [r7, #4]
 8002a18:	6b5b      	ldr	r3, [r3, #52]	; 0x34
 8002a1a:	f04f 020f 	mov.w	r2, #15
 8002a1e:	60da      	str	r2, [r3, #12]
  FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_CLKDivision = 0xF;
 8002a20:	687b      	ldr	r3, [r7, #4]
 8002a22:	6b5b      	ldr	r3, [r3, #52]	; 0x34
 8002a24:	f04f 020f 	mov.w	r2, #15
 8002a28:	611a      	str	r2, [r3, #16]
  FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_DataLatency = 0xF;
 8002a2a:	687b      	ldr	r3, [r7, #4]
 8002a2c:	6b5b      	ldr	r3, [r3, #52]	; 0x34
 8002a2e:	f04f 020f 	mov.w	r2, #15
 8002a32:	615a      	str	r2, [r3, #20]
  FSMC_NORSRAMInitStruct->FSMC_ReadWriteTimingStruct->FSMC_AccessMode = FSMC_AccessMode_A; 
 8002a34:	687b      	ldr	r3, [r7, #4]
 8002a36:	6b5b      	ldr	r3, [r3, #52]	; 0x34
 8002a38:	f04f 0200 	mov.w	r2, #0
 8002a3c:	619a      	str	r2, [r3, #24]
  FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressSetupTime = 0xF;
 8002a3e:	687b      	ldr	r3, [r7, #4]
 8002a40:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8002a42:	f04f 020f 	mov.w	r2, #15
 8002a46:	601a      	str	r2, [r3, #0]
  FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AddressHoldTime = 0xF;
 8002a48:	687b      	ldr	r3, [r7, #4]
 8002a4a:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8002a4c:	f04f 020f 	mov.w	r2, #15
 8002a50:	605a      	str	r2, [r3, #4]
  FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataSetupTime = 0xFF;
 8002a52:	687b      	ldr	r3, [r7, #4]
 8002a54:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8002a56:	f04f 02ff 	mov.w	r2, #255	; 0xff
 8002a5a:	609a      	str	r2, [r3, #8]
  FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_BusTurnAroundDuration = 0xF;
 8002a5c:	687b      	ldr	r3, [r7, #4]
 8002a5e:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8002a60:	f04f 020f 	mov.w	r2, #15
 8002a64:	60da      	str	r2, [r3, #12]
  FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_CLKDivision = 0xF;
 8002a66:	687b      	ldr	r3, [r7, #4]
 8002a68:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8002a6a:	f04f 020f 	mov.w	r2, #15
 8002a6e:	611a      	str	r2, [r3, #16]
  FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_DataLatency = 0xF;
 8002a70:	687b      	ldr	r3, [r7, #4]
 8002a72:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8002a74:	f04f 020f 	mov.w	r2, #15
 8002a78:	615a      	str	r2, [r3, #20]
  FSMC_NORSRAMInitStruct->FSMC_WriteTimingStruct->FSMC_AccessMode = FSMC_AccessMode_A;
 8002a7a:	687b      	ldr	r3, [r7, #4]
 8002a7c:	6b9b      	ldr	r3, [r3, #56]	; 0x38
 8002a7e:	f04f 0200 	mov.w	r2, #0
 8002a82:	619a      	str	r2, [r3, #24]
}
 8002a84:	f107 070c 	add.w	r7, r7, #12
 8002a88:	46bd      	mov	sp, r7
 8002a8a:	bc80      	pop	{r7}
 8002a8c:	4770      	bx	lr
 8002a8e:	bf00      	nop

08002a90 <FSMC_NANDStructInit>:
  * @param  FSMC_NANDInitStruct: pointer to a FSMC_NANDInitTypeDef 
  *         structure which will be initialized.
  * @retval None
  */
void FSMC_NANDStructInit(FSMC_NANDInitTypeDef* FSMC_NANDInitStruct)
{ 
 8002a90:	b480      	push	{r7}
 8002a92:	b083      	sub	sp, #12
 8002a94:	af00      	add	r7, sp, #0
 8002a96:	6078      	str	r0, [r7, #4]
  /* Reset NAND Init structure parameters values */
  FSMC_NANDInitStruct->FSMC_Bank = FSMC_Bank2_NAND;
 8002a98:	687b      	ldr	r3, [r7, #4]
 8002a9a:	f04f 0210 	mov.w	r2, #16
 8002a9e:	601a      	str	r2, [r3, #0]
  FSMC_NANDInitStruct->FSMC_Waitfeature = FSMC_Waitfeature_Disable;
 8002aa0:	687b      	ldr	r3, [r7, #4]
 8002aa2:	f04f 0200 	mov.w	r2, #0
 8002aa6:	605a      	str	r2, [r3, #4]
  FSMC_NANDInitStruct->FSMC_MemoryDataWidth = FSMC_MemoryDataWidth_8b;
 8002aa8:	687b      	ldr	r3, [r7, #4]
 8002aaa:	f04f 0200 	mov.w	r2, #0
 8002aae:	609a      	str	r2, [r3, #8]
  FSMC_NANDInitStruct->FSMC_ECC = FSMC_ECC_Disable;
 8002ab0:	687b      	ldr	r3, [r7, #4]
 8002ab2:	f04f 0200 	mov.w	r2, #0
 8002ab6:	60da      	str	r2, [r3, #12]
  FSMC_NANDInitStruct->FSMC_ECCPageSize = FSMC_ECCPageSize_256Bytes;
 8002ab8:	687b      	ldr	r3, [r7, #4]
 8002aba:	f04f 0200 	mov.w	r2, #0
 8002abe:	611a      	str	r2, [r3, #16]
  FSMC_NANDInitStruct->FSMC_TCLRSetupTime = 0x0;
 8002ac0:	687b      	ldr	r3, [r7, #4]
 8002ac2:	f04f 0200 	mov.w	r2, #0
 8002ac6:	615a      	str	r2, [r3, #20]
  FSMC_NANDInitStruct->FSMC_TARSetupTime = 0x0;
 8002ac8:	687b      	ldr	r3, [r7, #4]
 8002aca:	f04f 0200 	mov.w	r2, #0
 8002ace:	619a      	str	r2, [r3, #24]
  FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime = 0xFC;
 8002ad0:	687b      	ldr	r3, [r7, #4]
 8002ad2:	69db      	ldr	r3, [r3, #28]
 8002ad4:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002ad8:	601a      	str	r2, [r3, #0]
  FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
 8002ada:	687b      	ldr	r3, [r7, #4]
 8002adc:	69db      	ldr	r3, [r3, #28]
 8002ade:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002ae2:	605a      	str	r2, [r3, #4]
  FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
 8002ae4:	687b      	ldr	r3, [r7, #4]
 8002ae6:	69db      	ldr	r3, [r3, #28]
 8002ae8:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002aec:	609a      	str	r2, [r3, #8]
  FSMC_NANDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;
 8002aee:	687b      	ldr	r3, [r7, #4]
 8002af0:	69db      	ldr	r3, [r3, #28]
 8002af2:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002af6:	60da      	str	r2, [r3, #12]
  FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime = 0xFC;
 8002af8:	687b      	ldr	r3, [r7, #4]
 8002afa:	6a1b      	ldr	r3, [r3, #32]
 8002afc:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b00:	601a      	str	r2, [r3, #0]
  FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
 8002b02:	687b      	ldr	r3, [r7, #4]
 8002b04:	6a1b      	ldr	r3, [r3, #32]
 8002b06:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b0a:	605a      	str	r2, [r3, #4]
  FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
 8002b0c:	687b      	ldr	r3, [r7, #4]
 8002b0e:	6a1b      	ldr	r3, [r3, #32]
 8002b10:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b14:	609a      	str	r2, [r3, #8]
  FSMC_NANDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;	  
 8002b16:	687b      	ldr	r3, [r7, #4]
 8002b18:	6a1b      	ldr	r3, [r3, #32]
 8002b1a:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b1e:	60da      	str	r2, [r3, #12]
}
 8002b20:	f107 070c 	add.w	r7, r7, #12
 8002b24:	46bd      	mov	sp, r7
 8002b26:	bc80      	pop	{r7}
 8002b28:	4770      	bx	lr
 8002b2a:	bf00      	nop

08002b2c <FSMC_PCCARDStructInit>:
  * @param  FSMC_PCCARDInitStruct: pointer to a FSMC_PCCARDInitTypeDef 
  *         structure which will be initialized.
  * @retval None
  */
void FSMC_PCCARDStructInit(FSMC_PCCARDInitTypeDef* FSMC_PCCARDInitStruct)
{
 8002b2c:	b480      	push	{r7}
 8002b2e:	b083      	sub	sp, #12
 8002b30:	af00      	add	r7, sp, #0
 8002b32:	6078      	str	r0, [r7, #4]
  /* Reset PCCARD Init structure parameters values */
  FSMC_PCCARDInitStruct->FSMC_Waitfeature = FSMC_Waitfeature_Disable;
 8002b34:	687b      	ldr	r3, [r7, #4]
 8002b36:	f04f 0200 	mov.w	r2, #0
 8002b3a:	601a      	str	r2, [r3, #0]
  FSMC_PCCARDInitStruct->FSMC_TCLRSetupTime = 0x0;
 8002b3c:	687b      	ldr	r3, [r7, #4]
 8002b3e:	f04f 0200 	mov.w	r2, #0
 8002b42:	605a      	str	r2, [r3, #4]
  FSMC_PCCARDInitStruct->FSMC_TARSetupTime = 0x0;
 8002b44:	687b      	ldr	r3, [r7, #4]
 8002b46:	f04f 0200 	mov.w	r2, #0
 8002b4a:	609a      	str	r2, [r3, #8]
  FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_SetupTime = 0xFC;
 8002b4c:	687b      	ldr	r3, [r7, #4]
 8002b4e:	68db      	ldr	r3, [r3, #12]
 8002b50:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b54:	601a      	str	r2, [r3, #0]
  FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
 8002b56:	687b      	ldr	r3, [r7, #4]
 8002b58:	68db      	ldr	r3, [r3, #12]
 8002b5a:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b5e:	605a      	str	r2, [r3, #4]
  FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
 8002b60:	687b      	ldr	r3, [r7, #4]
 8002b62:	68db      	ldr	r3, [r3, #12]
 8002b64:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b68:	609a      	str	r2, [r3, #8]
  FSMC_PCCARDInitStruct->FSMC_CommonSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;
 8002b6a:	687b      	ldr	r3, [r7, #4]
 8002b6c:	68db      	ldr	r3, [r3, #12]
 8002b6e:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b72:	60da      	str	r2, [r3, #12]
  FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_SetupTime = 0xFC;
 8002b74:	687b      	ldr	r3, [r7, #4]
 8002b76:	691b      	ldr	r3, [r3, #16]
 8002b78:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b7c:	601a      	str	r2, [r3, #0]
  FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
 8002b7e:	687b      	ldr	r3, [r7, #4]
 8002b80:	691b      	ldr	r3, [r3, #16]
 8002b82:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b86:	605a      	str	r2, [r3, #4]
  FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
 8002b88:	687b      	ldr	r3, [r7, #4]
 8002b8a:	691b      	ldr	r3, [r3, #16]
 8002b8c:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b90:	609a      	str	r2, [r3, #8]
  FSMC_PCCARDInitStruct->FSMC_AttributeSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;	
 8002b92:	687b      	ldr	r3, [r7, #4]
 8002b94:	691b      	ldr	r3, [r3, #16]
 8002b96:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002b9a:	60da      	str	r2, [r3, #12]
  FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_SetupTime = 0xFC;
 8002b9c:	687b      	ldr	r3, [r7, #4]
 8002b9e:	695b      	ldr	r3, [r3, #20]
 8002ba0:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002ba4:	601a      	str	r2, [r3, #0]
  FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_WaitSetupTime = 0xFC;
 8002ba6:	687b      	ldr	r3, [r7, #4]
 8002ba8:	695b      	ldr	r3, [r3, #20]
 8002baa:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002bae:	605a      	str	r2, [r3, #4]
  FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HoldSetupTime = 0xFC;
 8002bb0:	687b      	ldr	r3, [r7, #4]
 8002bb2:	695b      	ldr	r3, [r3, #20]
 8002bb4:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002bb8:	609a      	str	r2, [r3, #8]
  FSMC_PCCARDInitStruct->FSMC_IOSpaceTimingStruct->FSMC_HiZSetupTime = 0xFC;
 8002bba:	687b      	ldr	r3, [r7, #4]
 8002bbc:	695b      	ldr	r3, [r3, #20]
 8002bbe:	f04f 02fc 	mov.w	r2, #252	; 0xfc
 8002bc2:	60da      	str	r2, [r3, #12]
}
 8002bc4:	f107 070c 	add.w	r7, r7, #12
 8002bc8:	46bd      	mov	sp, r7
 8002bca:	bc80      	pop	{r7}
 8002bcc:	4770      	bx	lr
 8002bce:	bf00      	nop

08002bd0 <FSMC_NORSRAMCmd>:
  *     @arg FSMC_Bank1_NORSRAM4: FSMC Bank1 NOR/SRAM4 
  * @param  NewState: new state of the FSMC_Bank. This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void FSMC_NORSRAMCmd(uint32_t FSMC_Bank, FunctionalState NewState)
{
 8002bd0:	b480      	push	{r7}
 8002bd2:	b083      	sub	sp, #12
 8002bd4:	af00      	add	r7, sp, #0
 8002bd6:	6078      	str	r0, [r7, #4]
 8002bd8:	460b      	mov	r3, r1
 8002bda:	70fb      	strb	r3, [r7, #3]
  assert_param(IS_FSMC_NORSRAM_BANK(FSMC_Bank));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 8002bdc:	78fb      	ldrb	r3, [r7, #3]
 8002bde:	2b00      	cmp	r3, #0
 8002be0:	d00c      	beq.n	8002bfc <FSMC_NORSRAMCmd+0x2c>
  {
    /* Enable the selected NOR/SRAM Bank by setting the PBKEN bit in the BCRx register */
    FSMC_Bank1->BTCR[FSMC_Bank] |= BCR_MBKEN_Set;
 8002be2:	f04f 4320 	mov.w	r3, #2684354560	; 0xa0000000
 8002be6:	f04f 4220 	mov.w	r2, #2684354560	; 0xa0000000
 8002bea:	6879      	ldr	r1, [r7, #4]
 8002bec:	f852 2021 	ldr.w	r2, [r2, r1, lsl #2]
 8002bf0:	f042 0101 	orr.w	r1, r2, #1
 8002bf4:	687a      	ldr	r2, [r7, #4]
 8002bf6:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
 8002bfa:	e00e      	b.n	8002c1a <FSMC_NORSRAMCmd+0x4a>
  }
  else
  {
    /* Disable the selected NOR/SRAM Bank by clearing the PBKEN bit in the BCRx register */
    FSMC_Bank1->BTCR[FSMC_Bank] &= BCR_MBKEN_Reset;
 8002bfc:	f04f 4220 	mov.w	r2, #2684354560	; 0xa0000000
 8002c00:	f04f 4320 	mov.w	r3, #2684354560	; 0xa0000000
 8002c04:	6879      	ldr	r1, [r7, #4]
 8002c06:	f853 1021 	ldr.w	r1, [r3, r1, lsl #2]
 8002c0a:	f64f 73fe 	movw	r3, #65534	; 0xfffe
 8002c0e:	f2c0 030f 	movt	r3, #15
 8002c12:	400b      	ands	r3, r1
 8002c14:	6879      	ldr	r1, [r7, #4]
 8002c16:	f842 3021 	str.w	r3, [r2, r1, lsl #2]
  }
}
 8002c1a:	f107 070c 	add.w	r7, r7, #12
 8002c1e:	46bd      	mov	sp, r7
 8002c20:	bc80      	pop	{r7}
 8002c22:	4770      	bx	lr

08002c24 <FSMC_NANDCmd>:
  *     @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
  * @param  NewState: new state of the FSMC_Bank. This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void FSMC_NANDCmd(uint32_t FSMC_Bank, FunctionalState NewState)
{
 8002c24:	b480      	push	{r7}
 8002c26:	b083      	sub	sp, #12
 8002c28:	af00      	add	r7, sp, #0
 8002c2a:	6078      	str	r0, [r7, #4]
 8002c2c:	460b      	mov	r3, r1
 8002c2e:	70fb      	strb	r3, [r7, #3]
  assert_param(IS_FSMC_NAND_BANK(FSMC_Bank));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 8002c30:	78fb      	ldrb	r3, [r7, #3]
 8002c32:	2b00      	cmp	r3, #0
 8002c34:	d01c      	beq.n	8002c70 <FSMC_NANDCmd+0x4c>
  {
    /* Enable the selected NAND Bank by setting the PBKEN bit in the PCRx register */
    if(FSMC_Bank == FSMC_Bank2_NAND)
 8002c36:	687b      	ldr	r3, [r7, #4]
 8002c38:	2b10      	cmp	r3, #16
 8002c3a:	d10c      	bne.n	8002c56 <FSMC_NANDCmd+0x32>
    {
      FSMC_Bank2->PCR2 |= PCR_PBKEN_Set;
 8002c3c:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002c40:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002c44:	f04f 0260 	mov.w	r2, #96	; 0x60
 8002c48:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002c4c:	6812      	ldr	r2, [r2, #0]
 8002c4e:	f042 0204 	orr.w	r2, r2, #4
 8002c52:	601a      	str	r2, [r3, #0]
 8002c54:	e02e      	b.n	8002cb4 <FSMC_NANDCmd+0x90>
    }
    else
    {
      FSMC_Bank3->PCR3 |= PCR_PBKEN_Set;
 8002c56:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002c5a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002c5e:	f04f 0280 	mov.w	r2, #128	; 0x80
 8002c62:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002c66:	6812      	ldr	r2, [r2, #0]
 8002c68:	f042 0204 	orr.w	r2, r2, #4
 8002c6c:	601a      	str	r2, [r3, #0]
 8002c6e:	e021      	b.n	8002cb4 <FSMC_NANDCmd+0x90>
    }
  }
  else
  {
    /* Disable the selected NAND Bank by clearing the PBKEN bit in the PCRx register */
    if(FSMC_Bank == FSMC_Bank2_NAND)
 8002c70:	687b      	ldr	r3, [r7, #4]
 8002c72:	2b10      	cmp	r3, #16
 8002c74:	d10f      	bne.n	8002c96 <FSMC_NANDCmd+0x72>
    {
      FSMC_Bank2->PCR2 &= PCR_PBKEN_Reset;
 8002c76:	f04f 0260 	mov.w	r2, #96	; 0x60
 8002c7a:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002c7e:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002c82:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002c86:	6819      	ldr	r1, [r3, #0]
 8002c88:	f64f 73fb 	movw	r3, #65531	; 0xfffb
 8002c8c:	f2c0 030f 	movt	r3, #15
 8002c90:	400b      	ands	r3, r1
 8002c92:	6013      	str	r3, [r2, #0]
 8002c94:	e00e      	b.n	8002cb4 <FSMC_NANDCmd+0x90>
    }
    else
    {
      FSMC_Bank3->PCR3 &= PCR_PBKEN_Reset;
 8002c96:	f04f 0280 	mov.w	r2, #128	; 0x80
 8002c9a:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002c9e:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002ca2:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002ca6:	6819      	ldr	r1, [r3, #0]
 8002ca8:	f64f 73fb 	movw	r3, #65531	; 0xfffb
 8002cac:	f2c0 030f 	movt	r3, #15
 8002cb0:	400b      	ands	r3, r1
 8002cb2:	6013      	str	r3, [r2, #0]
    }
  }
}
 8002cb4:	f107 070c 	add.w	r7, r7, #12
 8002cb8:	46bd      	mov	sp, r7
 8002cba:	bc80      	pop	{r7}
 8002cbc:	4770      	bx	lr
 8002cbe:	bf00      	nop

08002cc0 <FSMC_PCCARDCmd>:
  * @param  NewState: new state of the PCCARD Memory Bank.  
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void FSMC_PCCARDCmd(FunctionalState NewState)
{
 8002cc0:	b480      	push	{r7}
 8002cc2:	b083      	sub	sp, #12
 8002cc4:	af00      	add	r7, sp, #0
 8002cc6:	4603      	mov	r3, r0
 8002cc8:	71fb      	strb	r3, [r7, #7]
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 8002cca:	79fb      	ldrb	r3, [r7, #7]
 8002ccc:	2b00      	cmp	r3, #0
 8002cce:	d00c      	beq.n	8002cea <FSMC_PCCARDCmd+0x2a>
  {
    /* Enable the PCCARD Bank by setting the PBKEN bit in the PCR4 register */
    FSMC_Bank4->PCR4 |= PCR_PBKEN_Set;
 8002cd0:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 8002cd4:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002cd8:	f04f 02a0 	mov.w	r2, #160	; 0xa0
 8002cdc:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002ce0:	6812      	ldr	r2, [r2, #0]
 8002ce2:	f042 0204 	orr.w	r2, r2, #4
 8002ce6:	601a      	str	r2, [r3, #0]
 8002ce8:	e00e      	b.n	8002d08 <FSMC_PCCARDCmd+0x48>
  }
  else
  {
    /* Disable the PCCARD Bank by clearing the PBKEN bit in the PCR4 register */
    FSMC_Bank4->PCR4 &= PCR_PBKEN_Reset;
 8002cea:	f04f 02a0 	mov.w	r2, #160	; 0xa0
 8002cee:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002cf2:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 8002cf6:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002cfa:	6819      	ldr	r1, [r3, #0]
 8002cfc:	f64f 73fb 	movw	r3, #65531	; 0xfffb
 8002d00:	f2c0 030f 	movt	r3, #15
 8002d04:	400b      	ands	r3, r1
 8002d06:	6013      	str	r3, [r2, #0]
  }
}
 8002d08:	f107 070c 	add.w	r7, r7, #12
 8002d0c:	46bd      	mov	sp, r7
 8002d0e:	bc80      	pop	{r7}
 8002d10:	4770      	bx	lr
 8002d12:	bf00      	nop

08002d14 <FSMC_NANDECCCmd>:
  * @param  NewState: new state of the FSMC NAND ECC feature.  
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void FSMC_NANDECCCmd(uint32_t FSMC_Bank, FunctionalState NewState)
{
 8002d14:	b480      	push	{r7}
 8002d16:	b083      	sub	sp, #12
 8002d18:	af00      	add	r7, sp, #0
 8002d1a:	6078      	str	r0, [r7, #4]
 8002d1c:	460b      	mov	r3, r1
 8002d1e:	70fb      	strb	r3, [r7, #3]
  assert_param(IS_FSMC_NAND_BANK(FSMC_Bank));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 8002d20:	78fb      	ldrb	r3, [r7, #3]
 8002d22:	2b00      	cmp	r3, #0
 8002d24:	d01c      	beq.n	8002d60 <FSMC_NANDECCCmd+0x4c>
  {
    /* Enable the selected NAND Bank ECC function by setting the ECCEN bit in the PCRx register */
    if(FSMC_Bank == FSMC_Bank2_NAND)
 8002d26:	687b      	ldr	r3, [r7, #4]
 8002d28:	2b10      	cmp	r3, #16
 8002d2a:	d10c      	bne.n	8002d46 <FSMC_NANDECCCmd+0x32>
    {
      FSMC_Bank2->PCR2 |= PCR_ECCEN_Set;
 8002d2c:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002d30:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002d34:	f04f 0260 	mov.w	r2, #96	; 0x60
 8002d38:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002d3c:	6812      	ldr	r2, [r2, #0]
 8002d3e:	f042 0240 	orr.w	r2, r2, #64	; 0x40
 8002d42:	601a      	str	r2, [r3, #0]
 8002d44:	e02e      	b.n	8002da4 <FSMC_NANDECCCmd+0x90>
    }
    else
    {
      FSMC_Bank3->PCR3 |= PCR_ECCEN_Set;
 8002d46:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002d4a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002d4e:	f04f 0280 	mov.w	r2, #128	; 0x80
 8002d52:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002d56:	6812      	ldr	r2, [r2, #0]
 8002d58:	f042 0240 	orr.w	r2, r2, #64	; 0x40
 8002d5c:	601a      	str	r2, [r3, #0]
 8002d5e:	e021      	b.n	8002da4 <FSMC_NANDECCCmd+0x90>
    }
  }
  else
  {
    /* Disable the selected NAND Bank ECC function by clearing the ECCEN bit in the PCRx register */
    if(FSMC_Bank == FSMC_Bank2_NAND)
 8002d60:	687b      	ldr	r3, [r7, #4]
 8002d62:	2b10      	cmp	r3, #16
 8002d64:	d10f      	bne.n	8002d86 <FSMC_NANDECCCmd+0x72>
    {
      FSMC_Bank2->PCR2 &= PCR_ECCEN_Reset;
 8002d66:	f04f 0260 	mov.w	r2, #96	; 0x60
 8002d6a:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002d6e:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002d72:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002d76:	6819      	ldr	r1, [r3, #0]
 8002d78:	f64f 73bf 	movw	r3, #65471	; 0xffbf
 8002d7c:	f2c0 030f 	movt	r3, #15
 8002d80:	400b      	ands	r3, r1
 8002d82:	6013      	str	r3, [r2, #0]
 8002d84:	e00e      	b.n	8002da4 <FSMC_NANDECCCmd+0x90>
    }
    else
    {
      FSMC_Bank3->PCR3 &= PCR_ECCEN_Reset;
 8002d86:	f04f 0280 	mov.w	r2, #128	; 0x80
 8002d8a:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002d8e:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002d92:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002d96:	6819      	ldr	r1, [r3, #0]
 8002d98:	f64f 73bf 	movw	r3, #65471	; 0xffbf
 8002d9c:	f2c0 030f 	movt	r3, #15
 8002da0:	400b      	ands	r3, r1
 8002da2:	6013      	str	r3, [r2, #0]
    }
  }
}
 8002da4:	f107 070c 	add.w	r7, r7, #12
 8002da8:	46bd      	mov	sp, r7
 8002daa:	bc80      	pop	{r7}
 8002dac:	4770      	bx	lr
 8002dae:	bf00      	nop

08002db0 <FSMC_GetECC>:
  *     @arg FSMC_Bank2_NAND: FSMC Bank2 NAND 
  *     @arg FSMC_Bank3_NAND: FSMC Bank3 NAND
  * @retval The Error Correction Code (ECC) value.
  */
uint32_t FSMC_GetECC(uint32_t FSMC_Bank)
{
 8002db0:	b480      	push	{r7}
 8002db2:	b085      	sub	sp, #20
 8002db4:	af00      	add	r7, sp, #0
 8002db6:	6078      	str	r0, [r7, #4]
  uint32_t eccval = 0x00000000;
 8002db8:	f04f 0300 	mov.w	r3, #0
 8002dbc:	60fb      	str	r3, [r7, #12]
  
  if(FSMC_Bank == FSMC_Bank2_NAND)
 8002dbe:	687b      	ldr	r3, [r7, #4]
 8002dc0:	2b10      	cmp	r3, #16
 8002dc2:	d106      	bne.n	8002dd2 <FSMC_GetECC+0x22>
  {
    /* Get the ECCR2 register value */
    eccval = FSMC_Bank2->ECCR2;
 8002dc4:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002dc8:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002dcc:	695b      	ldr	r3, [r3, #20]
 8002dce:	60fb      	str	r3, [r7, #12]
 8002dd0:	e005      	b.n	8002dde <FSMC_GetECC+0x2e>
  }
  else
  {
    /* Get the ECCR3 register value */
    eccval = FSMC_Bank3->ECCR3;
 8002dd2:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002dd6:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002dda:	695b      	ldr	r3, [r3, #20]
 8002ddc:	60fb      	str	r3, [r7, #12]
  }
  /* Return the error correction code value */
  return(eccval);
 8002dde:	68fb      	ldr	r3, [r7, #12]
}
 8002de0:	4618      	mov	r0, r3
 8002de2:	f107 0714 	add.w	r7, r7, #20
 8002de6:	46bd      	mov	sp, r7
 8002de8:	bc80      	pop	{r7}
 8002dea:	4770      	bx	lr

08002dec <FSMC_ITConfig>:
  * @param  NewState: new state of the specified FSMC interrupts.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void FSMC_ITConfig(uint32_t FSMC_Bank, uint32_t FSMC_IT, FunctionalState NewState)
{
 8002dec:	b480      	push	{r7}
 8002dee:	b085      	sub	sp, #20
 8002df0:	af00      	add	r7, sp, #0
 8002df2:	60f8      	str	r0, [r7, #12]
 8002df4:	60b9      	str	r1, [r7, #8]
 8002df6:	4613      	mov	r3, r2
 8002df8:	71fb      	strb	r3, [r7, #7]
  assert_param(IS_FSMC_IT_BANK(FSMC_Bank));
  assert_param(IS_FSMC_IT(FSMC_IT));	
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 8002dfa:	79fb      	ldrb	r3, [r7, #7]
 8002dfc:	2b00      	cmp	r3, #0
 8002dfe:	d02d      	beq.n	8002e5c <FSMC_ITConfig+0x70>
  {
    /* Enable the selected FSMC_Bank2 interrupts */
    if(FSMC_Bank == FSMC_Bank2_NAND)
 8002e00:	68fb      	ldr	r3, [r7, #12]
 8002e02:	2b10      	cmp	r3, #16
 8002e04:	d10c      	bne.n	8002e20 <FSMC_ITConfig+0x34>
    {
      FSMC_Bank2->SR2 |= FSMC_IT;
 8002e06:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002e0a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002e0e:	f04f 0260 	mov.w	r2, #96	; 0x60
 8002e12:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002e16:	6851      	ldr	r1, [r2, #4]
 8002e18:	68ba      	ldr	r2, [r7, #8]
 8002e1a:	430a      	orrs	r2, r1
 8002e1c:	605a      	str	r2, [r3, #4]
 8002e1e:	e050      	b.n	8002ec2 <FSMC_ITConfig+0xd6>
    }
    /* Enable the selected FSMC_Bank3 interrupts */
    else if (FSMC_Bank == FSMC_Bank3_NAND)
 8002e20:	68fb      	ldr	r3, [r7, #12]
 8002e22:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
 8002e26:	d10c      	bne.n	8002e42 <FSMC_ITConfig+0x56>
    {
      FSMC_Bank3->SR3 |= FSMC_IT;
 8002e28:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002e2c:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002e30:	f04f 0280 	mov.w	r2, #128	; 0x80
 8002e34:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002e38:	6851      	ldr	r1, [r2, #4]
 8002e3a:	68ba      	ldr	r2, [r7, #8]
 8002e3c:	430a      	orrs	r2, r1
 8002e3e:	605a      	str	r2, [r3, #4]
 8002e40:	e03f      	b.n	8002ec2 <FSMC_ITConfig+0xd6>
    }
    /* Enable the selected FSMC_Bank4 interrupts */
    else
    {
      FSMC_Bank4->SR4 |= FSMC_IT;    
 8002e42:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 8002e46:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002e4a:	f04f 02a0 	mov.w	r2, #160	; 0xa0
 8002e4e:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002e52:	6851      	ldr	r1, [r2, #4]
 8002e54:	68ba      	ldr	r2, [r7, #8]
 8002e56:	430a      	orrs	r2, r1
 8002e58:	605a      	str	r2, [r3, #4]
 8002e5a:	e032      	b.n	8002ec2 <FSMC_ITConfig+0xd6>
    }
  }
  else
  {
    /* Disable the selected FSMC_Bank2 interrupts */
    if(FSMC_Bank == FSMC_Bank2_NAND)
 8002e5c:	68fb      	ldr	r3, [r7, #12]
 8002e5e:	2b10      	cmp	r3, #16
 8002e60:	d10e      	bne.n	8002e80 <FSMC_ITConfig+0x94>
    {
      
      FSMC_Bank2->SR2 &= (uint32_t)~FSMC_IT;
 8002e62:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002e66:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002e6a:	f04f 0260 	mov.w	r2, #96	; 0x60
 8002e6e:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002e72:	6851      	ldr	r1, [r2, #4]
 8002e74:	68ba      	ldr	r2, [r7, #8]
 8002e76:	ea6f 0202 	mvn.w	r2, r2
 8002e7a:	400a      	ands	r2, r1
 8002e7c:	605a      	str	r2, [r3, #4]
 8002e7e:	e020      	b.n	8002ec2 <FSMC_ITConfig+0xd6>
    }
    /* Disable the selected FSMC_Bank3 interrupts */
    else if (FSMC_Bank == FSMC_Bank3_NAND)
 8002e80:	68fb      	ldr	r3, [r7, #12]
 8002e82:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
 8002e86:	d10e      	bne.n	8002ea6 <FSMC_ITConfig+0xba>
    {
      FSMC_Bank3->SR3 &= (uint32_t)~FSMC_IT;
 8002e88:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002e8c:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002e90:	f04f 0280 	mov.w	r2, #128	; 0x80
 8002e94:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002e98:	6851      	ldr	r1, [r2, #4]
 8002e9a:	68ba      	ldr	r2, [r7, #8]
 8002e9c:	ea6f 0202 	mvn.w	r2, r2
 8002ea0:	400a      	ands	r2, r1
 8002ea2:	605a      	str	r2, [r3, #4]
 8002ea4:	e00d      	b.n	8002ec2 <FSMC_ITConfig+0xd6>
    }
    /* Disable the selected FSMC_Bank4 interrupts */
    else
    {
      FSMC_Bank4->SR4 &= (uint32_t)~FSMC_IT;    
 8002ea6:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 8002eaa:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002eae:	f04f 02a0 	mov.w	r2, #160	; 0xa0
 8002eb2:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002eb6:	6851      	ldr	r1, [r2, #4]
 8002eb8:	68ba      	ldr	r2, [r7, #8]
 8002eba:	ea6f 0202 	mvn.w	r2, r2
 8002ebe:	400a      	ands	r2, r1
 8002ec0:	605a      	str	r2, [r3, #4]
    }
  }
}
 8002ec2:	f107 0714 	add.w	r7, r7, #20
 8002ec6:	46bd      	mov	sp, r7
 8002ec8:	bc80      	pop	{r7}
 8002eca:	4770      	bx	lr

08002ecc <FSMC_GetFlagStatus>:
  *     @arg FSMC_FLAG_FallingEdge: Falling egde detection Flag.
  *     @arg FSMC_FLAG_FEMPT: Fifo empty Flag. 
  * @retval The new state of FSMC_FLAG (SET or RESET).
  */
FlagStatus FSMC_GetFlagStatus(uint32_t FSMC_Bank, uint32_t FSMC_FLAG)
{
 8002ecc:	b480      	push	{r7}
 8002ece:	b085      	sub	sp, #20
 8002ed0:	af00      	add	r7, sp, #0
 8002ed2:	6078      	str	r0, [r7, #4]
 8002ed4:	6039      	str	r1, [r7, #0]
  FlagStatus bitstatus = RESET;
 8002ed6:	f04f 0300 	mov.w	r3, #0
 8002eda:	73fb      	strb	r3, [r7, #15]
  uint32_t tmpsr = 0x00000000;
 8002edc:	f04f 0300 	mov.w	r3, #0
 8002ee0:	60bb      	str	r3, [r7, #8]
  
  /* Check the parameters */
  assert_param(IS_FSMC_GETFLAG_BANK(FSMC_Bank));
  assert_param(IS_FSMC_GET_FLAG(FSMC_FLAG));
  
  if(FSMC_Bank == FSMC_Bank2_NAND)
 8002ee2:	687b      	ldr	r3, [r7, #4]
 8002ee4:	2b10      	cmp	r3, #16
 8002ee6:	d106      	bne.n	8002ef6 <FSMC_GetFlagStatus+0x2a>
  {
    tmpsr = FSMC_Bank2->SR2;
 8002ee8:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002eec:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002ef0:	685b      	ldr	r3, [r3, #4]
 8002ef2:	60bb      	str	r3, [r7, #8]
 8002ef4:	e010      	b.n	8002f18 <FSMC_GetFlagStatus+0x4c>
  }  
  else if(FSMC_Bank == FSMC_Bank3_NAND)
 8002ef6:	687b      	ldr	r3, [r7, #4]
 8002ef8:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
 8002efc:	d106      	bne.n	8002f0c <FSMC_GetFlagStatus+0x40>
  {
    tmpsr = FSMC_Bank3->SR3;
 8002efe:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002f02:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002f06:	685b      	ldr	r3, [r3, #4]
 8002f08:	60bb      	str	r3, [r7, #8]
 8002f0a:	e005      	b.n	8002f18 <FSMC_GetFlagStatus+0x4c>
  }
  /* FSMC_Bank4_PCCARD*/
  else
  {
    tmpsr = FSMC_Bank4->SR4;
 8002f0c:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 8002f10:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002f14:	685b      	ldr	r3, [r3, #4]
 8002f16:	60bb      	str	r3, [r7, #8]
  } 
  
  /* Get the flag status */
  if ((tmpsr & FSMC_FLAG) != (uint16_t)RESET )
 8002f18:	68ba      	ldr	r2, [r7, #8]
 8002f1a:	683b      	ldr	r3, [r7, #0]
 8002f1c:	4013      	ands	r3, r2
 8002f1e:	2b00      	cmp	r3, #0
 8002f20:	d003      	beq.n	8002f2a <FSMC_GetFlagStatus+0x5e>
  {
    bitstatus = SET;
 8002f22:	f04f 0301 	mov.w	r3, #1
 8002f26:	73fb      	strb	r3, [r7, #15]
 8002f28:	e002      	b.n	8002f30 <FSMC_GetFlagStatus+0x64>
  }
  else
  {
    bitstatus = RESET;
 8002f2a:	f04f 0300 	mov.w	r3, #0
 8002f2e:	73fb      	strb	r3, [r7, #15]
  }
  /* Return the flag status */
  return bitstatus;
 8002f30:	7bfb      	ldrb	r3, [r7, #15]
}
 8002f32:	4618      	mov	r0, r3
 8002f34:	f107 0714 	add.w	r7, r7, #20
 8002f38:	46bd      	mov	sp, r7
 8002f3a:	bc80      	pop	{r7}
 8002f3c:	4770      	bx	lr
 8002f3e:	bf00      	nop

08002f40 <FSMC_ClearFlag>:
  *     @arg FSMC_FLAG_Level: Level detection Flag.
  *     @arg FSMC_FLAG_FallingEdge: Falling egde detection Flag.
  * @retval None
  */
void FSMC_ClearFlag(uint32_t FSMC_Bank, uint32_t FSMC_FLAG)
{
 8002f40:	b480      	push	{r7}
 8002f42:	b083      	sub	sp, #12
 8002f44:	af00      	add	r7, sp, #0
 8002f46:	6078      	str	r0, [r7, #4]
 8002f48:	6039      	str	r1, [r7, #0]
 /* Check the parameters */
  assert_param(IS_FSMC_GETFLAG_BANK(FSMC_Bank));
  assert_param(IS_FSMC_CLEAR_FLAG(FSMC_FLAG)) ;
    
  if(FSMC_Bank == FSMC_Bank2_NAND)
 8002f4a:	687b      	ldr	r3, [r7, #4]
 8002f4c:	2b10      	cmp	r3, #16
 8002f4e:	d10e      	bne.n	8002f6e <FSMC_ClearFlag+0x2e>
  {
    FSMC_Bank2->SR2 &= ~FSMC_FLAG; 
 8002f50:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002f54:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002f58:	f04f 0260 	mov.w	r2, #96	; 0x60
 8002f5c:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002f60:	6851      	ldr	r1, [r2, #4]
 8002f62:	683a      	ldr	r2, [r7, #0]
 8002f64:	ea6f 0202 	mvn.w	r2, r2
 8002f68:	400a      	ands	r2, r1
 8002f6a:	605a      	str	r2, [r3, #4]
 8002f6c:	e020      	b.n	8002fb0 <FSMC_ClearFlag+0x70>
  }  
  else if(FSMC_Bank == FSMC_Bank3_NAND)
 8002f6e:	687b      	ldr	r3, [r7, #4]
 8002f70:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
 8002f74:	d10e      	bne.n	8002f94 <FSMC_ClearFlag+0x54>
  {
    FSMC_Bank3->SR3 &= ~FSMC_FLAG;
 8002f76:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002f7a:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002f7e:	f04f 0280 	mov.w	r2, #128	; 0x80
 8002f82:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002f86:	6851      	ldr	r1, [r2, #4]
 8002f88:	683a      	ldr	r2, [r7, #0]
 8002f8a:	ea6f 0202 	mvn.w	r2, r2
 8002f8e:	400a      	ands	r2, r1
 8002f90:	605a      	str	r2, [r3, #4]
 8002f92:	e00d      	b.n	8002fb0 <FSMC_ClearFlag+0x70>
  }
  /* FSMC_Bank4_PCCARD*/
  else
  {
    FSMC_Bank4->SR4 &= ~FSMC_FLAG;
 8002f94:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 8002f98:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002f9c:	f04f 02a0 	mov.w	r2, #160	; 0xa0
 8002fa0:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8002fa4:	6851      	ldr	r1, [r2, #4]
 8002fa6:	683a      	ldr	r2, [r7, #0]
 8002fa8:	ea6f 0202 	mvn.w	r2, r2
 8002fac:	400a      	ands	r2, r1
 8002fae:	605a      	str	r2, [r3, #4]
  }
}
 8002fb0:	f107 070c 	add.w	r7, r7, #12
 8002fb4:	46bd      	mov	sp, r7
 8002fb6:	bc80      	pop	{r7}
 8002fb8:	4770      	bx	lr
 8002fba:	bf00      	nop

08002fbc <FSMC_GetITStatus>:
  *     @arg FSMC_IT_Level: Level edge detection interrupt.
  *     @arg FSMC_IT_FallingEdge: Falling edge detection interrupt. 
  * @retval The new state of FSMC_IT (SET or RESET).
  */
ITStatus FSMC_GetITStatus(uint32_t FSMC_Bank, uint32_t FSMC_IT)
{
 8002fbc:	b480      	push	{r7}
 8002fbe:	b087      	sub	sp, #28
 8002fc0:	af00      	add	r7, sp, #0
 8002fc2:	6078      	str	r0, [r7, #4]
 8002fc4:	6039      	str	r1, [r7, #0]
  ITStatus bitstatus = RESET;
 8002fc6:	f04f 0300 	mov.w	r3, #0
 8002fca:	75fb      	strb	r3, [r7, #23]
  uint32_t tmpsr = 0x0, itstatus = 0x0, itenable = 0x0; 
 8002fcc:	f04f 0300 	mov.w	r3, #0
 8002fd0:	613b      	str	r3, [r7, #16]
 8002fd2:	f04f 0300 	mov.w	r3, #0
 8002fd6:	60fb      	str	r3, [r7, #12]
 8002fd8:	f04f 0300 	mov.w	r3, #0
 8002fdc:	60bb      	str	r3, [r7, #8]
  
  /* Check the parameters */
  assert_param(IS_FSMC_IT_BANK(FSMC_Bank));
  assert_param(IS_FSMC_GET_IT(FSMC_IT));
  
  if(FSMC_Bank == FSMC_Bank2_NAND)
 8002fde:	687b      	ldr	r3, [r7, #4]
 8002fe0:	2b10      	cmp	r3, #16
 8002fe2:	d106      	bne.n	8002ff2 <FSMC_GetITStatus+0x36>
  {
    tmpsr = FSMC_Bank2->SR2;
 8002fe4:	f04f 0360 	mov.w	r3, #96	; 0x60
 8002fe8:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8002fec:	685b      	ldr	r3, [r3, #4]
 8002fee:	613b      	str	r3, [r7, #16]
 8002ff0:	e010      	b.n	8003014 <FSMC_GetITStatus+0x58>
  }  
  else if(FSMC_Bank == FSMC_Bank3_NAND)
 8002ff2:	687b      	ldr	r3, [r7, #4]
 8002ff4:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
 8002ff8:	d106      	bne.n	8003008 <FSMC_GetITStatus+0x4c>
  {
    tmpsr = FSMC_Bank3->SR3;
 8002ffa:	f04f 0380 	mov.w	r3, #128	; 0x80
 8002ffe:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8003002:	685b      	ldr	r3, [r3, #4]
 8003004:	613b      	str	r3, [r7, #16]
 8003006:	e005      	b.n	8003014 <FSMC_GetITStatus+0x58>
  }
  /* FSMC_Bank4_PCCARD*/
  else
  {
    tmpsr = FSMC_Bank4->SR4;
 8003008:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 800300c:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8003010:	685b      	ldr	r3, [r3, #4]
 8003012:	613b      	str	r3, [r7, #16]
  } 
  
  itstatus = tmpsr & FSMC_IT;
 8003014:	693a      	ldr	r2, [r7, #16]
 8003016:	683b      	ldr	r3, [r7, #0]
 8003018:	4013      	ands	r3, r2
 800301a:	60fb      	str	r3, [r7, #12]
  
  itenable = tmpsr & (FSMC_IT >> 3);
 800301c:	683b      	ldr	r3, [r7, #0]
 800301e:	ea4f 02d3 	mov.w	r2, r3, lsr #3
 8003022:	693b      	ldr	r3, [r7, #16]
 8003024:	4013      	ands	r3, r2
 8003026:	60bb      	str	r3, [r7, #8]
  if ((itstatus != (uint32_t)RESET)  && (itenable != (uint32_t)RESET))
 8003028:	68fb      	ldr	r3, [r7, #12]
 800302a:	2b00      	cmp	r3, #0
 800302c:	d006      	beq.n	800303c <FSMC_GetITStatus+0x80>
 800302e:	68bb      	ldr	r3, [r7, #8]
 8003030:	2b00      	cmp	r3, #0
 8003032:	d003      	beq.n	800303c <FSMC_GetITStatus+0x80>
  {
    bitstatus = SET;
 8003034:	f04f 0301 	mov.w	r3, #1
 8003038:	75fb      	strb	r3, [r7, #23]
 800303a:	e002      	b.n	8003042 <FSMC_GetITStatus+0x86>
  }
  else
  {
    bitstatus = RESET;
 800303c:	f04f 0300 	mov.w	r3, #0
 8003040:	75fb      	strb	r3, [r7, #23]
  }
  return bitstatus; 
 8003042:	7dfb      	ldrb	r3, [r7, #23]
}
 8003044:	4618      	mov	r0, r3
 8003046:	f107 071c 	add.w	r7, r7, #28
 800304a:	46bd      	mov	sp, r7
 800304c:	bc80      	pop	{r7}
 800304e:	4770      	bx	lr

08003050 <FSMC_ClearITPendingBit>:
  *     @arg FSMC_IT_Level: Level edge detection interrupt.
  *     @arg FSMC_IT_FallingEdge: Falling edge detection interrupt.
  * @retval None
  */
void FSMC_ClearITPendingBit(uint32_t FSMC_Bank, uint32_t FSMC_IT)
{
 8003050:	b480      	push	{r7}
 8003052:	b083      	sub	sp, #12
 8003054:	af00      	add	r7, sp, #0
 8003056:	6078      	str	r0, [r7, #4]
 8003058:	6039      	str	r1, [r7, #0]
  /* Check the parameters */
  assert_param(IS_FSMC_IT_BANK(FSMC_Bank));
  assert_param(IS_FSMC_IT(FSMC_IT));
    
  if(FSMC_Bank == FSMC_Bank2_NAND)
 800305a:	687b      	ldr	r3, [r7, #4]
 800305c:	2b10      	cmp	r3, #16
 800305e:	d110      	bne.n	8003082 <FSMC_ClearITPendingBit+0x32>
  {
    FSMC_Bank2->SR2 &= ~(FSMC_IT >> 3); 
 8003060:	f04f 0360 	mov.w	r3, #96	; 0x60
 8003064:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8003068:	f04f 0260 	mov.w	r2, #96	; 0x60
 800306c:	f2ca 0200 	movt	r2, #40960	; 0xa000
 8003070:	6851      	ldr	r1, [r2, #4]
 8003072:	683a      	ldr	r2, [r7, #0]
 8003074:	ea4f 02d2 	mov.w	r2, r2, lsr #3
 8003078:	ea6f 0202 	mvn.w	r2, r2
 800307c:	400a      	ands	r2, r1
 800307e:	605a      	str	r2, [r3, #4]
 8003080:	e024      	b.n	80030cc <FSMC_ClearITPendingBit+0x7c>
  }  
  else if(FSMC_Bank == FSMC_Bank3_NAND)
 8003082:	687b      	ldr	r3, [r7, #4]
 8003084:	f5b3 7f80 	cmp.w	r3, #256	; 0x100
 8003088:	d110      	bne.n	80030ac <FSMC_ClearITPendingBit+0x5c>
  {
    FSMC_Bank3->SR3 &= ~(FSMC_IT >> 3);
 800308a:	f04f 0380 	mov.w	r3, #128	; 0x80
 800308e:	f2ca 0300 	movt	r3, #40960	; 0xa000
 8003092:	f04f 0280 	mov.w	r2, #128	; 0x80
 8003096:	f2ca 0200 	movt	r2, #40960	; 0xa000
 800309a:	6851      	ldr	r1, [r2, #4]
 800309c:	683a      	ldr	r2, [r7, #0]
 800309e:	ea4f 02d2 	mov.w	r2, r2, lsr #3
 80030a2:	ea6f 0202 	mvn.w	r2, r2
 80030a6:	400a      	ands	r2, r1
 80030a8:	605a      	str	r2, [r3, #4]
 80030aa:	e00f      	b.n	80030cc <FSMC_ClearITPendingBit+0x7c>
  }
  /* FSMC_Bank4_PCCARD*/
  else
  {
    FSMC_Bank4->SR4 &= ~(FSMC_IT >> 3);
 80030ac:	f04f 03a0 	mov.w	r3, #160	; 0xa0
 80030b0:	f2ca 0300 	movt	r3, #40960	; 0xa000
 80030b4:	f04f 02a0 	mov.w	r2, #160	; 0xa0
 80030b8:	f2ca 0200 	movt	r2, #40960	; 0xa000
 80030bc:	6851      	ldr	r1, [r2, #4]
 80030be:	683a      	ldr	r2, [r7, #0]
 80030c0:	ea4f 02d2 	mov.w	r2, r2, lsr #3
 80030c4:	ea6f 0202 	mvn.w	r2, r2
 80030c8:	400a      	ands	r2, r1
 80030ca:	605a      	str	r2, [r3, #4]
  }
}
 80030cc:	f107 070c 	add.w	r7, r7, #12
 80030d0:	46bd      	mov	sp, r7
 80030d2:	bc80      	pop	{r7}
 80030d4:	4770      	bx	lr
 80030d6:	bf00      	nop

080030d8 <GPIO_DeInit>:
  * @brief  Deinitializes the GPIOx peripheral registers to their default reset values.
  * @param  GPIOx: where x can be (A..G) to select the GPIO peripheral.
  * @retval None
  */
void GPIO_DeInit(GPIO_TypeDef* GPIOx)
{
 80030d8:	b580      	push	{r7, lr}
 80030da:	b082      	sub	sp, #8
 80030dc:	af00      	add	r7, sp, #0
 80030de:	6078      	str	r0, [r7, #4]
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  
  if (GPIOx == GPIOA)
 80030e0:	687a      	ldr	r2, [r7, #4]
 80030e2:	f44f 6300 	mov.w	r3, #2048	; 0x800
 80030e6:	f2c4 0301 	movt	r3, #16385	; 0x4001
 80030ea:	429a      	cmp	r2, r3
 80030ec:	d10c      	bne.n	8003108 <GPIO_DeInit+0x30>
  {
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOA, ENABLE);
 80030ee:	f04f 0004 	mov.w	r0, #4
 80030f2:	f04f 0101 	mov.w	r1, #1
 80030f6:	f000 ff5b 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOA, DISABLE);
 80030fa:	f04f 0004 	mov.w	r0, #4
 80030fe:	f04f 0100 	mov.w	r1, #0
 8003102:	f000 ff55 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
 8003106:	e076      	b.n	80031f6 <GPIO_DeInit+0x11e>
  }
  else if (GPIOx == GPIOB)
 8003108:	687a      	ldr	r2, [r7, #4]
 800310a:	f44f 6340 	mov.w	r3, #3072	; 0xc00
 800310e:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8003112:	429a      	cmp	r2, r3
 8003114:	d10c      	bne.n	8003130 <GPIO_DeInit+0x58>
  {
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOB, ENABLE);
 8003116:	f04f 0008 	mov.w	r0, #8
 800311a:	f04f 0101 	mov.w	r1, #1
 800311e:	f000 ff47 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOB, DISABLE);
 8003122:	f04f 0008 	mov.w	r0, #8
 8003126:	f04f 0100 	mov.w	r1, #0
 800312a:	f000 ff41 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
 800312e:	e062      	b.n	80031f6 <GPIO_DeInit+0x11e>
  }
  else if (GPIOx == GPIOC)
 8003130:	687a      	ldr	r2, [r7, #4]
 8003132:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003136:	f2c4 0301 	movt	r3, #16385	; 0x4001
 800313a:	429a      	cmp	r2, r3
 800313c:	d10c      	bne.n	8003158 <GPIO_DeInit+0x80>
  {
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOC, ENABLE);
 800313e:	f04f 0010 	mov.w	r0, #16
 8003142:	f04f 0101 	mov.w	r1, #1
 8003146:	f000 ff33 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOC, DISABLE);
 800314a:	f04f 0010 	mov.w	r0, #16
 800314e:	f04f 0100 	mov.w	r1, #0
 8003152:	f000 ff2d 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
 8003156:	e04e      	b.n	80031f6 <GPIO_DeInit+0x11e>
  }
  else if (GPIOx == GPIOD)
 8003158:	687a      	ldr	r2, [r7, #4]
 800315a:	f44f 53a0 	mov.w	r3, #5120	; 0x1400
 800315e:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8003162:	429a      	cmp	r2, r3
 8003164:	d10c      	bne.n	8003180 <GPIO_DeInit+0xa8>
  {
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOD, ENABLE);
 8003166:	f04f 0020 	mov.w	r0, #32
 800316a:	f04f 0101 	mov.w	r1, #1
 800316e:	f000 ff1f 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOD, DISABLE);
 8003172:	f04f 0020 	mov.w	r0, #32
 8003176:	f04f 0100 	mov.w	r1, #0
 800317a:	f000 ff19 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
 800317e:	e03a      	b.n	80031f6 <GPIO_DeInit+0x11e>
  }    
  else if (GPIOx == GPIOE)
 8003180:	687a      	ldr	r2, [r7, #4]
 8003182:	f44f 53c0 	mov.w	r3, #6144	; 0x1800
 8003186:	f2c4 0301 	movt	r3, #16385	; 0x4001
 800318a:	429a      	cmp	r2, r3
 800318c:	d10c      	bne.n	80031a8 <GPIO_DeInit+0xd0>
  {
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOE, ENABLE);
 800318e:	f04f 0040 	mov.w	r0, #64	; 0x40
 8003192:	f04f 0101 	mov.w	r1, #1
 8003196:	f000 ff0b 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOE, DISABLE);
 800319a:	f04f 0040 	mov.w	r0, #64	; 0x40
 800319e:	f04f 0100 	mov.w	r1, #0
 80031a2:	f000 ff05 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
 80031a6:	e026      	b.n	80031f6 <GPIO_DeInit+0x11e>
  } 
  else if (GPIOx == GPIOF)
 80031a8:	687a      	ldr	r2, [r7, #4]
 80031aa:	f44f 53e0 	mov.w	r3, #7168	; 0x1c00
 80031ae:	f2c4 0301 	movt	r3, #16385	; 0x4001
 80031b2:	429a      	cmp	r2, r3
 80031b4:	d10c      	bne.n	80031d0 <GPIO_DeInit+0xf8>
  {
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOF, ENABLE);
 80031b6:	f04f 0080 	mov.w	r0, #128	; 0x80
 80031ba:	f04f 0101 	mov.w	r1, #1
 80031be:	f000 fef7 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOF, DISABLE);
 80031c2:	f04f 0080 	mov.w	r0, #128	; 0x80
 80031c6:	f04f 0100 	mov.w	r1, #0
 80031ca:	f000 fef1 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
 80031ce:	e012      	b.n	80031f6 <GPIO_DeInit+0x11e>
  }
  else
  {
    if (GPIOx == GPIOG)
 80031d0:	687a      	ldr	r2, [r7, #4]
 80031d2:	f44f 5300 	mov.w	r3, #8192	; 0x2000
 80031d6:	f2c4 0301 	movt	r3, #16385	; 0x4001
 80031da:	429a      	cmp	r2, r3
 80031dc:	d10b      	bne.n	80031f6 <GPIO_DeInit+0x11e>
    {
      RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOG, ENABLE);
 80031de:	f44f 7080 	mov.w	r0, #256	; 0x100
 80031e2:	f04f 0101 	mov.w	r1, #1
 80031e6:	f000 fee3 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
      RCC_APB2PeriphResetCmd(RCC_APB2Periph_GPIOG, DISABLE);
 80031ea:	f44f 7080 	mov.w	r0, #256	; 0x100
 80031ee:	f04f 0100 	mov.w	r1, #0
 80031f2:	f000 fedd 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
    }
  }
}
 80031f6:	f107 0708 	add.w	r7, r7, #8
 80031fa:	46bd      	mov	sp, r7
 80031fc:	bd80      	pop	{r7, pc}
 80031fe:	bf00      	nop

08003200 <GPIO_AFIODeInit>:
  *   and EXTI configuration) registers to their default reset values.
  * @param  None
  * @retval None
  */
void GPIO_AFIODeInit(void)
{
 8003200:	b580      	push	{r7, lr}
 8003202:	af00      	add	r7, sp, #0
  RCC_APB2PeriphResetCmd(RCC_APB2Periph_AFIO, ENABLE);
 8003204:	f04f 0001 	mov.w	r0, #1
 8003208:	f04f 0101 	mov.w	r1, #1
 800320c:	f000 fed0 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
  RCC_APB2PeriphResetCmd(RCC_APB2Periph_AFIO, DISABLE);
 8003210:	f04f 0001 	mov.w	r0, #1
 8003214:	f04f 0100 	mov.w	r1, #0
 8003218:	f000 feca 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
}
 800321c:	bd80      	pop	{r7, pc}
 800321e:	bf00      	nop

08003220 <GPIO_Init>:
  * @param  GPIO_InitStruct: pointer to a GPIO_InitTypeDef structure that
  *         contains the configuration information for the specified GPIO peripheral.
  * @retval None
  */
void GPIO_Init(GPIO_TypeDef* GPIOx, GPIO_InitTypeDef* GPIO_InitStruct)
{
 8003220:	b480      	push	{r7}
 8003222:	b089      	sub	sp, #36	; 0x24
 8003224:	af00      	add	r7, sp, #0
 8003226:	6078      	str	r0, [r7, #4]
 8003228:	6039      	str	r1, [r7, #0]
  uint32_t currentmode = 0x00, currentpin = 0x00, pinpos = 0x00, pos = 0x00;
 800322a:	f04f 0300 	mov.w	r3, #0
 800322e:	61fb      	str	r3, [r7, #28]
 8003230:	f04f 0300 	mov.w	r3, #0
 8003234:	613b      	str	r3, [r7, #16]
 8003236:	f04f 0300 	mov.w	r3, #0
 800323a:	61bb      	str	r3, [r7, #24]
 800323c:	f04f 0300 	mov.w	r3, #0
 8003240:	60fb      	str	r3, [r7, #12]
  uint32_t tmpreg = 0x00, pinmask = 0x00;
 8003242:	f04f 0300 	mov.w	r3, #0
 8003246:	617b      	str	r3, [r7, #20]
 8003248:	f04f 0300 	mov.w	r3, #0
 800324c:	60bb      	str	r3, [r7, #8]
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  assert_param(IS_GPIO_MODE(GPIO_InitStruct->GPIO_Mode));
  assert_param(IS_GPIO_PIN(GPIO_InitStruct->GPIO_Pin));  
  
/*---------------------------- GPIO Mode Configuration -----------------------*/
  currentmode = ((uint32_t)GPIO_InitStruct->GPIO_Mode) & ((uint32_t)0x0F);
 800324e:	683b      	ldr	r3, [r7, #0]
 8003250:	78db      	ldrb	r3, [r3, #3]
 8003252:	f003 030f 	and.w	r3, r3, #15
 8003256:	61fb      	str	r3, [r7, #28]
  if ((((uint32_t)GPIO_InitStruct->GPIO_Mode) & ((uint32_t)0x10)) != 0x00)
 8003258:	683b      	ldr	r3, [r7, #0]
 800325a:	78db      	ldrb	r3, [r3, #3]
 800325c:	f003 0310 	and.w	r3, r3, #16
 8003260:	2b00      	cmp	r3, #0
 8003262:	d004      	beq.n	800326e <GPIO_Init+0x4e>
  { 
    /* Check the parameters */
    assert_param(IS_GPIO_SPEED(GPIO_InitStruct->GPIO_Speed));
    /* Output mode */
    currentmode |= (uint32_t)GPIO_InitStruct->GPIO_Speed;
 8003264:	683b      	ldr	r3, [r7, #0]
 8003266:	789b      	ldrb	r3, [r3, #2]
 8003268:	69fa      	ldr	r2, [r7, #28]
 800326a:	4313      	orrs	r3, r2
 800326c:	61fb      	str	r3, [r7, #28]
  }
/*---------------------------- GPIO CRL Configuration ------------------------*/
  /* Configure the eight low port pins */
  if (((uint32_t)GPIO_InitStruct->GPIO_Pin & ((uint32_t)0x00FF)) != 0x00)
 800326e:	683b      	ldr	r3, [r7, #0]
 8003270:	881b      	ldrh	r3, [r3, #0]
 8003272:	b2db      	uxtb	r3, r3
 8003274:	2b00      	cmp	r3, #0
 8003276:	d04e      	beq.n	8003316 <GPIO_Init+0xf6>
  {
    tmpreg = GPIOx->CRL;
 8003278:	687b      	ldr	r3, [r7, #4]
 800327a:	681b      	ldr	r3, [r3, #0]
 800327c:	617b      	str	r3, [r7, #20]
    for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 800327e:	f04f 0300 	mov.w	r3, #0
 8003282:	61bb      	str	r3, [r7, #24]
 8003284:	e041      	b.n	800330a <GPIO_Init+0xea>
    {
      pos = ((uint32_t)0x01) << pinpos;
 8003286:	69bb      	ldr	r3, [r7, #24]
 8003288:	f04f 0201 	mov.w	r2, #1
 800328c:	fa02 f303 	lsl.w	r3, r2, r3
 8003290:	60fb      	str	r3, [r7, #12]
      /* Get the port pins position */
      currentpin = (GPIO_InitStruct->GPIO_Pin) & pos;
 8003292:	683b      	ldr	r3, [r7, #0]
 8003294:	881b      	ldrh	r3, [r3, #0]
 8003296:	461a      	mov	r2, r3
 8003298:	68fb      	ldr	r3, [r7, #12]
 800329a:	4013      	ands	r3, r2
 800329c:	613b      	str	r3, [r7, #16]
      if (currentpin == pos)
 800329e:	693a      	ldr	r2, [r7, #16]
 80032a0:	68fb      	ldr	r3, [r7, #12]
 80032a2:	429a      	cmp	r2, r3
 80032a4:	d12d      	bne.n	8003302 <GPIO_Init+0xe2>
      {
        pos = pinpos << 2;
 80032a6:	69bb      	ldr	r3, [r7, #24]
 80032a8:	ea4f 0383 	mov.w	r3, r3, lsl #2
 80032ac:	60fb      	str	r3, [r7, #12]
        /* Clear the corresponding low control register bits */
        pinmask = ((uint32_t)0x0F) << pos;
 80032ae:	68fb      	ldr	r3, [r7, #12]
 80032b0:	f04f 020f 	mov.w	r2, #15
 80032b4:	fa02 f303 	lsl.w	r3, r2, r3
 80032b8:	60bb      	str	r3, [r7, #8]
        tmpreg &= ~pinmask;
 80032ba:	68bb      	ldr	r3, [r7, #8]
 80032bc:	ea6f 0303 	mvn.w	r3, r3
 80032c0:	697a      	ldr	r2, [r7, #20]
 80032c2:	4013      	ands	r3, r2
 80032c4:	617b      	str	r3, [r7, #20]
        /* Write the mode configuration in the corresponding bits */
        tmpreg |= (currentmode << pos);
 80032c6:	68fb      	ldr	r3, [r7, #12]
 80032c8:	69fa      	ldr	r2, [r7, #28]
 80032ca:	fa02 f303 	lsl.w	r3, r2, r3
 80032ce:	697a      	ldr	r2, [r7, #20]
 80032d0:	4313      	orrs	r3, r2
 80032d2:	617b      	str	r3, [r7, #20]
        /* Reset the corresponding ODR bit */
        if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
 80032d4:	683b      	ldr	r3, [r7, #0]
 80032d6:	78db      	ldrb	r3, [r3, #3]
 80032d8:	2b28      	cmp	r3, #40	; 0x28
 80032da:	d107      	bne.n	80032ec <GPIO_Init+0xcc>
        {
          GPIOx->BRR = (((uint32_t)0x01) << pinpos);
 80032dc:	69bb      	ldr	r3, [r7, #24]
 80032de:	f04f 0201 	mov.w	r2, #1
 80032e2:	fa02 f203 	lsl.w	r2, r2, r3
 80032e6:	687b      	ldr	r3, [r7, #4]
 80032e8:	615a      	str	r2, [r3, #20]
 80032ea:	e00a      	b.n	8003302 <GPIO_Init+0xe2>
        }
        else
        {
          /* Set the corresponding ODR bit */
          if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
 80032ec:	683b      	ldr	r3, [r7, #0]
 80032ee:	78db      	ldrb	r3, [r3, #3]
 80032f0:	2b48      	cmp	r3, #72	; 0x48
 80032f2:	d106      	bne.n	8003302 <GPIO_Init+0xe2>
          {
            GPIOx->BSRR = (((uint32_t)0x01) << pinpos);
 80032f4:	69bb      	ldr	r3, [r7, #24]
 80032f6:	f04f 0201 	mov.w	r2, #1
 80032fa:	fa02 f203 	lsl.w	r2, r2, r3
 80032fe:	687b      	ldr	r3, [r7, #4]
 8003300:	611a      	str	r2, [r3, #16]
/*---------------------------- GPIO CRL Configuration ------------------------*/
  /* Configure the eight low port pins */
  if (((uint32_t)GPIO_InitStruct->GPIO_Pin & ((uint32_t)0x00FF)) != 0x00)
  {
    tmpreg = GPIOx->CRL;
    for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 8003302:	69bb      	ldr	r3, [r7, #24]
 8003304:	f103 0301 	add.w	r3, r3, #1
 8003308:	61bb      	str	r3, [r7, #24]
 800330a:	69bb      	ldr	r3, [r7, #24]
 800330c:	2b07      	cmp	r3, #7
 800330e:	d9ba      	bls.n	8003286 <GPIO_Init+0x66>
            GPIOx->BSRR = (((uint32_t)0x01) << pinpos);
          }
        }
      }
    }
    GPIOx->CRL = tmpreg;
 8003310:	687b      	ldr	r3, [r7, #4]
 8003312:	697a      	ldr	r2, [r7, #20]
 8003314:	601a      	str	r2, [r3, #0]
  }
/*---------------------------- GPIO CRH Configuration ------------------------*/
  /* Configure the eight high port pins */
  if (GPIO_InitStruct->GPIO_Pin > 0x00FF)
 8003316:	683b      	ldr	r3, [r7, #0]
 8003318:	881b      	ldrh	r3, [r3, #0]
 800331a:	2bff      	cmp	r3, #255	; 0xff
 800331c:	d953      	bls.n	80033c6 <GPIO_Init+0x1a6>
  {
    tmpreg = GPIOx->CRH;
 800331e:	687b      	ldr	r3, [r7, #4]
 8003320:	685b      	ldr	r3, [r3, #4]
 8003322:	617b      	str	r3, [r7, #20]
    for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 8003324:	f04f 0300 	mov.w	r3, #0
 8003328:	61bb      	str	r3, [r7, #24]
 800332a:	e046      	b.n	80033ba <GPIO_Init+0x19a>
    {
      pos = (((uint32_t)0x01) << (pinpos + 0x08));
 800332c:	69bb      	ldr	r3, [r7, #24]
 800332e:	f103 0308 	add.w	r3, r3, #8
 8003332:	f04f 0201 	mov.w	r2, #1
 8003336:	fa02 f303 	lsl.w	r3, r2, r3
 800333a:	60fb      	str	r3, [r7, #12]
      /* Get the port pins position */
      currentpin = ((GPIO_InitStruct->GPIO_Pin) & pos);
 800333c:	683b      	ldr	r3, [r7, #0]
 800333e:	881b      	ldrh	r3, [r3, #0]
 8003340:	461a      	mov	r2, r3
 8003342:	68fb      	ldr	r3, [r7, #12]
 8003344:	4013      	ands	r3, r2
 8003346:	613b      	str	r3, [r7, #16]
      if (currentpin == pos)
 8003348:	693a      	ldr	r2, [r7, #16]
 800334a:	68fb      	ldr	r3, [r7, #12]
 800334c:	429a      	cmp	r2, r3
 800334e:	d130      	bne.n	80033b2 <GPIO_Init+0x192>
      {
        pos = pinpos << 2;
 8003350:	69bb      	ldr	r3, [r7, #24]
 8003352:	ea4f 0383 	mov.w	r3, r3, lsl #2
 8003356:	60fb      	str	r3, [r7, #12]
        /* Clear the corresponding high control register bits */
        pinmask = ((uint32_t)0x0F) << pos;
 8003358:	68fb      	ldr	r3, [r7, #12]
 800335a:	f04f 020f 	mov.w	r2, #15
 800335e:	fa02 f303 	lsl.w	r3, r2, r3
 8003362:	60bb      	str	r3, [r7, #8]
        tmpreg &= ~pinmask;
 8003364:	68bb      	ldr	r3, [r7, #8]
 8003366:	ea6f 0303 	mvn.w	r3, r3
 800336a:	697a      	ldr	r2, [r7, #20]
 800336c:	4013      	ands	r3, r2
 800336e:	617b      	str	r3, [r7, #20]
        /* Write the mode configuration in the corresponding bits */
        tmpreg |= (currentmode << pos);
 8003370:	68fb      	ldr	r3, [r7, #12]
 8003372:	69fa      	ldr	r2, [r7, #28]
 8003374:	fa02 f303 	lsl.w	r3, r2, r3
 8003378:	697a      	ldr	r2, [r7, #20]
 800337a:	4313      	orrs	r3, r2
 800337c:	617b      	str	r3, [r7, #20]
        /* Reset the corresponding ODR bit */
        if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPD)
 800337e:	683b      	ldr	r3, [r7, #0]
 8003380:	78db      	ldrb	r3, [r3, #3]
 8003382:	2b28      	cmp	r3, #40	; 0x28
 8003384:	d108      	bne.n	8003398 <GPIO_Init+0x178>
        {
          GPIOx->BRR = (((uint32_t)0x01) << (pinpos + 0x08));
 8003386:	69bb      	ldr	r3, [r7, #24]
 8003388:	f103 0308 	add.w	r3, r3, #8
 800338c:	f04f 0201 	mov.w	r2, #1
 8003390:	fa02 f203 	lsl.w	r2, r2, r3
 8003394:	687b      	ldr	r3, [r7, #4]
 8003396:	615a      	str	r2, [r3, #20]
        }
        /* Set the corresponding ODR bit */
        if (GPIO_InitStruct->GPIO_Mode == GPIO_Mode_IPU)
 8003398:	683b      	ldr	r3, [r7, #0]
 800339a:	78db      	ldrb	r3, [r3, #3]
 800339c:	2b48      	cmp	r3, #72	; 0x48
 800339e:	d108      	bne.n	80033b2 <GPIO_Init+0x192>
        {
          GPIOx->BSRR = (((uint32_t)0x01) << (pinpos + 0x08));
 80033a0:	69bb      	ldr	r3, [r7, #24]
 80033a2:	f103 0308 	add.w	r3, r3, #8
 80033a6:	f04f 0201 	mov.w	r2, #1
 80033aa:	fa02 f203 	lsl.w	r2, r2, r3
 80033ae:	687b      	ldr	r3, [r7, #4]
 80033b0:	611a      	str	r2, [r3, #16]
/*---------------------------- GPIO CRH Configuration ------------------------*/
  /* Configure the eight high port pins */
  if (GPIO_InitStruct->GPIO_Pin > 0x00FF)
  {
    tmpreg = GPIOx->CRH;
    for (pinpos = 0x00; pinpos < 0x08; pinpos++)
 80033b2:	69bb      	ldr	r3, [r7, #24]
 80033b4:	f103 0301 	add.w	r3, r3, #1
 80033b8:	61bb      	str	r3, [r7, #24]
 80033ba:	69bb      	ldr	r3, [r7, #24]
 80033bc:	2b07      	cmp	r3, #7
 80033be:	d9b5      	bls.n	800332c <GPIO_Init+0x10c>
        {
          GPIOx->BSRR = (((uint32_t)0x01) << (pinpos + 0x08));
        }
      }
    }
    GPIOx->CRH = tmpreg;
 80033c0:	687b      	ldr	r3, [r7, #4]
 80033c2:	697a      	ldr	r2, [r7, #20]
 80033c4:	605a      	str	r2, [r3, #4]
  }
}
 80033c6:	f107 0724 	add.w	r7, r7, #36	; 0x24
 80033ca:	46bd      	mov	sp, r7
 80033cc:	bc80      	pop	{r7}
 80033ce:	4770      	bx	lr

080033d0 <GPIO_StructInit>:
  * @param  GPIO_InitStruct : pointer to a GPIO_InitTypeDef structure which will
  *         be initialized.
  * @retval None
  */
void GPIO_StructInit(GPIO_InitTypeDef* GPIO_InitStruct)
{
 80033d0:	b480      	push	{r7}
 80033d2:	b083      	sub	sp, #12
 80033d4:	af00      	add	r7, sp, #0
 80033d6:	6078      	str	r0, [r7, #4]
  /* Reset GPIO init structure parameters values */
  GPIO_InitStruct->GPIO_Pin  = GPIO_Pin_All;
 80033d8:	687b      	ldr	r3, [r7, #4]
 80033da:	f64f 72ff 	movw	r2, #65535	; 0xffff
 80033de:	801a      	strh	r2, [r3, #0]
  GPIO_InitStruct->GPIO_Speed = GPIO_Speed_2MHz;
 80033e0:	687b      	ldr	r3, [r7, #4]
 80033e2:	f04f 0202 	mov.w	r2, #2
 80033e6:	709a      	strb	r2, [r3, #2]
  GPIO_InitStruct->GPIO_Mode = GPIO_Mode_IN_FLOATING;
 80033e8:	687b      	ldr	r3, [r7, #4]
 80033ea:	f04f 0204 	mov.w	r2, #4
 80033ee:	70da      	strb	r2, [r3, #3]
}
 80033f0:	f107 070c 	add.w	r7, r7, #12
 80033f4:	46bd      	mov	sp, r7
 80033f6:	bc80      	pop	{r7}
 80033f8:	4770      	bx	lr
 80033fa:	bf00      	nop

080033fc <GPIO_ReadInputDataBit>:
  * @param  GPIO_Pin:  specifies the port bit to read.
  *   This parameter can be GPIO_Pin_x where x can be (0..15).
  * @retval The input port pin value.
  */
uint8_t GPIO_ReadInputDataBit(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
{
 80033fc:	b480      	push	{r7}
 80033fe:	b085      	sub	sp, #20
 8003400:	af00      	add	r7, sp, #0
 8003402:	6078      	str	r0, [r7, #4]
 8003404:	460b      	mov	r3, r1
 8003406:	807b      	strh	r3, [r7, #2]
  uint8_t bitstatus = 0x00;
 8003408:	f04f 0300 	mov.w	r3, #0
 800340c:	73fb      	strb	r3, [r7, #15]
  
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  assert_param(IS_GET_GPIO_PIN(GPIO_Pin)); 
  
  if ((GPIOx->IDR & GPIO_Pin) != (uint32_t)Bit_RESET)
 800340e:	687b      	ldr	r3, [r7, #4]
 8003410:	689a      	ldr	r2, [r3, #8]
 8003412:	887b      	ldrh	r3, [r7, #2]
 8003414:	4013      	ands	r3, r2
 8003416:	2b00      	cmp	r3, #0
 8003418:	d003      	beq.n	8003422 <GPIO_ReadInputDataBit+0x26>
  {
    bitstatus = (uint8_t)Bit_SET;
 800341a:	f04f 0301 	mov.w	r3, #1
 800341e:	73fb      	strb	r3, [r7, #15]
 8003420:	e002      	b.n	8003428 <GPIO_ReadInputDataBit+0x2c>
  }
  else
  {
    bitstatus = (uint8_t)Bit_RESET;
 8003422:	f04f 0300 	mov.w	r3, #0
 8003426:	73fb      	strb	r3, [r7, #15]
  }
  return bitstatus;
 8003428:	7bfb      	ldrb	r3, [r7, #15]
}
 800342a:	4618      	mov	r0, r3
 800342c:	f107 0714 	add.w	r7, r7, #20
 8003430:	46bd      	mov	sp, r7
 8003432:	bc80      	pop	{r7}
 8003434:	4770      	bx	lr
 8003436:	bf00      	nop

08003438 <GPIO_ReadInputData>:
  * @brief  Reads the specified GPIO input data port.
  * @param  GPIOx: where x can be (A..G) to select the GPIO peripheral.
  * @retval GPIO input data port value.
  */
uint16_t GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
{
 8003438:	b480      	push	{r7}
 800343a:	b083      	sub	sp, #12
 800343c:	af00      	add	r7, sp, #0
 800343e:	6078      	str	r0, [r7, #4]
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  
  return ((uint16_t)GPIOx->IDR);
 8003440:	687b      	ldr	r3, [r7, #4]
 8003442:	689b      	ldr	r3, [r3, #8]
 8003444:	b29b      	uxth	r3, r3
}
 8003446:	4618      	mov	r0, r3
 8003448:	f107 070c 	add.w	r7, r7, #12
 800344c:	46bd      	mov	sp, r7
 800344e:	bc80      	pop	{r7}
 8003450:	4770      	bx	lr
 8003452:	bf00      	nop

08003454 <GPIO_ReadOutputDataBit>:
  * @param  GPIO_Pin:  specifies the port bit to read.
  *   This parameter can be GPIO_Pin_x where x can be (0..15).
  * @retval The output port pin value.
  */
uint8_t GPIO_ReadOutputDataBit(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
{
 8003454:	b480      	push	{r7}
 8003456:	b085      	sub	sp, #20
 8003458:	af00      	add	r7, sp, #0
 800345a:	6078      	str	r0, [r7, #4]
 800345c:	460b      	mov	r3, r1
 800345e:	807b      	strh	r3, [r7, #2]
  uint8_t bitstatus = 0x00;
 8003460:	f04f 0300 	mov.w	r3, #0
 8003464:	73fb      	strb	r3, [r7, #15]
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  assert_param(IS_GET_GPIO_PIN(GPIO_Pin)); 
  
  if ((GPIOx->ODR & GPIO_Pin) != (uint32_t)Bit_RESET)
 8003466:	687b      	ldr	r3, [r7, #4]
 8003468:	68da      	ldr	r2, [r3, #12]
 800346a:	887b      	ldrh	r3, [r7, #2]
 800346c:	4013      	ands	r3, r2
 800346e:	2b00      	cmp	r3, #0
 8003470:	d003      	beq.n	800347a <GPIO_ReadOutputDataBit+0x26>
  {
    bitstatus = (uint8_t)Bit_SET;
 8003472:	f04f 0301 	mov.w	r3, #1
 8003476:	73fb      	strb	r3, [r7, #15]
 8003478:	e002      	b.n	8003480 <GPIO_ReadOutputDataBit+0x2c>
  }
  else
  {
    bitstatus = (uint8_t)Bit_RESET;
 800347a:	f04f 0300 	mov.w	r3, #0
 800347e:	73fb      	strb	r3, [r7, #15]
  }
  return bitstatus;
 8003480:	7bfb      	ldrb	r3, [r7, #15]
}
 8003482:	4618      	mov	r0, r3
 8003484:	f107 0714 	add.w	r7, r7, #20
 8003488:	46bd      	mov	sp, r7
 800348a:	bc80      	pop	{r7}
 800348c:	4770      	bx	lr
 800348e:	bf00      	nop

08003490 <GPIO_ReadOutputData>:
  * @brief  Reads the specified GPIO output data port.
  * @param  GPIOx: where x can be (A..G) to select the GPIO peripheral.
  * @retval GPIO output data port value.
  */
uint16_t GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
{
 8003490:	b480      	push	{r7}
 8003492:	b083      	sub	sp, #12
 8003494:	af00      	add	r7, sp, #0
 8003496:	6078      	str	r0, [r7, #4]
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
    
  return ((uint16_t)GPIOx->ODR);
 8003498:	687b      	ldr	r3, [r7, #4]
 800349a:	68db      	ldr	r3, [r3, #12]
 800349c:	b29b      	uxth	r3, r3
}
 800349e:	4618      	mov	r0, r3
 80034a0:	f107 070c 	add.w	r7, r7, #12
 80034a4:	46bd      	mov	sp, r7
 80034a6:	bc80      	pop	{r7}
 80034a8:	4770      	bx	lr
 80034aa:	bf00      	nop

080034ac <GPIO_SetBits>:
  * @param  GPIO_Pin: specifies the port bits to be written.
  *   This parameter can be any combination of GPIO_Pin_x where x can be (0..15).
  * @retval None
  */
void GPIO_SetBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
{
 80034ac:	b480      	push	{r7}
 80034ae:	b083      	sub	sp, #12
 80034b0:	af00      	add	r7, sp, #0
 80034b2:	6078      	str	r0, [r7, #4]
 80034b4:	460b      	mov	r3, r1
 80034b6:	807b      	strh	r3, [r7, #2]
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  assert_param(IS_GPIO_PIN(GPIO_Pin));
  
  GPIOx->BSRR = GPIO_Pin;
 80034b8:	887a      	ldrh	r2, [r7, #2]
 80034ba:	687b      	ldr	r3, [r7, #4]
 80034bc:	611a      	str	r2, [r3, #16]
}
 80034be:	f107 070c 	add.w	r7, r7, #12
 80034c2:	46bd      	mov	sp, r7
 80034c4:	bc80      	pop	{r7}
 80034c6:	4770      	bx	lr

080034c8 <GPIO_ResetBits>:
  * @param  GPIO_Pin: specifies the port bits to be written.
  *   This parameter can be any combination of GPIO_Pin_x where x can be (0..15).
  * @retval None
  */
void GPIO_ResetBits(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
{
 80034c8:	b480      	push	{r7}
 80034ca:	b083      	sub	sp, #12
 80034cc:	af00      	add	r7, sp, #0
 80034ce:	6078      	str	r0, [r7, #4]
 80034d0:	460b      	mov	r3, r1
 80034d2:	807b      	strh	r3, [r7, #2]
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  assert_param(IS_GPIO_PIN(GPIO_Pin));
  
  GPIOx->BRR = GPIO_Pin;
 80034d4:	887a      	ldrh	r2, [r7, #2]
 80034d6:	687b      	ldr	r3, [r7, #4]
 80034d8:	615a      	str	r2, [r3, #20]
}
 80034da:	f107 070c 	add.w	r7, r7, #12
 80034de:	46bd      	mov	sp, r7
 80034e0:	bc80      	pop	{r7}
 80034e2:	4770      	bx	lr

080034e4 <GPIO_WriteBit>:
  *     @arg Bit_RESET: to clear the port pin
  *     @arg Bit_SET: to set the port pin
  * @retval None
  */
void GPIO_WriteBit(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin, BitAction BitVal)
{
 80034e4:	b480      	push	{r7}
 80034e6:	b083      	sub	sp, #12
 80034e8:	af00      	add	r7, sp, #0
 80034ea:	6078      	str	r0, [r7, #4]
 80034ec:	4613      	mov	r3, r2
 80034ee:	460a      	mov	r2, r1
 80034f0:	807a      	strh	r2, [r7, #2]
 80034f2:	707b      	strb	r3, [r7, #1]
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  assert_param(IS_GET_GPIO_PIN(GPIO_Pin));
  assert_param(IS_GPIO_BIT_ACTION(BitVal)); 
  
  if (BitVal != Bit_RESET)
 80034f4:	787b      	ldrb	r3, [r7, #1]
 80034f6:	2b00      	cmp	r3, #0
 80034f8:	d003      	beq.n	8003502 <GPIO_WriteBit+0x1e>
  {
    GPIOx->BSRR = GPIO_Pin;
 80034fa:	887a      	ldrh	r2, [r7, #2]
 80034fc:	687b      	ldr	r3, [r7, #4]
 80034fe:	611a      	str	r2, [r3, #16]
 8003500:	e002      	b.n	8003508 <GPIO_WriteBit+0x24>
  }
  else
  {
    GPIOx->BRR = GPIO_Pin;
 8003502:	887a      	ldrh	r2, [r7, #2]
 8003504:	687b      	ldr	r3, [r7, #4]
 8003506:	615a      	str	r2, [r3, #20]
  }
}
 8003508:	f107 070c 	add.w	r7, r7, #12
 800350c:	46bd      	mov	sp, r7
 800350e:	bc80      	pop	{r7}
 8003510:	4770      	bx	lr
 8003512:	bf00      	nop

08003514 <GPIO_Write>:
  * @param  GPIOx: where x can be (A..G) to select the GPIO peripheral.
  * @param  PortVal: specifies the value to be written to the port output data register.
  * @retval None
  */
void GPIO_Write(GPIO_TypeDef* GPIOx, uint16_t PortVal)
{
 8003514:	b480      	push	{r7}
 8003516:	b083      	sub	sp, #12
 8003518:	af00      	add	r7, sp, #0
 800351a:	6078      	str	r0, [r7, #4]
 800351c:	460b      	mov	r3, r1
 800351e:	807b      	strh	r3, [r7, #2]
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  
  GPIOx->ODR = PortVal;
 8003520:	887a      	ldrh	r2, [r7, #2]
 8003522:	687b      	ldr	r3, [r7, #4]
 8003524:	60da      	str	r2, [r3, #12]
}
 8003526:	f107 070c 	add.w	r7, r7, #12
 800352a:	46bd      	mov	sp, r7
 800352c:	bc80      	pop	{r7}
 800352e:	4770      	bx	lr

08003530 <GPIO_PinLockConfig>:
  * @param  GPIO_Pin: specifies the port bit to be written.
  *   This parameter can be any combination of GPIO_Pin_x where x can be (0..15).
  * @retval None
  */
void GPIO_PinLockConfig(GPIO_TypeDef* GPIOx, uint16_t GPIO_Pin)
{
 8003530:	b480      	push	{r7}
 8003532:	b085      	sub	sp, #20
 8003534:	af00      	add	r7, sp, #0
 8003536:	6078      	str	r0, [r7, #4]
 8003538:	460b      	mov	r3, r1
 800353a:	807b      	strh	r3, [r7, #2]
  uint32_t tmp = 0x00010000;
 800353c:	f44f 3380 	mov.w	r3, #65536	; 0x10000
 8003540:	60fb      	str	r3, [r7, #12]
  
  /* Check the parameters */
  assert_param(IS_GPIO_ALL_PERIPH(GPIOx));
  assert_param(IS_GPIO_PIN(GPIO_Pin));
  
  tmp |= GPIO_Pin;
 8003542:	887b      	ldrh	r3, [r7, #2]
 8003544:	68fa      	ldr	r2, [r7, #12]
 8003546:	4313      	orrs	r3, r2
 8003548:	60fb      	str	r3, [r7, #12]
  /* Set LCKK bit */
  GPIOx->LCKR = tmp;
 800354a:	687b      	ldr	r3, [r7, #4]
 800354c:	68fa      	ldr	r2, [r7, #12]
 800354e:	619a      	str	r2, [r3, #24]
  /* Reset LCKK bit */
  GPIOx->LCKR =  GPIO_Pin;
 8003550:	887a      	ldrh	r2, [r7, #2]
 8003552:	687b      	ldr	r3, [r7, #4]
 8003554:	619a      	str	r2, [r3, #24]
  /* Set LCKK bit */
  GPIOx->LCKR = tmp;
 8003556:	687b      	ldr	r3, [r7, #4]
 8003558:	68fa      	ldr	r2, [r7, #12]
 800355a:	619a      	str	r2, [r3, #24]
  /* Read LCKK bit*/
  tmp = GPIOx->LCKR;
 800355c:	687b      	ldr	r3, [r7, #4]
 800355e:	699b      	ldr	r3, [r3, #24]
 8003560:	60fb      	str	r3, [r7, #12]
  /* Read LCKK bit*/
  tmp = GPIOx->LCKR;
 8003562:	687b      	ldr	r3, [r7, #4]
 8003564:	699b      	ldr	r3, [r3, #24]
 8003566:	60fb      	str	r3, [r7, #12]
}
 8003568:	f107 0714 	add.w	r7, r7, #20
 800356c:	46bd      	mov	sp, r7
 800356e:	bc80      	pop	{r7}
 8003570:	4770      	bx	lr
 8003572:	bf00      	nop

08003574 <GPIO_EventOutputConfig>:
  * @param  GPIO_PinSource: specifies the pin for the Event output.
  *   This parameter can be GPIO_PinSourcex where x can be (0..15).
  * @retval None
  */
void GPIO_EventOutputConfig(uint8_t GPIO_PortSource, uint8_t GPIO_PinSource)
{
 8003574:	b480      	push	{r7}
 8003576:	b085      	sub	sp, #20
 8003578:	af00      	add	r7, sp, #0
 800357a:	4602      	mov	r2, r0
 800357c:	460b      	mov	r3, r1
 800357e:	71fa      	strb	r2, [r7, #7]
 8003580:	71bb      	strb	r3, [r7, #6]
  uint32_t tmpreg = 0x00;
 8003582:	f04f 0300 	mov.w	r3, #0
 8003586:	60fb      	str	r3, [r7, #12]
  /* Check the parameters */
  assert_param(IS_GPIO_EVENTOUT_PORT_SOURCE(GPIO_PortSource));
  assert_param(IS_GPIO_PIN_SOURCE(GPIO_PinSource));
    
  tmpreg = AFIO->EVCR;
 8003588:	f04f 0300 	mov.w	r3, #0
 800358c:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8003590:	681b      	ldr	r3, [r3, #0]
 8003592:	60fb      	str	r3, [r7, #12]
  /* Clear the PORT[6:4] and PIN[3:0] bits */
  tmpreg &= EVCR_PORTPINCONFIG_MASK;
 8003594:	68fa      	ldr	r2, [r7, #12]
 8003596:	f64f 7380 	movw	r3, #65408	; 0xff80
 800359a:	4013      	ands	r3, r2
 800359c:	60fb      	str	r3, [r7, #12]
  tmpreg |= (uint32_t)GPIO_PortSource << 0x04;
 800359e:	79fb      	ldrb	r3, [r7, #7]
 80035a0:	ea4f 1303 	mov.w	r3, r3, lsl #4
 80035a4:	68fa      	ldr	r2, [r7, #12]
 80035a6:	4313      	orrs	r3, r2
 80035a8:	60fb      	str	r3, [r7, #12]
  tmpreg |= GPIO_PinSource;
 80035aa:	79bb      	ldrb	r3, [r7, #6]
 80035ac:	68fa      	ldr	r2, [r7, #12]
 80035ae:	4313      	orrs	r3, r2
 80035b0:	60fb      	str	r3, [r7, #12]
  AFIO->EVCR = tmpreg;
 80035b2:	f04f 0300 	mov.w	r3, #0
 80035b6:	f2c4 0301 	movt	r3, #16385	; 0x4001
 80035ba:	68fa      	ldr	r2, [r7, #12]
 80035bc:	601a      	str	r2, [r3, #0]
}
 80035be:	f107 0714 	add.w	r7, r7, #20
 80035c2:	46bd      	mov	sp, r7
 80035c4:	bc80      	pop	{r7}
 80035c6:	4770      	bx	lr

080035c8 <GPIO_EventOutputCmd>:
  * @param  NewState: new state of the Event output.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void GPIO_EventOutputCmd(FunctionalState NewState)
{
 80035c8:	b480      	push	{r7}
 80035ca:	b083      	sub	sp, #12
 80035cc:	af00      	add	r7, sp, #0
 80035ce:	4603      	mov	r3, r0
 80035d0:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  *(__IO uint32_t *) EVCR_EVOE_BB = (uint32_t)NewState;
 80035d2:	f04f 031c 	mov.w	r3, #28
 80035d6:	f2c4 2320 	movt	r3, #16928	; 0x4220
 80035da:	79fa      	ldrb	r2, [r7, #7]
 80035dc:	601a      	str	r2, [r3, #0]
}
 80035de:	f107 070c 	add.w	r7, r7, #12
 80035e2:	46bd      	mov	sp, r7
 80035e4:	bc80      	pop	{r7}
 80035e6:	4770      	bx	lr

080035e8 <GPIO_PinRemapConfig>:
  * @param  NewState: new state of the port pin remapping.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void GPIO_PinRemapConfig(uint32_t GPIO_Remap, FunctionalState NewState)
{
 80035e8:	b480      	push	{r7}
 80035ea:	b087      	sub	sp, #28
 80035ec:	af00      	add	r7, sp, #0
 80035ee:	6078      	str	r0, [r7, #4]
 80035f0:	460b      	mov	r3, r1
 80035f2:	70fb      	strb	r3, [r7, #3]
  uint32_t tmp = 0x00, tmp1 = 0x00, tmpreg = 0x00, tmpmask = 0x00;
 80035f4:	f04f 0300 	mov.w	r3, #0
 80035f8:	613b      	str	r3, [r7, #16]
 80035fa:	f04f 0300 	mov.w	r3, #0
 80035fe:	60fb      	str	r3, [r7, #12]
 8003600:	f04f 0300 	mov.w	r3, #0
 8003604:	617b      	str	r3, [r7, #20]
 8003606:	f04f 0300 	mov.w	r3, #0
 800360a:	60bb      	str	r3, [r7, #8]

  /* Check the parameters */
  assert_param(IS_GPIO_REMAP(GPIO_Remap));
  assert_param(IS_FUNCTIONAL_STATE(NewState));  
  
  if((GPIO_Remap & 0x80000000) == 0x80000000)
 800360c:	687b      	ldr	r3, [r7, #4]
 800360e:	2b00      	cmp	r3, #0
 8003610:	da06      	bge.n	8003620 <GPIO_PinRemapConfig+0x38>
  {
    tmpreg = AFIO->MAPR2;
 8003612:	f04f 0300 	mov.w	r3, #0
 8003616:	f2c4 0301 	movt	r3, #16385	; 0x4001
 800361a:	69db      	ldr	r3, [r3, #28]
 800361c:	617b      	str	r3, [r7, #20]
 800361e:	e005      	b.n	800362c <GPIO_PinRemapConfig+0x44>
  }
  else
  {
    tmpreg = AFIO->MAPR;
 8003620:	f04f 0300 	mov.w	r3, #0
 8003624:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8003628:	685b      	ldr	r3, [r3, #4]
 800362a:	617b      	str	r3, [r7, #20]
  }

  tmpmask = (GPIO_Remap & DBGAFR_POSITION_MASK) >> 0x10;
 800362c:	687b      	ldr	r3, [r7, #4]
 800362e:	f403 2370 	and.w	r3, r3, #983040	; 0xf0000
 8003632:	ea4f 4313 	mov.w	r3, r3, lsr #16
 8003636:	60bb      	str	r3, [r7, #8]
  tmp = GPIO_Remap & LSB_MASK;
 8003638:	687b      	ldr	r3, [r7, #4]
 800363a:	ea4f 4303 	mov.w	r3, r3, lsl #16
 800363e:	ea4f 4313 	mov.w	r3, r3, lsr #16
 8003642:	613b      	str	r3, [r7, #16]

  if ((GPIO_Remap & (DBGAFR_LOCATION_MASK | DBGAFR_NUMBITS_MASK)) == (DBGAFR_LOCATION_MASK | DBGAFR_NUMBITS_MASK))
 8003644:	687b      	ldr	r3, [r7, #4]
 8003646:	f403 1340 	and.w	r3, r3, #3145728	; 0x300000
 800364a:	f5b3 1f40 	cmp.w	r3, #3145728	; 0x300000
 800364e:	d110      	bne.n	8003672 <GPIO_PinRemapConfig+0x8a>
  {
    tmpreg &= DBGAFR_SWJCFG_MASK;
 8003650:	697b      	ldr	r3, [r7, #20]
 8003652:	f023 6370 	bic.w	r3, r3, #251658240	; 0xf000000
 8003656:	617b      	str	r3, [r7, #20]
    AFIO->MAPR &= DBGAFR_SWJCFG_MASK;
 8003658:	f04f 0300 	mov.w	r3, #0
 800365c:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8003660:	f04f 0200 	mov.w	r2, #0
 8003664:	f2c4 0201 	movt	r2, #16385	; 0x4001
 8003668:	6852      	ldr	r2, [r2, #4]
 800366a:	f022 6270 	bic.w	r2, r2, #251658240	; 0xf000000
 800366e:	605a      	str	r2, [r3, #4]
 8003670:	e026      	b.n	80036c0 <GPIO_PinRemapConfig+0xd8>
  }
  else if ((GPIO_Remap & DBGAFR_NUMBITS_MASK) == DBGAFR_NUMBITS_MASK)
 8003672:	687b      	ldr	r3, [r7, #4]
 8003674:	f403 1380 	and.w	r3, r3, #1048576	; 0x100000
 8003678:	2b00      	cmp	r3, #0
 800367a:	d010      	beq.n	800369e <GPIO_PinRemapConfig+0xb6>
  {
    tmp1 = ((uint32_t)0x03) << tmpmask;
 800367c:	68bb      	ldr	r3, [r7, #8]
 800367e:	f04f 0203 	mov.w	r2, #3
 8003682:	fa02 f303 	lsl.w	r3, r2, r3
 8003686:	60fb      	str	r3, [r7, #12]
    tmpreg &= ~tmp1;
 8003688:	68fb      	ldr	r3, [r7, #12]
 800368a:	ea6f 0303 	mvn.w	r3, r3
 800368e:	697a      	ldr	r2, [r7, #20]
 8003690:	4013      	ands	r3, r2
 8003692:	617b      	str	r3, [r7, #20]
    tmpreg |= ~DBGAFR_SWJCFG_MASK;
 8003694:	697b      	ldr	r3, [r7, #20]
 8003696:	f043 6370 	orr.w	r3, r3, #251658240	; 0xf000000
 800369a:	617b      	str	r3, [r7, #20]
 800369c:	e010      	b.n	80036c0 <GPIO_PinRemapConfig+0xd8>
  }
  else
  {
    tmpreg &= ~(tmp << ((GPIO_Remap >> 0x15)*0x10));
 800369e:	687b      	ldr	r3, [r7, #4]
 80036a0:	ea4f 5353 	mov.w	r3, r3, lsr #21
 80036a4:	ea4f 1303 	mov.w	r3, r3, lsl #4
 80036a8:	693a      	ldr	r2, [r7, #16]
 80036aa:	fa02 f303 	lsl.w	r3, r2, r3
 80036ae:	ea6f 0303 	mvn.w	r3, r3
 80036b2:	697a      	ldr	r2, [r7, #20]
 80036b4:	4013      	ands	r3, r2
 80036b6:	617b      	str	r3, [r7, #20]
    tmpreg |= ~DBGAFR_SWJCFG_MASK;
 80036b8:	697b      	ldr	r3, [r7, #20]
 80036ba:	f043 6370 	orr.w	r3, r3, #251658240	; 0xf000000
 80036be:	617b      	str	r3, [r7, #20]
  }

  if (NewState != DISABLE)
 80036c0:	78fb      	ldrb	r3, [r7, #3]
 80036c2:	2b00      	cmp	r3, #0
 80036c4:	d00a      	beq.n	80036dc <GPIO_PinRemapConfig+0xf4>
  {
    tmpreg |= (tmp << ((GPIO_Remap >> 0x15)*0x10));
 80036c6:	687b      	ldr	r3, [r7, #4]
 80036c8:	ea4f 5353 	mov.w	r3, r3, lsr #21
 80036cc:	ea4f 1303 	mov.w	r3, r3, lsl #4
 80036d0:	693a      	ldr	r2, [r7, #16]
 80036d2:	fa02 f303 	lsl.w	r3, r2, r3
 80036d6:	697a      	ldr	r2, [r7, #20]
 80036d8:	4313      	orrs	r3, r2
 80036da:	617b      	str	r3, [r7, #20]
  }

  if((GPIO_Remap & 0x80000000) == 0x80000000)
 80036dc:	687b      	ldr	r3, [r7, #4]
 80036de:	2b00      	cmp	r3, #0
 80036e0:	da06      	bge.n	80036f0 <GPIO_PinRemapConfig+0x108>
  {
    AFIO->MAPR2 = tmpreg;
 80036e2:	f04f 0300 	mov.w	r3, #0
 80036e6:	f2c4 0301 	movt	r3, #16385	; 0x4001
 80036ea:	697a      	ldr	r2, [r7, #20]
 80036ec:	61da      	str	r2, [r3, #28]
 80036ee:	e005      	b.n	80036fc <GPIO_PinRemapConfig+0x114>
  }
  else
  {
    AFIO->MAPR = tmpreg;
 80036f0:	f04f 0300 	mov.w	r3, #0
 80036f4:	f2c4 0301 	movt	r3, #16385	; 0x4001
 80036f8:	697a      	ldr	r2, [r7, #20]
 80036fa:	605a      	str	r2, [r3, #4]
  }  
}
 80036fc:	f107 071c 	add.w	r7, r7, #28
 8003700:	46bd      	mov	sp, r7
 8003702:	bc80      	pop	{r7}
 8003704:	4770      	bx	lr
 8003706:	bf00      	nop

08003708 <GPIO_EXTILineConfig>:
  * @param  GPIO_PinSource: specifies the EXTI line to be configured.
  *   This parameter can be GPIO_PinSourcex where x can be (0..15).
  * @retval None
  */
void GPIO_EXTILineConfig(uint8_t GPIO_PortSource, uint8_t GPIO_PinSource)
{
 8003708:	b490      	push	{r4, r7}
 800370a:	b084      	sub	sp, #16
 800370c:	af00      	add	r7, sp, #0
 800370e:	4602      	mov	r2, r0
 8003710:	460b      	mov	r3, r1
 8003712:	71fa      	strb	r2, [r7, #7]
 8003714:	71bb      	strb	r3, [r7, #6]
  uint32_t tmp = 0x00;
 8003716:	f04f 0300 	mov.w	r3, #0
 800371a:	60fb      	str	r3, [r7, #12]
  /* Check the parameters */
  assert_param(IS_GPIO_EXTI_PORT_SOURCE(GPIO_PortSource));
  assert_param(IS_GPIO_PIN_SOURCE(GPIO_PinSource));
  
  tmp = ((uint32_t)0x0F) << (0x04 * (GPIO_PinSource & (uint8_t)0x03));
 800371c:	79bb      	ldrb	r3, [r7, #6]
 800371e:	f003 0303 	and.w	r3, r3, #3
 8003722:	ea4f 0383 	mov.w	r3, r3, lsl #2
 8003726:	f04f 020f 	mov.w	r2, #15
 800372a:	fa02 f303 	lsl.w	r3, r2, r3
 800372e:	60fb      	str	r3, [r7, #12]
  AFIO->EXTICR[GPIO_PinSource >> 0x02] &= ~tmp;
 8003730:	f04f 0300 	mov.w	r3, #0
 8003734:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8003738:	79ba      	ldrb	r2, [r7, #6]
 800373a:	ea4f 0292 	mov.w	r2, r2, lsr #2
 800373e:	b2d2      	uxtb	r2, r2
 8003740:	4610      	mov	r0, r2
 8003742:	f04f 0200 	mov.w	r2, #0
 8003746:	f2c4 0201 	movt	r2, #16385	; 0x4001
 800374a:	79b9      	ldrb	r1, [r7, #6]
 800374c:	ea4f 0191 	mov.w	r1, r1, lsr #2
 8003750:	b2c9      	uxtb	r1, r1
 8003752:	f101 0102 	add.w	r1, r1, #2
 8003756:	f852 1021 	ldr.w	r1, [r2, r1, lsl #2]
 800375a:	68fa      	ldr	r2, [r7, #12]
 800375c:	ea6f 0202 	mvn.w	r2, r2
 8003760:	4011      	ands	r1, r2
 8003762:	f100 0202 	add.w	r2, r0, #2
 8003766:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
  AFIO->EXTICR[GPIO_PinSource >> 0x02] |= (((uint32_t)GPIO_PortSource) << (0x04 * (GPIO_PinSource & (uint8_t)0x03)));
 800376a:	f04f 0300 	mov.w	r3, #0
 800376e:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8003772:	79ba      	ldrb	r2, [r7, #6]
 8003774:	ea4f 0292 	mov.w	r2, r2, lsr #2
 8003778:	b2d2      	uxtb	r2, r2
 800377a:	4610      	mov	r0, r2
 800377c:	f04f 0200 	mov.w	r2, #0
 8003780:	f2c4 0201 	movt	r2, #16385	; 0x4001
 8003784:	79b9      	ldrb	r1, [r7, #6]
 8003786:	ea4f 0191 	mov.w	r1, r1, lsr #2
 800378a:	b2c9      	uxtb	r1, r1
 800378c:	f101 0102 	add.w	r1, r1, #2
 8003790:	f852 1021 	ldr.w	r1, [r2, r1, lsl #2]
 8003794:	79fc      	ldrb	r4, [r7, #7]
 8003796:	79ba      	ldrb	r2, [r7, #6]
 8003798:	f002 0203 	and.w	r2, r2, #3
 800379c:	ea4f 0282 	mov.w	r2, r2, lsl #2
 80037a0:	fa04 f202 	lsl.w	r2, r4, r2
 80037a4:	4311      	orrs	r1, r2
 80037a6:	f100 0202 	add.w	r2, r0, #2
 80037aa:	f843 1022 	str.w	r1, [r3, r2, lsl #2]
}
 80037ae:	f107 0710 	add.w	r7, r7, #16
 80037b2:	46bd      	mov	sp, r7
 80037b4:	bc90      	pop	{r4, r7}
 80037b6:	4770      	bx	lr

080037b8 <GPIO_ETH_MediaInterfaceConfig>:
  *     @arg GPIO_ETH_MediaInterface_MII: MII mode
  *     @arg GPIO_ETH_MediaInterface_RMII: RMII mode    
  * @retval None
  */
void GPIO_ETH_MediaInterfaceConfig(uint32_t GPIO_ETH_MediaInterface) 
{ 
 80037b8:	b480      	push	{r7}
 80037ba:	b083      	sub	sp, #12
 80037bc:	af00      	add	r7, sp, #0
 80037be:	6078      	str	r0, [r7, #4]
  assert_param(IS_GPIO_ETH_MEDIA_INTERFACE(GPIO_ETH_MediaInterface)); 

  /* Configure MII_RMII selection bit */ 
  *(__IO uint32_t *) MAPR_MII_RMII_SEL_BB = GPIO_ETH_MediaInterface; 
 80037c0:	f04f 03dc 	mov.w	r3, #220	; 0xdc
 80037c4:	f2c4 2320 	movt	r3, #16928	; 0x4220
 80037c8:	687a      	ldr	r2, [r7, #4]
 80037ca:	601a      	str	r2, [r3, #0]
}
 80037cc:	f107 070c 	add.w	r7, r7, #12
 80037d0:	46bd      	mov	sp, r7
 80037d2:	bc80      	pop	{r7}
 80037d4:	4770      	bx	lr
 80037d6:	bf00      	nop

080037d8 <RCC_DeInit>:
  * @brief  Resets the RCC clock configuration to the default reset state.
  * @param  None
  * @retval None
  */
void RCC_DeInit(void)
{
 80037d8:	b480      	push	{r7}
 80037da:	af00      	add	r7, sp, #0
  /* Set HSION bit */
  RCC->CR |= (uint32_t)0x00000001;
 80037dc:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80037e0:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80037e4:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80037e8:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80037ec:	6812      	ldr	r2, [r2, #0]
 80037ee:	f042 0201 	orr.w	r2, r2, #1
 80037f2:	601a      	str	r2, [r3, #0]

  /* Reset SW, HPRE, PPRE1, PPRE2, ADCPRE and MCO bits */
#ifndef STM32F10X_CL
  RCC->CFGR &= (uint32_t)0xF8FF0000;
 80037f4:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80037f8:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80037fc:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003800:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003804:	6859      	ldr	r1, [r3, #4]
 8003806:	f04f 0300 	mov.w	r3, #0
 800380a:	f6cf 03ff 	movt	r3, #63743	; 0xf8ff
 800380e:	400b      	ands	r3, r1
 8003810:	6053      	str	r3, [r2, #4]
#else
  RCC->CFGR &= (uint32_t)0xF0FF0000;
#endif /* STM32F10X_CL */   
  
  /* Reset HSEON, CSSON and PLLON bits */
  RCC->CR &= (uint32_t)0xFEF6FFFF;
 8003812:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003816:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800381a:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 800381e:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003822:	6812      	ldr	r2, [r2, #0]
 8003824:	f022 7284 	bic.w	r2, r2, #17301504	; 0x1080000
 8003828:	f422 3280 	bic.w	r2, r2, #65536	; 0x10000
 800382c:	601a      	str	r2, [r3, #0]

  /* Reset HSEBYP bit */
  RCC->CR &= (uint32_t)0xFFFBFFFF;
 800382e:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003832:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003836:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 800383a:	f2c4 0202 	movt	r2, #16386	; 0x4002
 800383e:	6812      	ldr	r2, [r2, #0]
 8003840:	f422 2280 	bic.w	r2, r2, #262144	; 0x40000
 8003844:	601a      	str	r2, [r3, #0]

  /* Reset PLLSRC, PLLXTPRE, PLLMUL and USBPRE/OTGFSPRE bits */
  RCC->CFGR &= (uint32_t)0xFF80FFFF;
 8003846:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 800384a:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800384e:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003852:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003856:	6852      	ldr	r2, [r2, #4]
 8003858:	f422 02fe 	bic.w	r2, r2, #8323072	; 0x7f0000
 800385c:	605a      	str	r2, [r3, #4]

  /* Reset CFGR2 register */
  RCC->CFGR2 = 0x00000000;      
#else
  /* Disable all interrupts and clear pending bits  */
  RCC->CIR = 0x009F0000;
 800385e:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003862:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003866:	f44f 021f 	mov.w	r2, #10420224	; 0x9f0000
 800386a:	609a      	str	r2, [r3, #8]
#endif /* STM32F10X_CL */

}
 800386c:	46bd      	mov	sp, r7
 800386e:	bc80      	pop	{r7}
 8003870:	4770      	bx	lr
 8003872:	bf00      	nop

08003874 <RCC_HSEConfig>:
  *     @arg RCC_HSE_ON: HSE oscillator ON
  *     @arg RCC_HSE_Bypass: HSE oscillator bypassed with external clock
  * @retval None
  */
void RCC_HSEConfig(uint32_t RCC_HSE)
{
 8003874:	b480      	push	{r7}
 8003876:	b083      	sub	sp, #12
 8003878:	af00      	add	r7, sp, #0
 800387a:	6078      	str	r0, [r7, #4]
  /* Check the parameters */
  assert_param(IS_RCC_HSE(RCC_HSE));
  /* Reset HSEON and HSEBYP bits before configuring the HSE ------------------*/
  /* Reset HSEON bit */
  RCC->CR &= CR_HSEON_Reset;
 800387c:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003880:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003884:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003888:	f2c4 0202 	movt	r2, #16386	; 0x4002
 800388c:	6812      	ldr	r2, [r2, #0]
 800388e:	f422 3280 	bic.w	r2, r2, #65536	; 0x10000
 8003892:	601a      	str	r2, [r3, #0]
  /* Reset HSEBYP bit */
  RCC->CR &= CR_HSEBYP_Reset;
 8003894:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003898:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800389c:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80038a0:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80038a4:	6812      	ldr	r2, [r2, #0]
 80038a6:	f422 2280 	bic.w	r2, r2, #262144	; 0x40000
 80038aa:	601a      	str	r2, [r3, #0]
  /* Configure HSE (RCC_HSE_OFF is already covered by the code section above) */
  switch(RCC_HSE)
 80038ac:	687b      	ldr	r3, [r7, #4]
 80038ae:	f5b3 3f80 	cmp.w	r3, #65536	; 0x10000
 80038b2:	d003      	beq.n	80038bc <RCC_HSEConfig+0x48>
 80038b4:	f5b3 2f80 	cmp.w	r3, #262144	; 0x40000
 80038b8:	d00d      	beq.n	80038d6 <RCC_HSEConfig+0x62>
 80038ba:	e019      	b.n	80038f0 <RCC_HSEConfig+0x7c>
  {
    case RCC_HSE_ON:
      /* Set HSEON bit */
      RCC->CR |= CR_HSEON_Set;
 80038bc:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80038c0:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80038c4:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80038c8:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80038cc:	6812      	ldr	r2, [r2, #0]
 80038ce:	f442 3280 	orr.w	r2, r2, #65536	; 0x10000
 80038d2:	601a      	str	r2, [r3, #0]
      break;
 80038d4:	e00d      	b.n	80038f2 <RCC_HSEConfig+0x7e>
      
    case RCC_HSE_Bypass:
      /* Set HSEBYP and HSEON bits */
      RCC->CR |= CR_HSEBYP_Set | CR_HSEON_Set;
 80038d6:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80038da:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80038de:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 80038e2:	f2c4 0202 	movt	r2, #16386	; 0x4002
 80038e6:	6812      	ldr	r2, [r2, #0]
 80038e8:	f442 22a0 	orr.w	r2, r2, #327680	; 0x50000
 80038ec:	601a      	str	r2, [r3, #0]
      break;
 80038ee:	e000      	b.n	80038f2 <RCC_HSEConfig+0x7e>
      
    default:
      break;
 80038f0:	bf00      	nop
  }
}
 80038f2:	f107 070c 	add.w	r7, r7, #12
 80038f6:	46bd      	mov	sp, r7
 80038f8:	bc80      	pop	{r7}
 80038fa:	4770      	bx	lr

080038fc <RCC_WaitForHSEStartUp>:
  * @retval An ErrorStatus enumuration value:
  * - SUCCESS: HSE oscillator is stable and ready to use
  * - ERROR: HSE oscillator not yet ready
  */
ErrorStatus RCC_WaitForHSEStartUp(void)
{
 80038fc:	b580      	push	{r7, lr}
 80038fe:	b082      	sub	sp, #8
 8003900:	af00      	add	r7, sp, #0
  __IO uint32_t StartUpCounter = 0;
 8003902:	f04f 0300 	mov.w	r3, #0
 8003906:	603b      	str	r3, [r7, #0]
  ErrorStatus status = ERROR;
 8003908:	f04f 0300 	mov.w	r3, #0
 800390c:	71fb      	strb	r3, [r7, #7]
  FlagStatus HSEStatus = RESET;
 800390e:	f04f 0300 	mov.w	r3, #0
 8003912:	71bb      	strb	r3, [r7, #6]
  
  /* Wait till HSE is ready and if Time out is reached exit */
  do
  {
    HSEStatus = RCC_GetFlagStatus(RCC_FLAG_HSERDY);
 8003914:	f04f 0031 	mov.w	r0, #49	; 0x31
 8003918:	f000 fbce 	bl	80040b8 <RCC_GetFlagStatus>
 800391c:	4603      	mov	r3, r0
 800391e:	71bb      	strb	r3, [r7, #6]
    StartUpCounter++;  
 8003920:	683b      	ldr	r3, [r7, #0]
 8003922:	f103 0301 	add.w	r3, r3, #1
 8003926:	603b      	str	r3, [r7, #0]
  } while((StartUpCounter != HSE_STARTUP_TIMEOUT) && (HSEStatus == RESET));
 8003928:	683b      	ldr	r3, [r7, #0]
 800392a:	f5b3 6fa0 	cmp.w	r3, #1280	; 0x500
 800392e:	d002      	beq.n	8003936 <RCC_WaitForHSEStartUp+0x3a>
 8003930:	79bb      	ldrb	r3, [r7, #6]
 8003932:	2b00      	cmp	r3, #0
 8003934:	d0ee      	beq.n	8003914 <RCC_WaitForHSEStartUp+0x18>
  
  if (RCC_GetFlagStatus(RCC_FLAG_HSERDY) != RESET)
 8003936:	f04f 0031 	mov.w	r0, #49	; 0x31
 800393a:	f000 fbbd 	bl	80040b8 <RCC_GetFlagStatus>
 800393e:	4603      	mov	r3, r0
 8003940:	2b00      	cmp	r3, #0
 8003942:	d003      	beq.n	800394c <RCC_WaitForHSEStartUp+0x50>
  {
    status = SUCCESS;
 8003944:	f04f 0301 	mov.w	r3, #1
 8003948:	71fb      	strb	r3, [r7, #7]
 800394a:	e002      	b.n	8003952 <RCC_WaitForHSEStartUp+0x56>
  }
  else
  {
    status = ERROR;
 800394c:	f04f 0300 	mov.w	r3, #0
 8003950:	71fb      	strb	r3, [r7, #7]
  }  
  return (status);
 8003952:	79fb      	ldrb	r3, [r7, #7]
}
 8003954:	4618      	mov	r0, r3
 8003956:	f107 0708 	add.w	r7, r7, #8
 800395a:	46bd      	mov	sp, r7
 800395c:	bd80      	pop	{r7, pc}
 800395e:	bf00      	nop

08003960 <RCC_AdjustHSICalibrationValue>:
  * @param  HSICalibrationValue: specifies the calibration trimming value.
  *   This parameter must be a number between 0 and 0x1F.
  * @retval None
  */
void RCC_AdjustHSICalibrationValue(uint8_t HSICalibrationValue)
{
 8003960:	b480      	push	{r7}
 8003962:	b085      	sub	sp, #20
 8003964:	af00      	add	r7, sp, #0
 8003966:	4603      	mov	r3, r0
 8003968:	71fb      	strb	r3, [r7, #7]
  uint32_t tmpreg = 0;
 800396a:	f04f 0300 	mov.w	r3, #0
 800396e:	60fb      	str	r3, [r7, #12]
  /* Check the parameters */
  assert_param(IS_RCC_CALIBRATION_VALUE(HSICalibrationValue));
  tmpreg = RCC->CR;
 8003970:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003974:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003978:	681b      	ldr	r3, [r3, #0]
 800397a:	60fb      	str	r3, [r7, #12]
  /* Clear HSITRIM[4:0] bits */
  tmpreg &= CR_HSITRIM_Mask;
 800397c:	68fb      	ldr	r3, [r7, #12]
 800397e:	f023 03f8 	bic.w	r3, r3, #248	; 0xf8
 8003982:	60fb      	str	r3, [r7, #12]
  /* Set the HSITRIM[4:0] bits according to HSICalibrationValue value */
  tmpreg |= (uint32_t)HSICalibrationValue << 3;
 8003984:	79fb      	ldrb	r3, [r7, #7]
 8003986:	ea4f 03c3 	mov.w	r3, r3, lsl #3
 800398a:	68fa      	ldr	r2, [r7, #12]
 800398c:	4313      	orrs	r3, r2
 800398e:	60fb      	str	r3, [r7, #12]
  /* Store the new value */
  RCC->CR = tmpreg;
 8003990:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003994:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003998:	68fa      	ldr	r2, [r7, #12]
 800399a:	601a      	str	r2, [r3, #0]
}
 800399c:	f107 0714 	add.w	r7, r7, #20
 80039a0:	46bd      	mov	sp, r7
 80039a2:	bc80      	pop	{r7}
 80039a4:	4770      	bx	lr
 80039a6:	bf00      	nop

080039a8 <RCC_HSICmd>:
  * @note   HSI can not be stopped if it is used directly or through the PLL as system clock.
  * @param  NewState: new state of the HSI. This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_HSICmd(FunctionalState NewState)
{
 80039a8:	b480      	push	{r7}
 80039aa:	b083      	sub	sp, #12
 80039ac:	af00      	add	r7, sp, #0
 80039ae:	4603      	mov	r3, r0
 80039b0:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  *(__IO uint32_t *) CR_HSION_BB = (uint32_t)NewState;
 80039b2:	f04f 0300 	mov.w	r3, #0
 80039b6:	f2c4 2342 	movt	r3, #16962	; 0x4242
 80039ba:	79fa      	ldrb	r2, [r7, #7]
 80039bc:	601a      	str	r2, [r3, #0]
}
 80039be:	f107 070c 	add.w	r7, r7, #12
 80039c2:	46bd      	mov	sp, r7
 80039c4:	bc80      	pop	{r7}
 80039c6:	4770      	bx	lr

080039c8 <RCC_PLLConfig>:
  *   For @b STM32_Connectivity_line_devices, this parameter can be RCC_PLLMul_x where x:{[4,9], 6_5}
  *   For @b other_STM32_devices, this parameter can be RCC_PLLMul_x where x:[2,16]  
  * @retval None
  */
void RCC_PLLConfig(uint32_t RCC_PLLSource, uint32_t RCC_PLLMul)
{
 80039c8:	b480      	push	{r7}
 80039ca:	b085      	sub	sp, #20
 80039cc:	af00      	add	r7, sp, #0
 80039ce:	6078      	str	r0, [r7, #4]
 80039d0:	6039      	str	r1, [r7, #0]
  uint32_t tmpreg = 0;
 80039d2:	f04f 0300 	mov.w	r3, #0
 80039d6:	60fb      	str	r3, [r7, #12]

  /* Check the parameters */
  assert_param(IS_RCC_PLL_SOURCE(RCC_PLLSource));
  assert_param(IS_RCC_PLL_MUL(RCC_PLLMul));

  tmpreg = RCC->CFGR;
 80039d8:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80039dc:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80039e0:	685b      	ldr	r3, [r3, #4]
 80039e2:	60fb      	str	r3, [r7, #12]
  /* Clear PLLSRC, PLLXTPRE and PLLMUL[3:0] bits */
  tmpreg &= CFGR_PLL_Mask;
 80039e4:	68fb      	ldr	r3, [r7, #12]
 80039e6:	f423 137c 	bic.w	r3, r3, #4128768	; 0x3f0000
 80039ea:	60fb      	str	r3, [r7, #12]
  /* Set the PLL configuration bits */
  tmpreg |= RCC_PLLSource | RCC_PLLMul;
 80039ec:	687a      	ldr	r2, [r7, #4]
 80039ee:	683b      	ldr	r3, [r7, #0]
 80039f0:	4313      	orrs	r3, r2
 80039f2:	68fa      	ldr	r2, [r7, #12]
 80039f4:	4313      	orrs	r3, r2
 80039f6:	60fb      	str	r3, [r7, #12]
  /* Store the new value */
  RCC->CFGR = tmpreg;
 80039f8:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80039fc:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003a00:	68fa      	ldr	r2, [r7, #12]
 8003a02:	605a      	str	r2, [r3, #4]
}
 8003a04:	f107 0714 	add.w	r7, r7, #20
 8003a08:	46bd      	mov	sp, r7
 8003a0a:	bc80      	pop	{r7}
 8003a0c:	4770      	bx	lr
 8003a0e:	bf00      	nop

08003a10 <RCC_PLLCmd>:
  * @note   The PLL can not be disabled if it is used as system clock.
  * @param  NewState: new state of the PLL. This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_PLLCmd(FunctionalState NewState)
{
 8003a10:	b480      	push	{r7}
 8003a12:	b083      	sub	sp, #12
 8003a14:	af00      	add	r7, sp, #0
 8003a16:	4603      	mov	r3, r0
 8003a18:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));

  *(__IO uint32_t *) CR_PLLON_BB = (uint32_t)NewState;
 8003a1a:	f04f 0360 	mov.w	r3, #96	; 0x60
 8003a1e:	f2c4 2342 	movt	r3, #16962	; 0x4242
 8003a22:	79fa      	ldrb	r2, [r7, #7]
 8003a24:	601a      	str	r2, [r3, #0]
}
 8003a26:	f107 070c 	add.w	r7, r7, #12
 8003a2a:	46bd      	mov	sp, r7
 8003a2c:	bc80      	pop	{r7}
 8003a2e:	4770      	bx	lr

08003a30 <RCC_SYSCLKConfig>:
  *     @arg RCC_SYSCLKSource_HSE: HSE selected as system clock
  *     @arg RCC_SYSCLKSource_PLLCLK: PLL selected as system clock
  * @retval None
  */
void RCC_SYSCLKConfig(uint32_t RCC_SYSCLKSource)
{
 8003a30:	b480      	push	{r7}
 8003a32:	b085      	sub	sp, #20
 8003a34:	af00      	add	r7, sp, #0
 8003a36:	6078      	str	r0, [r7, #4]
  uint32_t tmpreg = 0;
 8003a38:	f04f 0300 	mov.w	r3, #0
 8003a3c:	60fb      	str	r3, [r7, #12]
  /* Check the parameters */
  assert_param(IS_RCC_SYSCLK_SOURCE(RCC_SYSCLKSource));
  tmpreg = RCC->CFGR;
 8003a3e:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003a42:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003a46:	685b      	ldr	r3, [r3, #4]
 8003a48:	60fb      	str	r3, [r7, #12]
  /* Clear SW[1:0] bits */
  tmpreg &= CFGR_SW_Mask;
 8003a4a:	68fb      	ldr	r3, [r7, #12]
 8003a4c:	f023 0303 	bic.w	r3, r3, #3
 8003a50:	60fb      	str	r3, [r7, #12]
  /* Set SW[1:0] bits according to RCC_SYSCLKSource value */
  tmpreg |= RCC_SYSCLKSource;
 8003a52:	68fa      	ldr	r2, [r7, #12]
 8003a54:	687b      	ldr	r3, [r7, #4]
 8003a56:	4313      	orrs	r3, r2
 8003a58:	60fb      	str	r3, [r7, #12]
  /* Store the new value */
  RCC->CFGR = tmpreg;
 8003a5a:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003a5e:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003a62:	68fa      	ldr	r2, [r7, #12]
 8003a64:	605a      	str	r2, [r3, #4]
}
 8003a66:	f107 0714 	add.w	r7, r7, #20
 8003a6a:	46bd      	mov	sp, r7
 8003a6c:	bc80      	pop	{r7}
 8003a6e:	4770      	bx	lr

08003a70 <RCC_GetSYSCLKSource>:
  *     - 0x00: HSI used as system clock
  *     - 0x04: HSE used as system clock
  *     - 0x08: PLL used as system clock
  */
uint8_t RCC_GetSYSCLKSource(void)
{
 8003a70:	b480      	push	{r7}
 8003a72:	af00      	add	r7, sp, #0
  return ((uint8_t)(RCC->CFGR & CFGR_SWS_Mask));
 8003a74:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003a78:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003a7c:	685b      	ldr	r3, [r3, #4]
 8003a7e:	b2db      	uxtb	r3, r3
 8003a80:	f003 030c 	and.w	r3, r3, #12
 8003a84:	b2db      	uxtb	r3, r3
}
 8003a86:	4618      	mov	r0, r3
 8003a88:	46bd      	mov	sp, r7
 8003a8a:	bc80      	pop	{r7}
 8003a8c:	4770      	bx	lr
 8003a8e:	bf00      	nop

08003a90 <RCC_HCLKConfig>:
  *     @arg RCC_SYSCLK_Div256: AHB clock = SYSCLK/256
  *     @arg RCC_SYSCLK_Div512: AHB clock = SYSCLK/512
  * @retval None
  */
void RCC_HCLKConfig(uint32_t RCC_SYSCLK)
{
 8003a90:	b480      	push	{r7}
 8003a92:	b085      	sub	sp, #20
 8003a94:	af00      	add	r7, sp, #0
 8003a96:	6078      	str	r0, [r7, #4]
  uint32_t tmpreg = 0;
 8003a98:	f04f 0300 	mov.w	r3, #0
 8003a9c:	60fb      	str	r3, [r7, #12]
  /* Check the parameters */
  assert_param(IS_RCC_HCLK(RCC_SYSCLK));
  tmpreg = RCC->CFGR;
 8003a9e:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003aa2:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003aa6:	685b      	ldr	r3, [r3, #4]
 8003aa8:	60fb      	str	r3, [r7, #12]
  /* Clear HPRE[3:0] bits */
  tmpreg &= CFGR_HPRE_Reset_Mask;
 8003aaa:	68fb      	ldr	r3, [r7, #12]
 8003aac:	f023 03f0 	bic.w	r3, r3, #240	; 0xf0
 8003ab0:	60fb      	str	r3, [r7, #12]
  /* Set HPRE[3:0] bits according to RCC_SYSCLK value */
  tmpreg |= RCC_SYSCLK;
 8003ab2:	68fa      	ldr	r2, [r7, #12]
 8003ab4:	687b      	ldr	r3, [r7, #4]
 8003ab6:	4313      	orrs	r3, r2
 8003ab8:	60fb      	str	r3, [r7, #12]
  /* Store the new value */
  RCC->CFGR = tmpreg;
 8003aba:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003abe:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003ac2:	68fa      	ldr	r2, [r7, #12]
 8003ac4:	605a      	str	r2, [r3, #4]
}
 8003ac6:	f107 0714 	add.w	r7, r7, #20
 8003aca:	46bd      	mov	sp, r7
 8003acc:	bc80      	pop	{r7}
 8003ace:	4770      	bx	lr

08003ad0 <RCC_PCLK1Config>:
  *     @arg RCC_HCLK_Div8: APB1 clock = HCLK/8
  *     @arg RCC_HCLK_Div16: APB1 clock = HCLK/16
  * @retval None
  */
void RCC_PCLK1Config(uint32_t RCC_HCLK)
{
 8003ad0:	b480      	push	{r7}
 8003ad2:	b085      	sub	sp, #20
 8003ad4:	af00      	add	r7, sp, #0
 8003ad6:	6078      	str	r0, [r7, #4]
  uint32_t tmpreg = 0;
 8003ad8:	f04f 0300 	mov.w	r3, #0
 8003adc:	60fb      	str	r3, [r7, #12]
  /* Check the parameters */
  assert_param(IS_RCC_PCLK(RCC_HCLK));
  tmpreg = RCC->CFGR;
 8003ade:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003ae2:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003ae6:	685b      	ldr	r3, [r3, #4]
 8003ae8:	60fb      	str	r3, [r7, #12]
  /* Clear PPRE1[2:0] bits */
  tmpreg &= CFGR_PPRE1_Reset_Mask;
 8003aea:	68fb      	ldr	r3, [r7, #12]
 8003aec:	f423 63e0 	bic.w	r3, r3, #1792	; 0x700
 8003af0:	60fb      	str	r3, [r7, #12]
  /* Set PPRE1[2:0] bits according to RCC_HCLK value */
  tmpreg |= RCC_HCLK;
 8003af2:	68fa      	ldr	r2, [r7, #12]
 8003af4:	687b      	ldr	r3, [r7, #4]
 8003af6:	4313      	orrs	r3, r2
 8003af8:	60fb      	str	r3, [r7, #12]
  /* Store the new value */
  RCC->CFGR = tmpreg;
 8003afa:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003afe:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003b02:	68fa      	ldr	r2, [r7, #12]
 8003b04:	605a      	str	r2, [r3, #4]
}
 8003b06:	f107 0714 	add.w	r7, r7, #20
 8003b0a:	46bd      	mov	sp, r7
 8003b0c:	bc80      	pop	{r7}
 8003b0e:	4770      	bx	lr

08003b10 <RCC_PCLK2Config>:
  *     @arg RCC_HCLK_Div8: APB2 clock = HCLK/8
  *     @arg RCC_HCLK_Div16: APB2 clock = HCLK/16
  * @retval None
  */
void RCC_PCLK2Config(uint32_t RCC_HCLK)
{
 8003b10:	b480      	push	{r7}
 8003b12:	b085      	sub	sp, #20
 8003b14:	af00      	add	r7, sp, #0
 8003b16:	6078      	str	r0, [r7, #4]
  uint32_t tmpreg = 0;
 8003b18:	f04f 0300 	mov.w	r3, #0
 8003b1c:	60fb      	str	r3, [r7, #12]
  /* Check the parameters */
  assert_param(IS_RCC_PCLK(RCC_HCLK));
  tmpreg = RCC->CFGR;
 8003b1e:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003b22:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003b26:	685b      	ldr	r3, [r3, #4]
 8003b28:	60fb      	str	r3, [r7, #12]
  /* Clear PPRE2[2:0] bits */
  tmpreg &= CFGR_PPRE2_Reset_Mask;
 8003b2a:	68fb      	ldr	r3, [r7, #12]
 8003b2c:	f423 5360 	bic.w	r3, r3, #14336	; 0x3800
 8003b30:	60fb      	str	r3, [r7, #12]
  /* Set PPRE2[2:0] bits according to RCC_HCLK value */
  tmpreg |= RCC_HCLK << 3;
 8003b32:	687b      	ldr	r3, [r7, #4]
 8003b34:	ea4f 03c3 	mov.w	r3, r3, lsl #3
 8003b38:	68fa      	ldr	r2, [r7, #12]
 8003b3a:	4313      	orrs	r3, r2
 8003b3c:	60fb      	str	r3, [r7, #12]
  /* Store the new value */
  RCC->CFGR = tmpreg;
 8003b3e:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003b42:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003b46:	68fa      	ldr	r2, [r7, #12]
 8003b48:	605a      	str	r2, [r3, #4]
}
 8003b4a:	f107 0714 	add.w	r7, r7, #20
 8003b4e:	46bd      	mov	sp, r7
 8003b50:	bc80      	pop	{r7}
 8003b52:	4770      	bx	lr

08003b54 <RCC_ITConfig>:
  * @param  NewState: new state of the specified RCC interrupts.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_ITConfig(uint8_t RCC_IT, FunctionalState NewState)
{
 8003b54:	b480      	push	{r7}
 8003b56:	b083      	sub	sp, #12
 8003b58:	af00      	add	r7, sp, #0
 8003b5a:	4602      	mov	r2, r0
 8003b5c:	460b      	mov	r3, r1
 8003b5e:	71fa      	strb	r2, [r7, #7]
 8003b60:	71bb      	strb	r3, [r7, #6]
  /* Check the parameters */
  assert_param(IS_RCC_IT(RCC_IT));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
 8003b62:	79bb      	ldrb	r3, [r7, #6]
 8003b64:	2b00      	cmp	r3, #0
 8003b66:	d00e      	beq.n	8003b86 <RCC_ITConfig+0x32>
  {
    /* Perform Byte access to RCC_CIR bits to enable the selected interrupts */
    *(__IO uint8_t *) CIR_BYTE2_ADDRESS |= RCC_IT;
 8003b68:	f241 0309 	movw	r3, #4105	; 0x1009
 8003b6c:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003b70:	f241 0209 	movw	r2, #4105	; 0x1009
 8003b74:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003b78:	7812      	ldrb	r2, [r2, #0]
 8003b7a:	b2d1      	uxtb	r1, r2
 8003b7c:	79fa      	ldrb	r2, [r7, #7]
 8003b7e:	430a      	orrs	r2, r1
 8003b80:	b2d2      	uxtb	r2, r2
 8003b82:	701a      	strb	r2, [r3, #0]
 8003b84:	e010      	b.n	8003ba8 <RCC_ITConfig+0x54>
  }
  else
  {
    /* Perform Byte access to RCC_CIR bits to disable the selected interrupts */
    *(__IO uint8_t *) CIR_BYTE2_ADDRESS &= (uint8_t)~RCC_IT;
 8003b86:	f241 0309 	movw	r3, #4105	; 0x1009
 8003b8a:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003b8e:	f241 0209 	movw	r2, #4105	; 0x1009
 8003b92:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003b96:	7812      	ldrb	r2, [r2, #0]
 8003b98:	b2d1      	uxtb	r1, r2
 8003b9a:	79fa      	ldrb	r2, [r7, #7]
 8003b9c:	ea6f 0202 	mvn.w	r2, r2
 8003ba0:	b2d2      	uxtb	r2, r2
 8003ba2:	400a      	ands	r2, r1
 8003ba4:	b2d2      	uxtb	r2, r2
 8003ba6:	701a      	strb	r2, [r3, #0]
  }
}
 8003ba8:	f107 070c 	add.w	r7, r7, #12
 8003bac:	46bd      	mov	sp, r7
 8003bae:	bc80      	pop	{r7}
 8003bb0:	4770      	bx	lr
 8003bb2:	bf00      	nop

08003bb4 <RCC_USBCLKConfig>:
  *                                     clock source
  *     @arg RCC_USBCLKSource_PLLCLK_Div1: PLL clock selected as USB clock source
  * @retval None
  */
void RCC_USBCLKConfig(uint32_t RCC_USBCLKSource)
{
 8003bb4:	b480      	push	{r7}
 8003bb6:	b083      	sub	sp, #12
 8003bb8:	af00      	add	r7, sp, #0
 8003bba:	6078      	str	r0, [r7, #4]
  /* Check the parameters */
  assert_param(IS_RCC_USBCLK_SOURCE(RCC_USBCLKSource));

  *(__IO uint32_t *) CFGR_USBPRE_BB = RCC_USBCLKSource;
 8003bbc:	f04f 03d8 	mov.w	r3, #216	; 0xd8
 8003bc0:	f2c4 2342 	movt	r3, #16962	; 0x4242
 8003bc4:	687a      	ldr	r2, [r7, #4]
 8003bc6:	601a      	str	r2, [r3, #0]
}
 8003bc8:	f107 070c 	add.w	r7, r7, #12
 8003bcc:	46bd      	mov	sp, r7
 8003bce:	bc80      	pop	{r7}
 8003bd0:	4770      	bx	lr
 8003bd2:	bf00      	nop

08003bd4 <RCC_ADCCLKConfig>:
  *     @arg RCC_PCLK2_Div6: ADC clock = PCLK2/6
  *     @arg RCC_PCLK2_Div8: ADC clock = PCLK2/8
  * @retval None
  */
void RCC_ADCCLKConfig(uint32_t RCC_PCLK2)
{
 8003bd4:	b480      	push	{r7}
 8003bd6:	b085      	sub	sp, #20
 8003bd8:	af00      	add	r7, sp, #0
 8003bda:	6078      	str	r0, [r7, #4]
  uint32_t tmpreg = 0;
 8003bdc:	f04f 0300 	mov.w	r3, #0
 8003be0:	60fb      	str	r3, [r7, #12]
  /* Check the parameters */
  assert_param(IS_RCC_ADCCLK(RCC_PCLK2));
  tmpreg = RCC->CFGR;
 8003be2:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003be6:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003bea:	685b      	ldr	r3, [r3, #4]
 8003bec:	60fb      	str	r3, [r7, #12]
  /* Clear ADCPRE[1:0] bits */
  tmpreg &= CFGR_ADCPRE_Reset_Mask;
 8003bee:	68fb      	ldr	r3, [r7, #12]
 8003bf0:	f423 4340 	bic.w	r3, r3, #49152	; 0xc000
 8003bf4:	60fb      	str	r3, [r7, #12]
  /* Set ADCPRE[1:0] bits according to RCC_PCLK2 value */
  tmpreg |= RCC_PCLK2;
 8003bf6:	68fa      	ldr	r2, [r7, #12]
 8003bf8:	687b      	ldr	r3, [r7, #4]
 8003bfa:	4313      	orrs	r3, r2
 8003bfc:	60fb      	str	r3, [r7, #12]
  /* Store the new value */
  RCC->CFGR = tmpreg;
 8003bfe:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003c02:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003c06:	68fa      	ldr	r2, [r7, #12]
 8003c08:	605a      	str	r2, [r3, #4]
}
 8003c0a:	f107 0714 	add.w	r7, r7, #20
 8003c0e:	46bd      	mov	sp, r7
 8003c10:	bc80      	pop	{r7}
 8003c12:	4770      	bx	lr

08003c14 <RCC_LSEConfig>:
  *     @arg RCC_LSE_ON: LSE oscillator ON
  *     @arg RCC_LSE_Bypass: LSE oscillator bypassed with external clock
  * @retval None
  */
void RCC_LSEConfig(uint8_t RCC_LSE)
{
 8003c14:	b480      	push	{r7}
 8003c16:	b083      	sub	sp, #12
 8003c18:	af00      	add	r7, sp, #0
 8003c1a:	4603      	mov	r3, r0
 8003c1c:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_RCC_LSE(RCC_LSE));
  /* Reset LSEON and LSEBYP bits before configuring the LSE ------------------*/
  /* Reset LSEON bit */
  *(__IO uint8_t *) BDCR_ADDRESS = RCC_LSE_OFF;
 8003c1e:	f44f 5381 	mov.w	r3, #4128	; 0x1020
 8003c22:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003c26:	f04f 0200 	mov.w	r2, #0
 8003c2a:	701a      	strb	r2, [r3, #0]
  /* Reset LSEBYP bit */
  *(__IO uint8_t *) BDCR_ADDRESS = RCC_LSE_OFF;
 8003c2c:	f44f 5381 	mov.w	r3, #4128	; 0x1020
 8003c30:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003c34:	f04f 0200 	mov.w	r2, #0
 8003c38:	701a      	strb	r2, [r3, #0]
  /* Configure LSE (RCC_LSE_OFF is already covered by the code section above) */
  switch(RCC_LSE)
 8003c3a:	79fb      	ldrb	r3, [r7, #7]
 8003c3c:	2b01      	cmp	r3, #1
 8003c3e:	d002      	beq.n	8003c46 <RCC_LSEConfig+0x32>
 8003c40:	2b04      	cmp	r3, #4
 8003c42:	d008      	beq.n	8003c56 <RCC_LSEConfig+0x42>
 8003c44:	e00f      	b.n	8003c66 <RCC_LSEConfig+0x52>
  {
    case RCC_LSE_ON:
      /* Set LSEON bit */
      *(__IO uint8_t *) BDCR_ADDRESS = RCC_LSE_ON;
 8003c46:	f44f 5381 	mov.w	r3, #4128	; 0x1020
 8003c4a:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003c4e:	f04f 0201 	mov.w	r2, #1
 8003c52:	701a      	strb	r2, [r3, #0]
      break;
 8003c54:	e008      	b.n	8003c68 <RCC_LSEConfig+0x54>
      
    case RCC_LSE_Bypass:
      /* Set LSEBYP and LSEON bits */
      *(__IO uint8_t *) BDCR_ADDRESS = RCC_LSE_Bypass | RCC_LSE_ON;
 8003c56:	f44f 5381 	mov.w	r3, #4128	; 0x1020
 8003c5a:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003c5e:	f04f 0205 	mov.w	r2, #5
 8003c62:	701a      	strb	r2, [r3, #0]
      break;            
 8003c64:	e000      	b.n	8003c68 <RCC_LSEConfig+0x54>
      
    default:
      break;      
 8003c66:	bf00      	nop
  }
}
 8003c68:	f107 070c 	add.w	r7, r7, #12
 8003c6c:	46bd      	mov	sp, r7
 8003c6e:	bc80      	pop	{r7}
 8003c70:	4770      	bx	lr
 8003c72:	bf00      	nop

08003c74 <RCC_LSICmd>:
  * @note   LSI can not be disabled if the IWDG is running.
  * @param  NewState: new state of the LSI. This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_LSICmd(FunctionalState NewState)
{
 8003c74:	b480      	push	{r7}
 8003c76:	b083      	sub	sp, #12
 8003c78:	af00      	add	r7, sp, #0
 8003c7a:	4603      	mov	r3, r0
 8003c7c:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  *(__IO uint32_t *) CSR_LSION_BB = (uint32_t)NewState;
 8003c7e:	f44f 6390 	mov.w	r3, #1152	; 0x480
 8003c82:	f2c4 2342 	movt	r3, #16962	; 0x4242
 8003c86:	79fa      	ldrb	r2, [r7, #7]
 8003c88:	601a      	str	r2, [r3, #0]
}
 8003c8a:	f107 070c 	add.w	r7, r7, #12
 8003c8e:	46bd      	mov	sp, r7
 8003c90:	bc80      	pop	{r7}
 8003c92:	4770      	bx	lr

08003c94 <RCC_RTCCLKConfig>:
  *     @arg RCC_RTCCLKSource_LSI: LSI selected as RTC clock
  *     @arg RCC_RTCCLKSource_HSE_Div128: HSE clock divided by 128 selected as RTC clock
  * @retval None
  */
void RCC_RTCCLKConfig(uint32_t RCC_RTCCLKSource)
{
 8003c94:	b480      	push	{r7}
 8003c96:	b083      	sub	sp, #12
 8003c98:	af00      	add	r7, sp, #0
 8003c9a:	6078      	str	r0, [r7, #4]
  /* Check the parameters */
  assert_param(IS_RCC_RTCCLK_SOURCE(RCC_RTCCLKSource));
  /* Select the RTC clock source */
  RCC->BDCR |= RCC_RTCCLKSource;
 8003c9c:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003ca0:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003ca4:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003ca8:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003cac:	6a11      	ldr	r1, [r2, #32]
 8003cae:	687a      	ldr	r2, [r7, #4]
 8003cb0:	430a      	orrs	r2, r1
 8003cb2:	621a      	str	r2, [r3, #32]
}
 8003cb4:	f107 070c 	add.w	r7, r7, #12
 8003cb8:	46bd      	mov	sp, r7
 8003cba:	bc80      	pop	{r7}
 8003cbc:	4770      	bx	lr
 8003cbe:	bf00      	nop

08003cc0 <RCC_RTCCLKCmd>:
  * @note   This function must be used only after the RTC clock was selected using the RCC_RTCCLKConfig function.
  * @param  NewState: new state of the RTC clock. This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_RTCCLKCmd(FunctionalState NewState)
{
 8003cc0:	b480      	push	{r7}
 8003cc2:	b083      	sub	sp, #12
 8003cc4:	af00      	add	r7, sp, #0
 8003cc6:	4603      	mov	r3, r0
 8003cc8:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  *(__IO uint32_t *) BDCR_RTCEN_BB = (uint32_t)NewState;
 8003cca:	f240 433c 	movw	r3, #1084	; 0x43c
 8003cce:	f2c4 2342 	movt	r3, #16962	; 0x4242
 8003cd2:	79fa      	ldrb	r2, [r7, #7]
 8003cd4:	601a      	str	r2, [r3, #0]
}
 8003cd6:	f107 070c 	add.w	r7, r7, #12
 8003cda:	46bd      	mov	sp, r7
 8003cdc:	bc80      	pop	{r7}
 8003cde:	4770      	bx	lr

08003ce0 <RCC_GetClocksFreq>:
  * @note   The result of this function could be not correct when using 
  *         fractional value for HSE crystal.  
  * @retval None
  */
void RCC_GetClocksFreq(RCC_ClocksTypeDef* RCC_Clocks)
{
 8003ce0:	b480      	push	{r7}
 8003ce2:	b087      	sub	sp, #28
 8003ce4:	af00      	add	r7, sp, #0
 8003ce6:	6078      	str	r0, [r7, #4]
  uint32_t tmp = 0, pllmull = 0, pllsource = 0, presc = 0;
 8003ce8:	f04f 0300 	mov.w	r3, #0
 8003cec:	617b      	str	r3, [r7, #20]
 8003cee:	f04f 0300 	mov.w	r3, #0
 8003cf2:	613b      	str	r3, [r7, #16]
 8003cf4:	f04f 0300 	mov.w	r3, #0
 8003cf8:	60fb      	str	r3, [r7, #12]
 8003cfa:	f04f 0300 	mov.w	r3, #0
 8003cfe:	60bb      	str	r3, [r7, #8]
#if defined (STM32F10X_LD_VL) || defined (STM32F10X_MD_VL) || defined (STM32F10X_HD_VL)
  uint32_t prediv1factor = 0;
#endif
    
  /* Get SYSCLK source -------------------------------------------------------*/
  tmp = RCC->CFGR & CFGR_SWS_Mask;
 8003d00:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003d04:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003d08:	685b      	ldr	r3, [r3, #4]
 8003d0a:	f003 030c 	and.w	r3, r3, #12
 8003d0e:	617b      	str	r3, [r7, #20]
  
  switch (tmp)
 8003d10:	697b      	ldr	r3, [r7, #20]
 8003d12:	2b04      	cmp	r3, #4
 8003d14:	d00a      	beq.n	8003d2c <RCC_GetClocksFreq+0x4c>
 8003d16:	2b08      	cmp	r3, #8
 8003d18:	d00f      	beq.n	8003d3a <RCC_GetClocksFreq+0x5a>
 8003d1a:	2b00      	cmp	r3, #0
 8003d1c:	d14d      	bne.n	8003dba <RCC_GetClocksFreq+0xda>
  {
    case 0x00:  /* HSI used as system clock */
      RCC_Clocks->SYSCLK_Frequency = HSI_VALUE;
 8003d1e:	687a      	ldr	r2, [r7, #4]
 8003d20:	f44f 5390 	mov.w	r3, #4608	; 0x1200
 8003d24:	f2c0 037a 	movt	r3, #122	; 0x7a
 8003d28:	6013      	str	r3, [r2, #0]
      break;
 8003d2a:	e04d      	b.n	8003dc8 <RCC_GetClocksFreq+0xe8>
    case 0x04:  /* HSE used as system clock */
      RCC_Clocks->SYSCLK_Frequency = HSE_VALUE;
 8003d2c:	687a      	ldr	r2, [r7, #4]
 8003d2e:	f44f 5390 	mov.w	r3, #4608	; 0x1200
 8003d32:	f2c0 037a 	movt	r3, #122	; 0x7a
 8003d36:	6013      	str	r3, [r2, #0]
      break;
 8003d38:	e046      	b.n	8003dc8 <RCC_GetClocksFreq+0xe8>
    case 0x08:  /* PLL used as system clock */

      /* Get PLL clock source and multiplication factor ----------------------*/
      pllmull = RCC->CFGR & CFGR_PLLMull_Mask;
 8003d3a:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003d3e:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003d42:	685b      	ldr	r3, [r3, #4]
 8003d44:	f403 1370 	and.w	r3, r3, #3932160	; 0x3c0000
 8003d48:	613b      	str	r3, [r7, #16]
      pllsource = RCC->CFGR & CFGR_PLLSRC_Mask;
 8003d4a:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003d4e:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003d52:	685b      	ldr	r3, [r3, #4]
 8003d54:	f403 3380 	and.w	r3, r3, #65536	; 0x10000
 8003d58:	60fb      	str	r3, [r7, #12]
      
#ifndef STM32F10X_CL      
      pllmull = ( pllmull >> 18) + 2;
 8003d5a:	693b      	ldr	r3, [r7, #16]
 8003d5c:	ea4f 4393 	mov.w	r3, r3, lsr #18
 8003d60:	f103 0302 	add.w	r3, r3, #2
 8003d64:	613b      	str	r3, [r7, #16]
      
      if (pllsource == 0x00)
 8003d66:	68fb      	ldr	r3, [r7, #12]
 8003d68:	2b00      	cmp	r3, #0
 8003d6a:	d109      	bne.n	8003d80 <RCC_GetClocksFreq+0xa0>
      {/* HSI oscillator clock divided by 2 selected as PLL clock entry */
        RCC_Clocks->SYSCLK_Frequency = (HSI_VALUE >> 1) * pllmull;
 8003d6c:	693a      	ldr	r2, [r7, #16]
 8003d6e:	f44f 6310 	mov.w	r3, #2304	; 0x900
 8003d72:	f2c0 033d 	movt	r3, #61	; 0x3d
 8003d76:	fb03 f202 	mul.w	r2, r3, r2
 8003d7a:	687b      	ldr	r3, [r7, #4]
 8003d7c:	601a      	str	r2, [r3, #0]
          pll2mull = ((RCC->CFGR2 & CFGR2_PLL2MUL) >> 8 ) + 2; 
          RCC_Clocks->SYSCLK_Frequency = (((HSE_VALUE / prediv2factor) * pll2mull) / prediv1factor) * pllmull;                         
        }
      }
#endif /* STM32F10X_CL */ 
      break;
 8003d7e:	e023      	b.n	8003dc8 <RCC_GetClocksFreq+0xe8>
       prediv1factor = (RCC->CFGR2 & CFGR2_PREDIV1) + 1;
       /* HSE oscillator clock selected as PREDIV1 clock entry */
       RCC_Clocks->SYSCLK_Frequency = (HSE_VALUE / prediv1factor) * pllmull; 
 #else
        /* HSE selected as PLL clock entry */
        if ((RCC->CFGR & CFGR_PLLXTPRE_Mask) != (uint32_t)RESET)
 8003d80:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003d84:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003d88:	685b      	ldr	r3, [r3, #4]
 8003d8a:	f403 3300 	and.w	r3, r3, #131072	; 0x20000
 8003d8e:	2b00      	cmp	r3, #0
 8003d90:	d009      	beq.n	8003da6 <RCC_GetClocksFreq+0xc6>
        {/* HSE oscillator clock divided by 2 */
          RCC_Clocks->SYSCLK_Frequency = (HSE_VALUE >> 1) * pllmull;
 8003d92:	693a      	ldr	r2, [r7, #16]
 8003d94:	f44f 6310 	mov.w	r3, #2304	; 0x900
 8003d98:	f2c0 033d 	movt	r3, #61	; 0x3d
 8003d9c:	fb03 f202 	mul.w	r2, r3, r2
 8003da0:	687b      	ldr	r3, [r7, #4]
 8003da2:	601a      	str	r2, [r3, #0]
          pll2mull = ((RCC->CFGR2 & CFGR2_PLL2MUL) >> 8 ) + 2; 
          RCC_Clocks->SYSCLK_Frequency = (((HSE_VALUE / prediv2factor) * pll2mull) / prediv1factor) * pllmull;                         
        }
      }
#endif /* STM32F10X_CL */ 
      break;
 8003da4:	e010      	b.n	8003dc8 <RCC_GetClocksFreq+0xe8>
        {/* HSE oscillator clock divided by 2 */
          RCC_Clocks->SYSCLK_Frequency = (HSE_VALUE >> 1) * pllmull;
        }
        else
        {
          RCC_Clocks->SYSCLK_Frequency = HSE_VALUE * pllmull;
 8003da6:	693a      	ldr	r2, [r7, #16]
 8003da8:	f44f 5390 	mov.w	r3, #4608	; 0x1200
 8003dac:	f2c0 037a 	movt	r3, #122	; 0x7a
 8003db0:	fb03 f202 	mul.w	r2, r3, r2
 8003db4:	687b      	ldr	r3, [r7, #4]
 8003db6:	601a      	str	r2, [r3, #0]
          pll2mull = ((RCC->CFGR2 & CFGR2_PLL2MUL) >> 8 ) + 2; 
          RCC_Clocks->SYSCLK_Frequency = (((HSE_VALUE / prediv2factor) * pll2mull) / prediv1factor) * pllmull;                         
        }
      }
#endif /* STM32F10X_CL */ 
      break;
 8003db8:	e006      	b.n	8003dc8 <RCC_GetClocksFreq+0xe8>

    default:
      RCC_Clocks->SYSCLK_Frequency = HSI_VALUE;
 8003dba:	687a      	ldr	r2, [r7, #4]
 8003dbc:	f44f 5390 	mov.w	r3, #4608	; 0x1200
 8003dc0:	f2c0 037a 	movt	r3, #122	; 0x7a
 8003dc4:	6013      	str	r3, [r2, #0]
      break;
 8003dc6:	bf00      	nop
  }

  /* Compute HCLK, PCLK1, PCLK2 and ADCCLK clocks frequencies ----------------*/
  /* Get HCLK prescaler */
  tmp = RCC->CFGR & CFGR_HPRE_Set_Mask;
 8003dc8:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003dcc:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003dd0:	685b      	ldr	r3, [r3, #4]
 8003dd2:	f003 03f0 	and.w	r3, r3, #240	; 0xf0
 8003dd6:	617b      	str	r3, [r7, #20]
  tmp = tmp >> 4;
 8003dd8:	697b      	ldr	r3, [r7, #20]
 8003dda:	ea4f 1313 	mov.w	r3, r3, lsr #4
 8003dde:	617b      	str	r3, [r7, #20]
  presc = APBAHBPrescTable[tmp];
 8003de0:	f240 0314 	movw	r3, #20
 8003de4:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8003de8:	697a      	ldr	r2, [r7, #20]
 8003dea:	189b      	adds	r3, r3, r2
 8003dec:	781b      	ldrb	r3, [r3, #0]
 8003dee:	b2db      	uxtb	r3, r3
 8003df0:	60bb      	str	r3, [r7, #8]
  /* HCLK clock frequency */
  RCC_Clocks->HCLK_Frequency = RCC_Clocks->SYSCLK_Frequency >> presc;
 8003df2:	687b      	ldr	r3, [r7, #4]
 8003df4:	681a      	ldr	r2, [r3, #0]
 8003df6:	68bb      	ldr	r3, [r7, #8]
 8003df8:	fa22 f203 	lsr.w	r2, r2, r3
 8003dfc:	687b      	ldr	r3, [r7, #4]
 8003dfe:	605a      	str	r2, [r3, #4]
  /* Get PCLK1 prescaler */
  tmp = RCC->CFGR & CFGR_PPRE1_Set_Mask;
 8003e00:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003e04:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003e08:	685b      	ldr	r3, [r3, #4]
 8003e0a:	f403 63e0 	and.w	r3, r3, #1792	; 0x700
 8003e0e:	617b      	str	r3, [r7, #20]
  tmp = tmp >> 8;
 8003e10:	697b      	ldr	r3, [r7, #20]
 8003e12:	ea4f 2313 	mov.w	r3, r3, lsr #8
 8003e16:	617b      	str	r3, [r7, #20]
  presc = APBAHBPrescTable[tmp];
 8003e18:	f240 0314 	movw	r3, #20
 8003e1c:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8003e20:	697a      	ldr	r2, [r7, #20]
 8003e22:	189b      	adds	r3, r3, r2
 8003e24:	781b      	ldrb	r3, [r3, #0]
 8003e26:	b2db      	uxtb	r3, r3
 8003e28:	60bb      	str	r3, [r7, #8]
  /* PCLK1 clock frequency */
  RCC_Clocks->PCLK1_Frequency = RCC_Clocks->HCLK_Frequency >> presc;
 8003e2a:	687b      	ldr	r3, [r7, #4]
 8003e2c:	685a      	ldr	r2, [r3, #4]
 8003e2e:	68bb      	ldr	r3, [r7, #8]
 8003e30:	fa22 f203 	lsr.w	r2, r2, r3
 8003e34:	687b      	ldr	r3, [r7, #4]
 8003e36:	609a      	str	r2, [r3, #8]
  /* Get PCLK2 prescaler */
  tmp = RCC->CFGR & CFGR_PPRE2_Set_Mask;
 8003e38:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003e3c:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003e40:	685b      	ldr	r3, [r3, #4]
 8003e42:	f403 5360 	and.w	r3, r3, #14336	; 0x3800
 8003e46:	617b      	str	r3, [r7, #20]
  tmp = tmp >> 11;
 8003e48:	697b      	ldr	r3, [r7, #20]
 8003e4a:	ea4f 23d3 	mov.w	r3, r3, lsr #11
 8003e4e:	617b      	str	r3, [r7, #20]
  presc = APBAHBPrescTable[tmp];
 8003e50:	f240 0314 	movw	r3, #20
 8003e54:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8003e58:	697a      	ldr	r2, [r7, #20]
 8003e5a:	189b      	adds	r3, r3, r2
 8003e5c:	781b      	ldrb	r3, [r3, #0]
 8003e5e:	b2db      	uxtb	r3, r3
 8003e60:	60bb      	str	r3, [r7, #8]
  /* PCLK2 clock frequency */
  RCC_Clocks->PCLK2_Frequency = RCC_Clocks->HCLK_Frequency >> presc;
 8003e62:	687b      	ldr	r3, [r7, #4]
 8003e64:	685a      	ldr	r2, [r3, #4]
 8003e66:	68bb      	ldr	r3, [r7, #8]
 8003e68:	fa22 f203 	lsr.w	r2, r2, r3
 8003e6c:	687b      	ldr	r3, [r7, #4]
 8003e6e:	60da      	str	r2, [r3, #12]
  /* Get ADCCLK prescaler */
  tmp = RCC->CFGR & CFGR_ADCPRE_Set_Mask;
 8003e70:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003e74:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003e78:	685b      	ldr	r3, [r3, #4]
 8003e7a:	f403 4340 	and.w	r3, r3, #49152	; 0xc000
 8003e7e:	617b      	str	r3, [r7, #20]
  tmp = tmp >> 14;
 8003e80:	697b      	ldr	r3, [r7, #20]
 8003e82:	ea4f 3393 	mov.w	r3, r3, lsr #14
 8003e86:	617b      	str	r3, [r7, #20]
  presc = ADCPrescTable[tmp];
 8003e88:	f240 0324 	movw	r3, #36	; 0x24
 8003e8c:	f2c2 0300 	movt	r3, #8192	; 0x2000
 8003e90:	697a      	ldr	r2, [r7, #20]
 8003e92:	189b      	adds	r3, r3, r2
 8003e94:	781b      	ldrb	r3, [r3, #0]
 8003e96:	b2db      	uxtb	r3, r3
 8003e98:	60bb      	str	r3, [r7, #8]
  /* ADCCLK clock frequency */
  RCC_Clocks->ADCCLK_Frequency = RCC_Clocks->PCLK2_Frequency / presc;
 8003e9a:	687b      	ldr	r3, [r7, #4]
 8003e9c:	68da      	ldr	r2, [r3, #12]
 8003e9e:	68bb      	ldr	r3, [r7, #8]
 8003ea0:	fbb2 f2f3 	udiv	r2, r2, r3
 8003ea4:	687b      	ldr	r3, [r7, #4]
 8003ea6:	611a      	str	r2, [r3, #16]
}
 8003ea8:	f107 071c 	add.w	r7, r7, #28
 8003eac:	46bd      	mov	sp, r7
 8003eae:	bc80      	pop	{r7}
 8003eb0:	4770      	bx	lr
 8003eb2:	bf00      	nop

08003eb4 <RCC_AHBPeriphClockCmd>:
  * @param  NewState: new state of the specified peripheral clock.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_AHBPeriphClockCmd(uint32_t RCC_AHBPeriph, FunctionalState NewState)
{
 8003eb4:	b480      	push	{r7}
 8003eb6:	b083      	sub	sp, #12
 8003eb8:	af00      	add	r7, sp, #0
 8003eba:	6078      	str	r0, [r7, #4]
 8003ebc:	460b      	mov	r3, r1
 8003ebe:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_RCC_AHB_PERIPH(RCC_AHBPeriph));
  assert_param(IS_FUNCTIONAL_STATE(NewState));

  if (NewState != DISABLE)
 8003ec0:	78fb      	ldrb	r3, [r7, #3]
 8003ec2:	2b00      	cmp	r3, #0
 8003ec4:	d00c      	beq.n	8003ee0 <RCC_AHBPeriphClockCmd+0x2c>
  {
    RCC->AHBENR |= RCC_AHBPeriph;
 8003ec6:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003eca:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003ece:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003ed2:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003ed6:	6951      	ldr	r1, [r2, #20]
 8003ed8:	687a      	ldr	r2, [r7, #4]
 8003eda:	430a      	orrs	r2, r1
 8003edc:	615a      	str	r2, [r3, #20]
 8003ede:	e00d      	b.n	8003efc <RCC_AHBPeriphClockCmd+0x48>
  }
  else
  {
    RCC->AHBENR &= ~RCC_AHBPeriph;
 8003ee0:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003ee4:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003ee8:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003eec:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003ef0:	6951      	ldr	r1, [r2, #20]
 8003ef2:	687a      	ldr	r2, [r7, #4]
 8003ef4:	ea6f 0202 	mvn.w	r2, r2
 8003ef8:	400a      	ands	r2, r1
 8003efa:	615a      	str	r2, [r3, #20]
  }
}
 8003efc:	f107 070c 	add.w	r7, r7, #12
 8003f00:	46bd      	mov	sp, r7
 8003f02:	bc80      	pop	{r7}
 8003f04:	4770      	bx	lr
 8003f06:	bf00      	nop

08003f08 <RCC_APB2PeriphClockCmd>:
  * @param  NewState: new state of the specified peripheral clock.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_APB2PeriphClockCmd(uint32_t RCC_APB2Periph, FunctionalState NewState)
{
 8003f08:	b480      	push	{r7}
 8003f0a:	b083      	sub	sp, #12
 8003f0c:	af00      	add	r7, sp, #0
 8003f0e:	6078      	str	r0, [r7, #4]
 8003f10:	460b      	mov	r3, r1
 8003f12:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
 8003f14:	78fb      	ldrb	r3, [r7, #3]
 8003f16:	2b00      	cmp	r3, #0
 8003f18:	d00c      	beq.n	8003f34 <RCC_APB2PeriphClockCmd+0x2c>
  {
    RCC->APB2ENR |= RCC_APB2Periph;
 8003f1a:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003f1e:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003f22:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003f26:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003f2a:	6991      	ldr	r1, [r2, #24]
 8003f2c:	687a      	ldr	r2, [r7, #4]
 8003f2e:	430a      	orrs	r2, r1
 8003f30:	619a      	str	r2, [r3, #24]
 8003f32:	e00d      	b.n	8003f50 <RCC_APB2PeriphClockCmd+0x48>
  }
  else
  {
    RCC->APB2ENR &= ~RCC_APB2Periph;
 8003f34:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003f38:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003f3c:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003f40:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003f44:	6991      	ldr	r1, [r2, #24]
 8003f46:	687a      	ldr	r2, [r7, #4]
 8003f48:	ea6f 0202 	mvn.w	r2, r2
 8003f4c:	400a      	ands	r2, r1
 8003f4e:	619a      	str	r2, [r3, #24]
  }
}
 8003f50:	f107 070c 	add.w	r7, r7, #12
 8003f54:	46bd      	mov	sp, r7
 8003f56:	bc80      	pop	{r7}
 8003f58:	4770      	bx	lr
 8003f5a:	bf00      	nop

08003f5c <RCC_APB1PeriphClockCmd>:
  * @param  NewState: new state of the specified peripheral clock.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_APB1PeriphClockCmd(uint32_t RCC_APB1Periph, FunctionalState NewState)
{
 8003f5c:	b480      	push	{r7}
 8003f5e:	b083      	sub	sp, #12
 8003f60:	af00      	add	r7, sp, #0
 8003f62:	6078      	str	r0, [r7, #4]
 8003f64:	460b      	mov	r3, r1
 8003f66:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
 8003f68:	78fb      	ldrb	r3, [r7, #3]
 8003f6a:	2b00      	cmp	r3, #0
 8003f6c:	d00c      	beq.n	8003f88 <RCC_APB1PeriphClockCmd+0x2c>
  {
    RCC->APB1ENR |= RCC_APB1Periph;
 8003f6e:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003f72:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003f76:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003f7a:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003f7e:	69d1      	ldr	r1, [r2, #28]
 8003f80:	687a      	ldr	r2, [r7, #4]
 8003f82:	430a      	orrs	r2, r1
 8003f84:	61da      	str	r2, [r3, #28]
 8003f86:	e00d      	b.n	8003fa4 <RCC_APB1PeriphClockCmd+0x48>
  }
  else
  {
    RCC->APB1ENR &= ~RCC_APB1Periph;
 8003f88:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003f8c:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003f90:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003f94:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003f98:	69d1      	ldr	r1, [r2, #28]
 8003f9a:	687a      	ldr	r2, [r7, #4]
 8003f9c:	ea6f 0202 	mvn.w	r2, r2
 8003fa0:	400a      	ands	r2, r1
 8003fa2:	61da      	str	r2, [r3, #28]
  }
}
 8003fa4:	f107 070c 	add.w	r7, r7, #12
 8003fa8:	46bd      	mov	sp, r7
 8003faa:	bc80      	pop	{r7}
 8003fac:	4770      	bx	lr
 8003fae:	bf00      	nop

08003fb0 <RCC_APB2PeriphResetCmd>:
  * @param  NewState: new state of the specified peripheral reset.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_APB2PeriphResetCmd(uint32_t RCC_APB2Periph, FunctionalState NewState)
{
 8003fb0:	b480      	push	{r7}
 8003fb2:	b083      	sub	sp, #12
 8003fb4:	af00      	add	r7, sp, #0
 8003fb6:	6078      	str	r0, [r7, #4]
 8003fb8:	460b      	mov	r3, r1
 8003fba:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_RCC_APB2_PERIPH(RCC_APB2Periph));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
 8003fbc:	78fb      	ldrb	r3, [r7, #3]
 8003fbe:	2b00      	cmp	r3, #0
 8003fc0:	d00c      	beq.n	8003fdc <RCC_APB2PeriphResetCmd+0x2c>
  {
    RCC->APB2RSTR |= RCC_APB2Periph;
 8003fc2:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003fc6:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003fca:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003fce:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003fd2:	68d1      	ldr	r1, [r2, #12]
 8003fd4:	687a      	ldr	r2, [r7, #4]
 8003fd6:	430a      	orrs	r2, r1
 8003fd8:	60da      	str	r2, [r3, #12]
 8003fda:	e00d      	b.n	8003ff8 <RCC_APB2PeriphResetCmd+0x48>
  }
  else
  {
    RCC->APB2RSTR &= ~RCC_APB2Periph;
 8003fdc:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8003fe0:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8003fe4:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8003fe8:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8003fec:	68d1      	ldr	r1, [r2, #12]
 8003fee:	687a      	ldr	r2, [r7, #4]
 8003ff0:	ea6f 0202 	mvn.w	r2, r2
 8003ff4:	400a      	ands	r2, r1
 8003ff6:	60da      	str	r2, [r3, #12]
  }
}
 8003ff8:	f107 070c 	add.w	r7, r7, #12
 8003ffc:	46bd      	mov	sp, r7
 8003ffe:	bc80      	pop	{r7}
 8004000:	4770      	bx	lr
 8004002:	bf00      	nop

08004004 <RCC_APB1PeriphResetCmd>:
  * @param  NewState: new state of the specified peripheral clock.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_APB1PeriphResetCmd(uint32_t RCC_APB1Periph, FunctionalState NewState)
{
 8004004:	b480      	push	{r7}
 8004006:	b083      	sub	sp, #12
 8004008:	af00      	add	r7, sp, #0
 800400a:	6078      	str	r0, [r7, #4]
 800400c:	460b      	mov	r3, r1
 800400e:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_RCC_APB1_PERIPH(RCC_APB1Periph));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
 8004010:	78fb      	ldrb	r3, [r7, #3]
 8004012:	2b00      	cmp	r3, #0
 8004014:	d00c      	beq.n	8004030 <RCC_APB1PeriphResetCmd+0x2c>
  {
    RCC->APB1RSTR |= RCC_APB1Periph;
 8004016:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 800401a:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800401e:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8004022:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8004026:	6911      	ldr	r1, [r2, #16]
 8004028:	687a      	ldr	r2, [r7, #4]
 800402a:	430a      	orrs	r2, r1
 800402c:	611a      	str	r2, [r3, #16]
 800402e:	e00d      	b.n	800404c <RCC_APB1PeriphResetCmd+0x48>
  }
  else
  {
    RCC->APB1RSTR &= ~RCC_APB1Periph;
 8004030:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8004034:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8004038:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 800403c:	f2c4 0202 	movt	r2, #16386	; 0x4002
 8004040:	6911      	ldr	r1, [r2, #16]
 8004042:	687a      	ldr	r2, [r7, #4]
 8004044:	ea6f 0202 	mvn.w	r2, r2
 8004048:	400a      	ands	r2, r1
 800404a:	611a      	str	r2, [r3, #16]
  }
}
 800404c:	f107 070c 	add.w	r7, r7, #12
 8004050:	46bd      	mov	sp, r7
 8004052:	bc80      	pop	{r7}
 8004054:	4770      	bx	lr
 8004056:	bf00      	nop

08004058 <RCC_BackupResetCmd>:
  * @param  NewState: new state of the Backup domain reset.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_BackupResetCmd(FunctionalState NewState)
{
 8004058:	b480      	push	{r7}
 800405a:	b083      	sub	sp, #12
 800405c:	af00      	add	r7, sp, #0
 800405e:	4603      	mov	r3, r0
 8004060:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  *(__IO uint32_t *) BDCR_BDRST_BB = (uint32_t)NewState;
 8004062:	f44f 6388 	mov.w	r3, #1088	; 0x440
 8004066:	f2c4 2342 	movt	r3, #16962	; 0x4242
 800406a:	79fa      	ldrb	r2, [r7, #7]
 800406c:	601a      	str	r2, [r3, #0]
}
 800406e:	f107 070c 	add.w	r7, r7, #12
 8004072:	46bd      	mov	sp, r7
 8004074:	bc80      	pop	{r7}
 8004076:	4770      	bx	lr

08004078 <RCC_ClockSecuritySystemCmd>:
  * @param  NewState: new state of the Clock Security System..
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void RCC_ClockSecuritySystemCmd(FunctionalState NewState)
{
 8004078:	b480      	push	{r7}
 800407a:	b083      	sub	sp, #12
 800407c:	af00      	add	r7, sp, #0
 800407e:	4603      	mov	r3, r0
 8004080:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  *(__IO uint32_t *) CR_CSSON_BB = (uint32_t)NewState;
 8004082:	f04f 034c 	mov.w	r3, #76	; 0x4c
 8004086:	f2c4 2342 	movt	r3, #16962	; 0x4242
 800408a:	79fa      	ldrb	r2, [r7, #7]
 800408c:	601a      	str	r2, [r3, #0]
}
 800408e:	f107 070c 	add.w	r7, r7, #12
 8004092:	46bd      	mov	sp, r7
 8004094:	bc80      	pop	{r7}
 8004096:	4770      	bx	lr

08004098 <RCC_MCOConfig>:
  *     @arg RCC_MCO_PLLCLK_Div2: PLL clock divided by 2 selected
  *   
  * @retval None
  */
void RCC_MCOConfig(uint8_t RCC_MCO)
{
 8004098:	b480      	push	{r7}
 800409a:	b083      	sub	sp, #12
 800409c:	af00      	add	r7, sp, #0
 800409e:	4603      	mov	r3, r0
 80040a0:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_RCC_MCO(RCC_MCO));

  /* Perform Byte access to MCO bits to select the MCO source */
  *(__IO uint8_t *) CFGR_BYTE4_ADDRESS = RCC_MCO;
 80040a2:	f241 0307 	movw	r3, #4103	; 0x1007
 80040a6:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80040aa:	79fa      	ldrb	r2, [r7, #7]
 80040ac:	701a      	strb	r2, [r3, #0]
}
 80040ae:	f107 070c 	add.w	r7, r7, #12
 80040b2:	46bd      	mov	sp, r7
 80040b4:	bc80      	pop	{r7}
 80040b6:	4770      	bx	lr

080040b8 <RCC_GetFlagStatus>:
  *     @arg RCC_FLAG_LPWRRST: Low Power reset
  *   
  * @retval The new state of RCC_FLAG (SET or RESET).
  */
FlagStatus RCC_GetFlagStatus(uint8_t RCC_FLAG)
{
 80040b8:	b480      	push	{r7}
 80040ba:	b087      	sub	sp, #28
 80040bc:	af00      	add	r7, sp, #0
 80040be:	4603      	mov	r3, r0
 80040c0:	71fb      	strb	r3, [r7, #7]
  uint32_t tmp = 0;
 80040c2:	f04f 0300 	mov.w	r3, #0
 80040c6:	60fb      	str	r3, [r7, #12]
  uint32_t statusreg = 0;
 80040c8:	f04f 0300 	mov.w	r3, #0
 80040cc:	617b      	str	r3, [r7, #20]
  FlagStatus bitstatus = RESET;
 80040ce:	f04f 0300 	mov.w	r3, #0
 80040d2:	74fb      	strb	r3, [r7, #19]
  /* Check the parameters */
  assert_param(IS_RCC_FLAG(RCC_FLAG));

  /* Get the RCC register index */
  tmp = RCC_FLAG >> 5;
 80040d4:	79fb      	ldrb	r3, [r7, #7]
 80040d6:	ea4f 1353 	mov.w	r3, r3, lsr #5
 80040da:	b2db      	uxtb	r3, r3
 80040dc:	60fb      	str	r3, [r7, #12]
  if (tmp == 1)               /* The flag to check is in CR register */
 80040de:	68fb      	ldr	r3, [r7, #12]
 80040e0:	2b01      	cmp	r3, #1
 80040e2:	d106      	bne.n	80040f2 <RCC_GetFlagStatus+0x3a>
  {
    statusreg = RCC->CR;
 80040e4:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80040e8:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80040ec:	681b      	ldr	r3, [r3, #0]
 80040ee:	617b      	str	r3, [r7, #20]
 80040f0:	e00f      	b.n	8004112 <RCC_GetFlagStatus+0x5a>
  }
  else if (tmp == 2)          /* The flag to check is in BDCR register */
 80040f2:	68fb      	ldr	r3, [r7, #12]
 80040f4:	2b02      	cmp	r3, #2
 80040f6:	d106      	bne.n	8004106 <RCC_GetFlagStatus+0x4e>
  {
    statusreg = RCC->BDCR;
 80040f8:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 80040fc:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8004100:	6a1b      	ldr	r3, [r3, #32]
 8004102:	617b      	str	r3, [r7, #20]
 8004104:	e005      	b.n	8004112 <RCC_GetFlagStatus+0x5a>
  }
  else                       /* The flag to check is in CSR register */
  {
    statusreg = RCC->CSR;
 8004106:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 800410a:	f2c4 0302 	movt	r3, #16386	; 0x4002
 800410e:	6a5b      	ldr	r3, [r3, #36]	; 0x24
 8004110:	617b      	str	r3, [r7, #20]
  }

  /* Get the flag position */
  tmp = RCC_FLAG & FLAG_Mask;
 8004112:	79fb      	ldrb	r3, [r7, #7]
 8004114:	f003 031f 	and.w	r3, r3, #31
 8004118:	60fb      	str	r3, [r7, #12]
  if ((statusreg & ((uint32_t)1 << tmp)) != (uint32_t)RESET)
 800411a:	68fb      	ldr	r3, [r7, #12]
 800411c:	697a      	ldr	r2, [r7, #20]
 800411e:	fa22 f303 	lsr.w	r3, r2, r3
 8004122:	f003 0301 	and.w	r3, r3, #1
 8004126:	b2db      	uxtb	r3, r3
 8004128:	2b00      	cmp	r3, #0
 800412a:	d003      	beq.n	8004134 <RCC_GetFlagStatus+0x7c>
  {
    bitstatus = SET;
 800412c:	f04f 0301 	mov.w	r3, #1
 8004130:	74fb      	strb	r3, [r7, #19]
 8004132:	e002      	b.n	800413a <RCC_GetFlagStatus+0x82>
  }
  else
  {
    bitstatus = RESET;
 8004134:	f04f 0300 	mov.w	r3, #0
 8004138:	74fb      	strb	r3, [r7, #19]
  }

  /* Return the flag status */
  return bitstatus;
 800413a:	7cfb      	ldrb	r3, [r7, #19]
}
 800413c:	4618      	mov	r0, r3
 800413e:	f107 071c 	add.w	r7, r7, #28
 8004142:	46bd      	mov	sp, r7
 8004144:	bc80      	pop	{r7}
 8004146:	4770      	bx	lr

08004148 <RCC_ClearFlag>:
  *   RCC_FLAG_IWDGRST, RCC_FLAG_WWDGRST, RCC_FLAG_LPWRRST
  * @param  None
  * @retval None
  */
void RCC_ClearFlag(void)
{
 8004148:	b480      	push	{r7}
 800414a:	af00      	add	r7, sp, #0
  /* Set RMVF bit to clear the reset flags */
  RCC->CSR |= CSR_RMVF_Set;
 800414c:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8004150:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8004154:	f44f 5280 	mov.w	r2, #4096	; 0x1000
 8004158:	f2c4 0202 	movt	r2, #16386	; 0x4002
 800415c:	6a52      	ldr	r2, [r2, #36]	; 0x24
 800415e:	f042 7280 	orr.w	r2, r2, #16777216	; 0x1000000
 8004162:	625a      	str	r2, [r3, #36]	; 0x24
}
 8004164:	46bd      	mov	sp, r7
 8004166:	bc80      	pop	{r7}
 8004168:	4770      	bx	lr
 800416a:	bf00      	nop

0800416c <RCC_GetITStatus>:
  *     @arg RCC_IT_CSS: Clock Security System interrupt
  *   
  * @retval The new state of RCC_IT (SET or RESET).
  */
ITStatus RCC_GetITStatus(uint8_t RCC_IT)
{
 800416c:	b480      	push	{r7}
 800416e:	b085      	sub	sp, #20
 8004170:	af00      	add	r7, sp, #0
 8004172:	4603      	mov	r3, r0
 8004174:	71fb      	strb	r3, [r7, #7]
  ITStatus bitstatus = RESET;
 8004176:	f04f 0300 	mov.w	r3, #0
 800417a:	73fb      	strb	r3, [r7, #15]
  /* Check the parameters */
  assert_param(IS_RCC_GET_IT(RCC_IT));

  /* Check the status of the specified RCC interrupt */
  if ((RCC->CIR & RCC_IT) != (uint32_t)RESET)
 800417c:	f44f 5380 	mov.w	r3, #4096	; 0x1000
 8004180:	f2c4 0302 	movt	r3, #16386	; 0x4002
 8004184:	689a      	ldr	r2, [r3, #8]
 8004186:	79fb      	ldrb	r3, [r7, #7]
 8004188:	4013      	ands	r3, r2
 800418a:	2b00      	cmp	r3, #0
 800418c:	d003      	beq.n	8004196 <RCC_GetITStatus+0x2a>
  {
    bitstatus = SET;
 800418e:	f04f 0301 	mov.w	r3, #1
 8004192:	73fb      	strb	r3, [r7, #15]
 8004194:	e002      	b.n	800419c <RCC_GetITStatus+0x30>
  }
  else
  {
    bitstatus = RESET;
 8004196:	f04f 0300 	mov.w	r3, #0
 800419a:	73fb      	strb	r3, [r7, #15]
  }

  /* Return the RCC_IT status */
  return  bitstatus;
 800419c:	7bfb      	ldrb	r3, [r7, #15]
}
 800419e:	4618      	mov	r0, r3
 80041a0:	f107 0714 	add.w	r7, r7, #20
 80041a4:	46bd      	mov	sp, r7
 80041a6:	bc80      	pop	{r7}
 80041a8:	4770      	bx	lr
 80041aa:	bf00      	nop

080041ac <RCC_ClearITPendingBit>:
  *   
  *     @arg RCC_IT_CSS: Clock Security System interrupt
  * @retval None
  */
void RCC_ClearITPendingBit(uint8_t RCC_IT)
{
 80041ac:	b480      	push	{r7}
 80041ae:	b083      	sub	sp, #12
 80041b0:	af00      	add	r7, sp, #0
 80041b2:	4603      	mov	r3, r0
 80041b4:	71fb      	strb	r3, [r7, #7]
  /* Check the parameters */
  assert_param(IS_RCC_CLEAR_IT(RCC_IT));

  /* Perform Byte access to RCC_CIR[23:16] bits to clear the selected interrupt
     pending bits */
  *(__IO uint8_t *) CIR_BYTE3_ADDRESS = RCC_IT;
 80041b6:	f241 030a 	movw	r3, #4106	; 0x100a
 80041ba:	f2c4 0302 	movt	r3, #16386	; 0x4002
 80041be:	79fa      	ldrb	r2, [r7, #7]
 80041c0:	701a      	strb	r2, [r3, #0]
}
 80041c2:	f107 070c 	add.w	r7, r7, #12
 80041c6:	46bd      	mov	sp, r7
 80041c8:	bc80      	pop	{r7}
 80041ca:	4770      	bx	lr

080041cc <USART_DeInit>:
  *   This parameter can be one of the following values: 
  *      USART1, USART2, USART3, UART4 or UART5.
  * @retval None
  */
void USART_DeInit(USART_TypeDef* USARTx)
{
 80041cc:	b580      	push	{r7, lr}
 80041ce:	b082      	sub	sp, #8
 80041d0:	af00      	add	r7, sp, #0
 80041d2:	6078      	str	r0, [r7, #4]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));

  if (USARTx == USART1)
 80041d4:	687a      	ldr	r2, [r7, #4]
 80041d6:	f44f 5360 	mov.w	r3, #14336	; 0x3800
 80041da:	f2c4 0301 	movt	r3, #16385	; 0x4001
 80041de:	429a      	cmp	r2, r3
 80041e0:	d10c      	bne.n	80041fc <USART_DeInit+0x30>
  {
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_USART1, ENABLE);
 80041e2:	f44f 4080 	mov.w	r0, #16384	; 0x4000
 80041e6:	f04f 0101 	mov.w	r1, #1
 80041ea:	f7ff fee1 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
    RCC_APB2PeriphResetCmd(RCC_APB2Periph_USART1, DISABLE);
 80041ee:	f44f 4080 	mov.w	r0, #16384	; 0x4000
 80041f2:	f04f 0100 	mov.w	r1, #0
 80041f6:	f7ff fedb 	bl	8003fb0 <RCC_APB2PeriphResetCmd>
 80041fa:	e04e      	b.n	800429a <USART_DeInit+0xce>
  }
  else if (USARTx == USART2)
 80041fc:	687a      	ldr	r2, [r7, #4]
 80041fe:	f44f 4388 	mov.w	r3, #17408	; 0x4400
 8004202:	f2c4 0300 	movt	r3, #16384	; 0x4000
 8004206:	429a      	cmp	r2, r3
 8004208:	d10c      	bne.n	8004224 <USART_DeInit+0x58>
  {
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART2, ENABLE);
 800420a:	f44f 3000 	mov.w	r0, #131072	; 0x20000
 800420e:	f04f 0101 	mov.w	r1, #1
 8004212:	f7ff fef7 	bl	8004004 <RCC_APB1PeriphResetCmd>
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART2, DISABLE);
 8004216:	f44f 3000 	mov.w	r0, #131072	; 0x20000
 800421a:	f04f 0100 	mov.w	r1, #0
 800421e:	f7ff fef1 	bl	8004004 <RCC_APB1PeriphResetCmd>
 8004222:	e03a      	b.n	800429a <USART_DeInit+0xce>
  }
  else if (USARTx == USART3)
 8004224:	687a      	ldr	r2, [r7, #4]
 8004226:	f44f 4390 	mov.w	r3, #18432	; 0x4800
 800422a:	f2c4 0300 	movt	r3, #16384	; 0x4000
 800422e:	429a      	cmp	r2, r3
 8004230:	d10c      	bne.n	800424c <USART_DeInit+0x80>
  {
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART3, ENABLE);
 8004232:	f44f 2080 	mov.w	r0, #262144	; 0x40000
 8004236:	f04f 0101 	mov.w	r1, #1
 800423a:	f7ff fee3 	bl	8004004 <RCC_APB1PeriphResetCmd>
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_USART3, DISABLE);
 800423e:	f44f 2080 	mov.w	r0, #262144	; 0x40000
 8004242:	f04f 0100 	mov.w	r1, #0
 8004246:	f7ff fedd 	bl	8004004 <RCC_APB1PeriphResetCmd>
 800424a:	e026      	b.n	800429a <USART_DeInit+0xce>
  }    
  else if (USARTx == UART4)
 800424c:	687a      	ldr	r2, [r7, #4]
 800424e:	f44f 4398 	mov.w	r3, #19456	; 0x4c00
 8004252:	f2c4 0300 	movt	r3, #16384	; 0x4000
 8004256:	429a      	cmp	r2, r3
 8004258:	d10c      	bne.n	8004274 <USART_DeInit+0xa8>
  {
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_UART4, ENABLE);
 800425a:	f44f 2000 	mov.w	r0, #524288	; 0x80000
 800425e:	f04f 0101 	mov.w	r1, #1
 8004262:	f7ff fecf 	bl	8004004 <RCC_APB1PeriphResetCmd>
    RCC_APB1PeriphResetCmd(RCC_APB1Periph_UART4, DISABLE);
 8004266:	f44f 2000 	mov.w	r0, #524288	; 0x80000
 800426a:	f04f 0100 	mov.w	r1, #0
 800426e:	f7ff fec9 	bl	8004004 <RCC_APB1PeriphResetCmd>
 8004272:	e012      	b.n	800429a <USART_DeInit+0xce>
  }    
  else
  {
    if (USARTx == UART5)
 8004274:	687a      	ldr	r2, [r7, #4]
 8004276:	f44f 43a0 	mov.w	r3, #20480	; 0x5000
 800427a:	f2c4 0300 	movt	r3, #16384	; 0x4000
 800427e:	429a      	cmp	r2, r3
 8004280:	d10b      	bne.n	800429a <USART_DeInit+0xce>
    { 
      RCC_APB1PeriphResetCmd(RCC_APB1Periph_UART5, ENABLE);
 8004282:	f44f 1080 	mov.w	r0, #1048576	; 0x100000
 8004286:	f04f 0101 	mov.w	r1, #1
 800428a:	f7ff febb 	bl	8004004 <RCC_APB1PeriphResetCmd>
      RCC_APB1PeriphResetCmd(RCC_APB1Periph_UART5, DISABLE);
 800428e:	f44f 1080 	mov.w	r0, #1048576	; 0x100000
 8004292:	f04f 0100 	mov.w	r1, #0
 8004296:	f7ff feb5 	bl	8004004 <RCC_APB1PeriphResetCmd>
    }
  }
}
 800429a:	f107 0708 	add.w	r7, r7, #8
 800429e:	46bd      	mov	sp, r7
 80042a0:	bd80      	pop	{r7, pc}
 80042a2:	bf00      	nop

080042a4 <USART_Init>:
  *         that contains the configuration information for the specified USART 
  *         peripheral.
  * @retval None
  */
void USART_Init(USART_TypeDef* USARTx, USART_InitTypeDef* USART_InitStruct)
{
 80042a4:	b580      	push	{r7, lr}
 80042a6:	b08c      	sub	sp, #48	; 0x30
 80042a8:	af00      	add	r7, sp, #0
 80042aa:	6078      	str	r0, [r7, #4]
 80042ac:	6039      	str	r1, [r7, #0]
  uint32_t tmpreg = 0x00, apbclock = 0x00;
 80042ae:	f04f 0300 	mov.w	r3, #0
 80042b2:	62fb      	str	r3, [r7, #44]	; 0x2c
 80042b4:	f04f 0300 	mov.w	r3, #0
 80042b8:	62bb      	str	r3, [r7, #40]	; 0x28
  uint32_t integerdivider = 0x00;
 80042ba:	f04f 0300 	mov.w	r3, #0
 80042be:	627b      	str	r3, [r7, #36]	; 0x24
  uint32_t fractionaldivider = 0x00;
 80042c0:	f04f 0300 	mov.w	r3, #0
 80042c4:	623b      	str	r3, [r7, #32]
  uint32_t usartxbase = 0;
 80042c6:	f04f 0300 	mov.w	r3, #0
 80042ca:	61fb      	str	r3, [r7, #28]
  if (USART_InitStruct->USART_HardwareFlowControl != USART_HardwareFlowControl_None)
  {
    assert_param(IS_USART_123_PERIPH(USARTx));
  }

  usartxbase = (uint32_t)USARTx;
 80042cc:	687b      	ldr	r3, [r7, #4]
 80042ce:	61fb      	str	r3, [r7, #28]

/*---------------------------- USART CR2 Configuration -----------------------*/
  tmpreg = USARTx->CR2;
 80042d0:	687b      	ldr	r3, [r7, #4]
 80042d2:	8a1b      	ldrh	r3, [r3, #16]
 80042d4:	b29b      	uxth	r3, r3
 80042d6:	62fb      	str	r3, [r7, #44]	; 0x2c
  /* Clear STOP[13:12] bits */
  tmpreg &= CR2_STOP_CLEAR_Mask;
 80042d8:	6afa      	ldr	r2, [r7, #44]	; 0x2c
 80042da:	f64c 73ff 	movw	r3, #53247	; 0xcfff
 80042de:	4013      	ands	r3, r2
 80042e0:	62fb      	str	r3, [r7, #44]	; 0x2c
  /* Configure the USART Stop Bits, Clock, CPOL, CPHA and LastBit ------------*/
  /* Set STOP[13:12] bits according to USART_StopBits value */
  tmpreg |= (uint32_t)USART_InitStruct->USART_StopBits;
 80042e2:	683b      	ldr	r3, [r7, #0]
 80042e4:	88db      	ldrh	r3, [r3, #6]
 80042e6:	6afa      	ldr	r2, [r7, #44]	; 0x2c
 80042e8:	4313      	orrs	r3, r2
 80042ea:	62fb      	str	r3, [r7, #44]	; 0x2c
  
  /* Write to USART CR2 */
  USARTx->CR2 = (uint16_t)tmpreg;
 80042ec:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 80042ee:	b29a      	uxth	r2, r3
 80042f0:	687b      	ldr	r3, [r7, #4]
 80042f2:	821a      	strh	r2, [r3, #16]

/*---------------------------- USART CR1 Configuration -----------------------*/
  tmpreg = USARTx->CR1;
 80042f4:	687b      	ldr	r3, [r7, #4]
 80042f6:	899b      	ldrh	r3, [r3, #12]
 80042f8:	b29b      	uxth	r3, r3
 80042fa:	62fb      	str	r3, [r7, #44]	; 0x2c
  /* Clear M, PCE, PS, TE and RE bits */
  tmpreg &= CR1_CLEAR_Mask;
 80042fc:	6afa      	ldr	r2, [r7, #44]	; 0x2c
 80042fe:	f64e 13f3 	movw	r3, #59891	; 0xe9f3
 8004302:	4013      	ands	r3, r2
 8004304:	62fb      	str	r3, [r7, #44]	; 0x2c
  /* Configure the USART Word Length, Parity and mode ----------------------- */
  /* Set the M bits according to USART_WordLength value */
  /* Set PCE and PS bits according to USART_Parity value */
  /* Set TE and RE bits according to USART_Mode value */
  tmpreg |= (uint32_t)USART_InitStruct->USART_WordLength | USART_InitStruct->USART_Parity |
 8004306:	683b      	ldr	r3, [r7, #0]
 8004308:	889a      	ldrh	r2, [r3, #4]
 800430a:	683b      	ldr	r3, [r7, #0]
 800430c:	891b      	ldrh	r3, [r3, #8]
 800430e:	4313      	orrs	r3, r2
 8004310:	b29a      	uxth	r2, r3
            USART_InitStruct->USART_Mode;
 8004312:	683b      	ldr	r3, [r7, #0]
 8004314:	895b      	ldrh	r3, [r3, #10]
  tmpreg &= CR1_CLEAR_Mask;
  /* Configure the USART Word Length, Parity and mode ----------------------- */
  /* Set the M bits according to USART_WordLength value */
  /* Set PCE and PS bits according to USART_Parity value */
  /* Set TE and RE bits according to USART_Mode value */
  tmpreg |= (uint32_t)USART_InitStruct->USART_WordLength | USART_InitStruct->USART_Parity |
 8004316:	4313      	orrs	r3, r2
 8004318:	b29b      	uxth	r3, r3
 800431a:	6afa      	ldr	r2, [r7, #44]	; 0x2c
 800431c:	4313      	orrs	r3, r2
 800431e:	62fb      	str	r3, [r7, #44]	; 0x2c
            USART_InitStruct->USART_Mode;
  /* Write to USART CR1 */
  USARTx->CR1 = (uint16_t)tmpreg;
 8004320:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 8004322:	b29a      	uxth	r2, r3
 8004324:	687b      	ldr	r3, [r7, #4]
 8004326:	819a      	strh	r2, [r3, #12]

/*---------------------------- USART CR3 Configuration -----------------------*/  
  tmpreg = USARTx->CR3;
 8004328:	687b      	ldr	r3, [r7, #4]
 800432a:	8a9b      	ldrh	r3, [r3, #20]
 800432c:	b29b      	uxth	r3, r3
 800432e:	62fb      	str	r3, [r7, #44]	; 0x2c
  /* Clear CTSE and RTSE bits */
  tmpreg &= CR3_CLEAR_Mask;
 8004330:	6afa      	ldr	r2, [r7, #44]	; 0x2c
 8004332:	f64f 43ff 	movw	r3, #64767	; 0xfcff
 8004336:	4013      	ands	r3, r2
 8004338:	62fb      	str	r3, [r7, #44]	; 0x2c
  /* Configure the USART HFC -------------------------------------------------*/
  /* Set CTSE and RTSE bits according to USART_HardwareFlowControl value */
  tmpreg |= USART_InitStruct->USART_HardwareFlowControl;
 800433a:	683b      	ldr	r3, [r7, #0]
 800433c:	899b      	ldrh	r3, [r3, #12]
 800433e:	6afa      	ldr	r2, [r7, #44]	; 0x2c
 8004340:	4313      	orrs	r3, r2
 8004342:	62fb      	str	r3, [r7, #44]	; 0x2c
  /* Write to USART CR3 */
  USARTx->CR3 = (uint16_t)tmpreg;
 8004344:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 8004346:	b29a      	uxth	r2, r3
 8004348:	687b      	ldr	r3, [r7, #4]
 800434a:	829a      	strh	r2, [r3, #20]

/*---------------------------- USART BRR Configuration -----------------------*/
  /* Configure the USART Baud Rate -------------------------------------------*/
  RCC_GetClocksFreq(&RCC_ClocksStatus);
 800434c:	f107 0308 	add.w	r3, r7, #8
 8004350:	4618      	mov	r0, r3
 8004352:	f7ff fcc5 	bl	8003ce0 <RCC_GetClocksFreq>
  if (usartxbase == USART1_BASE)
 8004356:	69fa      	ldr	r2, [r7, #28]
 8004358:	f44f 5360 	mov.w	r3, #14336	; 0x3800
 800435c:	f2c4 0301 	movt	r3, #16385	; 0x4001
 8004360:	429a      	cmp	r2, r3
 8004362:	d102      	bne.n	800436a <USART_Init+0xc6>
  {
    apbclock = RCC_ClocksStatus.PCLK2_Frequency;
 8004364:	697b      	ldr	r3, [r7, #20]
 8004366:	62bb      	str	r3, [r7, #40]	; 0x28
 8004368:	e001      	b.n	800436e <USART_Init+0xca>
  }
  else
  {
    apbclock = RCC_ClocksStatus.PCLK1_Frequency;
 800436a:	693b      	ldr	r3, [r7, #16]
 800436c:	62bb      	str	r3, [r7, #40]	; 0x28
  }
  
  /* Determine the integer part */
  if ((USARTx->CR1 & CR1_OVER8_Set) != 0)
 800436e:	687b      	ldr	r3, [r7, #4]
 8004370:	899b      	ldrh	r3, [r3, #12]
 8004372:	b29b      	uxth	r3, r3
 8004374:	b29b      	uxth	r3, r3
 8004376:	b21b      	sxth	r3, r3
 8004378:	2b00      	cmp	r3, #0
 800437a:	da0f      	bge.n	800439c <USART_Init+0xf8>
  {
    /* Integer part computing in case Oversampling mode is 8 Samples */
    integerdivider = ((25 * apbclock) / (2 * (USART_InitStruct->USART_BaudRate)));    
 800437c:	6aba      	ldr	r2, [r7, #40]	; 0x28
 800437e:	4613      	mov	r3, r2
 8004380:	ea4f 0383 	mov.w	r3, r3, lsl #2
 8004384:	189b      	adds	r3, r3, r2
 8004386:	ea4f 0283 	mov.w	r2, r3, lsl #2
 800438a:	189a      	adds	r2, r3, r2
 800438c:	683b      	ldr	r3, [r7, #0]
 800438e:	681b      	ldr	r3, [r3, #0]
 8004390:	ea4f 0343 	mov.w	r3, r3, lsl #1
 8004394:	fbb2 f3f3 	udiv	r3, r2, r3
 8004398:	627b      	str	r3, [r7, #36]	; 0x24
 800439a:	e00e      	b.n	80043ba <USART_Init+0x116>
  }
  else /* if ((USARTx->CR1 & CR1_OVER8_Set) == 0) */
  {
    /* Integer part computing in case Oversampling mode is 16 Samples */
    integerdivider = ((25 * apbclock) / (4 * (USART_InitStruct->USART_BaudRate)));    
 800439c:	6aba      	ldr	r2, [r7, #40]	; 0x28
 800439e:	4613      	mov	r3, r2
 80043a0:	ea4f 0383 	mov.w	r3, r3, lsl #2
 80043a4:	189b      	adds	r3, r3, r2
 80043a6:	ea4f 0283 	mov.w	r2, r3, lsl #2
 80043aa:	189a      	adds	r2, r3, r2
 80043ac:	683b      	ldr	r3, [r7, #0]
 80043ae:	681b      	ldr	r3, [r3, #0]
 80043b0:	ea4f 0383 	mov.w	r3, r3, lsl #2
 80043b4:	fbb2 f3f3 	udiv	r3, r2, r3
 80043b8:	627b      	str	r3, [r7, #36]	; 0x24
  }
  tmpreg = (integerdivider / 100) << 4;
 80043ba:	6a7a      	ldr	r2, [r7, #36]	; 0x24
 80043bc:	f248 531f 	movw	r3, #34079	; 0x851f
 80043c0:	f2c5 13eb 	movt	r3, #20971	; 0x51eb
 80043c4:	fba3 1302 	umull	r1, r3, r3, r2
 80043c8:	ea4f 1353 	mov.w	r3, r3, lsr #5
 80043cc:	ea4f 1303 	mov.w	r3, r3, lsl #4
 80043d0:	62fb      	str	r3, [r7, #44]	; 0x2c

  /* Determine the fractional part */
  fractionaldivider = integerdivider - (100 * (tmpreg >> 4));
 80043d2:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 80043d4:	ea4f 1313 	mov.w	r3, r3, lsr #4
 80043d8:	f04f 0264 	mov.w	r2, #100	; 0x64
 80043dc:	fb02 f303 	mul.w	r3, r2, r3
 80043e0:	6a7a      	ldr	r2, [r7, #36]	; 0x24
 80043e2:	1ad3      	subs	r3, r2, r3
 80043e4:	623b      	str	r3, [r7, #32]

  /* Implement the fractional part in the register */
  if ((USARTx->CR1 & CR1_OVER8_Set) != 0)
 80043e6:	687b      	ldr	r3, [r7, #4]
 80043e8:	899b      	ldrh	r3, [r3, #12]
 80043ea:	b29b      	uxth	r3, r3
 80043ec:	b29b      	uxth	r3, r3
 80043ee:	b21b      	sxth	r3, r3
 80043f0:	2b00      	cmp	r3, #0
 80043f2:	da12      	bge.n	800441a <USART_Init+0x176>
  {
    tmpreg |= ((((fractionaldivider * 8) + 50) / 100)) & ((uint8_t)0x07);
 80043f4:	6a3b      	ldr	r3, [r7, #32]
 80043f6:	ea4f 03c3 	mov.w	r3, r3, lsl #3
 80043fa:	f103 0232 	add.w	r2, r3, #50	; 0x32
 80043fe:	f248 531f 	movw	r3, #34079	; 0x851f
 8004402:	f2c5 13eb 	movt	r3, #20971	; 0x51eb
 8004406:	fba3 1302 	umull	r1, r3, r3, r2
 800440a:	ea4f 1353 	mov.w	r3, r3, lsr #5
 800440e:	f003 0307 	and.w	r3, r3, #7
 8004412:	6afa      	ldr	r2, [r7, #44]	; 0x2c
 8004414:	4313      	orrs	r3, r2
 8004416:	62fb      	str	r3, [r7, #44]	; 0x2c
 8004418:	e011      	b.n	800443e <USART_Init+0x19a>
  }
  else /* if ((USARTx->CR1 & CR1_OVER8_Set) == 0) */
  {
    tmpreg |= ((((fractionaldivider * 16) + 50) / 100)) & ((uint8_t)0x0F);
 800441a:	6a3b      	ldr	r3, [r7, #32]
 800441c:	ea4f 1303 	mov.w	r3, r3, lsl #4
 8004420:	f103 0232 	add.w	r2, r3, #50	; 0x32
 8004424:	f248 531f 	movw	r3, #34079	; 0x851f
 8004428:	f2c5 13eb 	movt	r3, #20971	; 0x51eb
 800442c:	fba3 1302 	umull	r1, r3, r3, r2
 8004430:	ea4f 1353 	mov.w	r3, r3, lsr #5
 8004434:	f003 030f 	and.w	r3, r3, #15
 8004438:	6afa      	ldr	r2, [r7, #44]	; 0x2c
 800443a:	4313      	orrs	r3, r2
 800443c:	62fb      	str	r3, [r7, #44]	; 0x2c
  }
  
  /* Write to USART BRR */
  USARTx->BRR = (uint16_t)tmpreg;
 800443e:	6afb      	ldr	r3, [r7, #44]	; 0x2c
 8004440:	b29a      	uxth	r2, r3
 8004442:	687b      	ldr	r3, [r7, #4]
 8004444:	811a      	strh	r2, [r3, #8]
}
 8004446:	f107 0730 	add.w	r7, r7, #48	; 0x30
 800444a:	46bd      	mov	sp, r7
 800444c:	bd80      	pop	{r7, pc}
 800444e:	bf00      	nop

08004450 <USART_StructInit>:
  * @param  USART_InitStruct: pointer to a USART_InitTypeDef structure
  *         which will be initialized.
  * @retval None
  */
void USART_StructInit(USART_InitTypeDef* USART_InitStruct)
{
 8004450:	b480      	push	{r7}
 8004452:	b083      	sub	sp, #12
 8004454:	af00      	add	r7, sp, #0
 8004456:	6078      	str	r0, [r7, #4]
  /* USART_InitStruct members default value */
  USART_InitStruct->USART_BaudRate = 9600;
 8004458:	687b      	ldr	r3, [r7, #4]
 800445a:	f44f 5216 	mov.w	r2, #9600	; 0x2580
 800445e:	601a      	str	r2, [r3, #0]
  USART_InitStruct->USART_WordLength = USART_WordLength_8b;
 8004460:	687b      	ldr	r3, [r7, #4]
 8004462:	f04f 0200 	mov.w	r2, #0
 8004466:	809a      	strh	r2, [r3, #4]
  USART_InitStruct->USART_StopBits = USART_StopBits_1;
 8004468:	687b      	ldr	r3, [r7, #4]
 800446a:	f04f 0200 	mov.w	r2, #0
 800446e:	80da      	strh	r2, [r3, #6]
  USART_InitStruct->USART_Parity = USART_Parity_No ;
 8004470:	687b      	ldr	r3, [r7, #4]
 8004472:	f04f 0200 	mov.w	r2, #0
 8004476:	811a      	strh	r2, [r3, #8]
  USART_InitStruct->USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
 8004478:	687b      	ldr	r3, [r7, #4]
 800447a:	f04f 020c 	mov.w	r2, #12
 800447e:	815a      	strh	r2, [r3, #10]
  USART_InitStruct->USART_HardwareFlowControl = USART_HardwareFlowControl_None;  
 8004480:	687b      	ldr	r3, [r7, #4]
 8004482:	f04f 0200 	mov.w	r2, #0
 8004486:	819a      	strh	r2, [r3, #12]
}
 8004488:	f107 070c 	add.w	r7, r7, #12
 800448c:	46bd      	mov	sp, r7
 800448e:	bc80      	pop	{r7}
 8004490:	4770      	bx	lr
 8004492:	bf00      	nop

08004494 <USART_ClockInit>:
  *         USART peripheral.  
  * @note The Smart Card and Synchronous modes are not available for UART4 and UART5.
  * @retval None
  */
void USART_ClockInit(USART_TypeDef* USARTx, USART_ClockInitTypeDef* USART_ClockInitStruct)
{
 8004494:	b480      	push	{r7}
 8004496:	b085      	sub	sp, #20
 8004498:	af00      	add	r7, sp, #0
 800449a:	6078      	str	r0, [r7, #4]
 800449c:	6039      	str	r1, [r7, #0]
  uint32_t tmpreg = 0x00;
 800449e:	f04f 0300 	mov.w	r3, #0
 80044a2:	60fb      	str	r3, [r7, #12]
  assert_param(IS_USART_CPOL(USART_ClockInitStruct->USART_CPOL));
  assert_param(IS_USART_CPHA(USART_ClockInitStruct->USART_CPHA));
  assert_param(IS_USART_LASTBIT(USART_ClockInitStruct->USART_LastBit));
  
/*---------------------------- USART CR2 Configuration -----------------------*/
  tmpreg = USARTx->CR2;
 80044a4:	687b      	ldr	r3, [r7, #4]
 80044a6:	8a1b      	ldrh	r3, [r3, #16]
 80044a8:	b29b      	uxth	r3, r3
 80044aa:	60fb      	str	r3, [r7, #12]
  /* Clear CLKEN, CPOL, CPHA and LBCL bits */
  tmpreg &= CR2_CLOCK_CLEAR_Mask;
 80044ac:	68fa      	ldr	r2, [r7, #12]
 80044ae:	f24f 03ff 	movw	r3, #61695	; 0xf0ff
 80044b2:	4013      	ands	r3, r2
 80044b4:	60fb      	str	r3, [r7, #12]
  /* Configure the USART Clock, CPOL, CPHA and LastBit ------------*/
  /* Set CLKEN bit according to USART_Clock value */
  /* Set CPOL bit according to USART_CPOL value */
  /* Set CPHA bit according to USART_CPHA value */
  /* Set LBCL bit according to USART_LastBit value */
  tmpreg |= (uint32_t)USART_ClockInitStruct->USART_Clock | USART_ClockInitStruct->USART_CPOL | 
 80044b6:	683b      	ldr	r3, [r7, #0]
 80044b8:	881a      	ldrh	r2, [r3, #0]
 80044ba:	683b      	ldr	r3, [r7, #0]
 80044bc:	885b      	ldrh	r3, [r3, #2]
                 USART_ClockInitStruct->USART_CPHA | USART_ClockInitStruct->USART_LastBit;
 80044be:	4313      	orrs	r3, r2
 80044c0:	b29a      	uxth	r2, r3
 80044c2:	683b      	ldr	r3, [r7, #0]
 80044c4:	889b      	ldrh	r3, [r3, #4]
 80044c6:	4313      	orrs	r3, r2
 80044c8:	b29a      	uxth	r2, r3
 80044ca:	683b      	ldr	r3, [r7, #0]
 80044cc:	88db      	ldrh	r3, [r3, #6]
 80044ce:	4313      	orrs	r3, r2
 80044d0:	b29b      	uxth	r3, r3
  /* Configure the USART Clock, CPOL, CPHA and LastBit ------------*/
  /* Set CLKEN bit according to USART_Clock value */
  /* Set CPOL bit according to USART_CPOL value */
  /* Set CPHA bit according to USART_CPHA value */
  /* Set LBCL bit according to USART_LastBit value */
  tmpreg |= (uint32_t)USART_ClockInitStruct->USART_Clock | USART_ClockInitStruct->USART_CPOL | 
 80044d2:	68fa      	ldr	r2, [r7, #12]
 80044d4:	4313      	orrs	r3, r2
 80044d6:	60fb      	str	r3, [r7, #12]
                 USART_ClockInitStruct->USART_CPHA | USART_ClockInitStruct->USART_LastBit;
  /* Write to USART CR2 */
  USARTx->CR2 = (uint16_t)tmpreg;
 80044d8:	68fb      	ldr	r3, [r7, #12]
 80044da:	b29a      	uxth	r2, r3
 80044dc:	687b      	ldr	r3, [r7, #4]
 80044de:	821a      	strh	r2, [r3, #16]
}
 80044e0:	f107 0714 	add.w	r7, r7, #20
 80044e4:	46bd      	mov	sp, r7
 80044e6:	bc80      	pop	{r7}
 80044e8:	4770      	bx	lr
 80044ea:	bf00      	nop

080044ec <USART_ClockStructInit>:
  * @param  USART_ClockInitStruct: pointer to a USART_ClockInitTypeDef
  *         structure which will be initialized.
  * @retval None
  */
void USART_ClockStructInit(USART_ClockInitTypeDef* USART_ClockInitStruct)
{
 80044ec:	b480      	push	{r7}
 80044ee:	b083      	sub	sp, #12
 80044f0:	af00      	add	r7, sp, #0
 80044f2:	6078      	str	r0, [r7, #4]
  /* USART_ClockInitStruct members default value */
  USART_ClockInitStruct->USART_Clock = USART_Clock_Disable;
 80044f4:	687b      	ldr	r3, [r7, #4]
 80044f6:	f04f 0200 	mov.w	r2, #0
 80044fa:	801a      	strh	r2, [r3, #0]
  USART_ClockInitStruct->USART_CPOL = USART_CPOL_Low;
 80044fc:	687b      	ldr	r3, [r7, #4]
 80044fe:	f04f 0200 	mov.w	r2, #0
 8004502:	805a      	strh	r2, [r3, #2]
  USART_ClockInitStruct->USART_CPHA = USART_CPHA_1Edge;
 8004504:	687b      	ldr	r3, [r7, #4]
 8004506:	f04f 0200 	mov.w	r2, #0
 800450a:	809a      	strh	r2, [r3, #4]
  USART_ClockInitStruct->USART_LastBit = USART_LastBit_Disable;
 800450c:	687b      	ldr	r3, [r7, #4]
 800450e:	f04f 0200 	mov.w	r2, #0
 8004512:	80da      	strh	r2, [r3, #6]
}
 8004514:	f107 070c 	add.w	r7, r7, #12
 8004518:	46bd      	mov	sp, r7
 800451a:	bc80      	pop	{r7}
 800451c:	4770      	bx	lr
 800451e:	bf00      	nop

08004520 <USART_Cmd>:
  * @param  NewState: new state of the USARTx peripheral.
  *         This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void USART_Cmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
 8004520:	b480      	push	{r7}
 8004522:	b083      	sub	sp, #12
 8004524:	af00      	add	r7, sp, #0
 8004526:	6078      	str	r0, [r7, #4]
 8004528:	460b      	mov	r3, r1
 800452a:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 800452c:	78fb      	ldrb	r3, [r7, #3]
 800452e:	2b00      	cmp	r3, #0
 8004530:	d008      	beq.n	8004544 <USART_Cmd+0x24>
  {
    /* Enable the selected USART by setting the UE bit in the CR1 register */
    USARTx->CR1 |= CR1_UE_Set;
 8004532:	687b      	ldr	r3, [r7, #4]
 8004534:	899b      	ldrh	r3, [r3, #12]
 8004536:	b29b      	uxth	r3, r3
 8004538:	f443 5300 	orr.w	r3, r3, #8192	; 0x2000
 800453c:	b29a      	uxth	r2, r3
 800453e:	687b      	ldr	r3, [r7, #4]
 8004540:	819a      	strh	r2, [r3, #12]
 8004542:	e007      	b.n	8004554 <USART_Cmd+0x34>
  }
  else
  {
    /* Disable the selected USART by clearing the UE bit in the CR1 register */
    USARTx->CR1 &= CR1_UE_Reset;
 8004544:	687b      	ldr	r3, [r7, #4]
 8004546:	899b      	ldrh	r3, [r3, #12]
 8004548:	b29b      	uxth	r3, r3
 800454a:	f423 5300 	bic.w	r3, r3, #8192	; 0x2000
 800454e:	b29a      	uxth	r2, r3
 8004550:	687b      	ldr	r3, [r7, #4]
 8004552:	819a      	strh	r2, [r3, #12]
  }
}
 8004554:	f107 070c 	add.w	r7, r7, #12
 8004558:	46bd      	mov	sp, r7
 800455a:	bc80      	pop	{r7}
 800455c:	4770      	bx	lr
 800455e:	bf00      	nop

08004560 <USART_ITConfig>:
  * @param  NewState: new state of the specified USARTx interrupts.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void USART_ITConfig(USART_TypeDef* USARTx, uint16_t USART_IT, FunctionalState NewState)
{
 8004560:	b480      	push	{r7}
 8004562:	b087      	sub	sp, #28
 8004564:	af00      	add	r7, sp, #0
 8004566:	6078      	str	r0, [r7, #4]
 8004568:	4613      	mov	r3, r2
 800456a:	460a      	mov	r2, r1
 800456c:	807a      	strh	r2, [r7, #2]
 800456e:	707b      	strb	r3, [r7, #1]
  uint32_t usartreg = 0x00, itpos = 0x00, itmask = 0x00;
 8004570:	f04f 0300 	mov.w	r3, #0
 8004574:	613b      	str	r3, [r7, #16]
 8004576:	f04f 0300 	mov.w	r3, #0
 800457a:	60fb      	str	r3, [r7, #12]
 800457c:	f04f 0300 	mov.w	r3, #0
 8004580:	60bb      	str	r3, [r7, #8]
  uint32_t usartxbase = 0x00;
 8004582:	f04f 0300 	mov.w	r3, #0
 8004586:	617b      	str	r3, [r7, #20]
  if (USART_IT == USART_IT_CTS)
  {
    assert_param(IS_USART_123_PERIPH(USARTx));
  }   
  
  usartxbase = (uint32_t)USARTx;
 8004588:	687b      	ldr	r3, [r7, #4]
 800458a:	617b      	str	r3, [r7, #20]

  /* Get the USART register index */
  usartreg = (((uint8_t)USART_IT) >> 0x05);
 800458c:	887b      	ldrh	r3, [r7, #2]
 800458e:	b2db      	uxtb	r3, r3
 8004590:	ea4f 1353 	mov.w	r3, r3, lsr #5
 8004594:	b2db      	uxtb	r3, r3
 8004596:	613b      	str	r3, [r7, #16]

  /* Get the interrupt position */
  itpos = USART_IT & IT_Mask;
 8004598:	887b      	ldrh	r3, [r7, #2]
 800459a:	f003 031f 	and.w	r3, r3, #31
 800459e:	60fb      	str	r3, [r7, #12]
  itmask = (((uint32_t)0x01) << itpos);
 80045a0:	68fb      	ldr	r3, [r7, #12]
 80045a2:	f04f 0201 	mov.w	r2, #1
 80045a6:	fa02 f303 	lsl.w	r3, r2, r3
 80045aa:	60bb      	str	r3, [r7, #8]
    
  if (usartreg == 0x01) /* The IT is in CR1 register */
 80045ac:	693b      	ldr	r3, [r7, #16]
 80045ae:	2b01      	cmp	r3, #1
 80045b0:	d104      	bne.n	80045bc <USART_ITConfig+0x5c>
  {
    usartxbase += 0x0C;
 80045b2:	697b      	ldr	r3, [r7, #20]
 80045b4:	f103 030c 	add.w	r3, r3, #12
 80045b8:	617b      	str	r3, [r7, #20]
 80045ba:	e00b      	b.n	80045d4 <USART_ITConfig+0x74>
  }
  else if (usartreg == 0x02) /* The IT is in CR2 register */
 80045bc:	693b      	ldr	r3, [r7, #16]
 80045be:	2b02      	cmp	r3, #2
 80045c0:	d104      	bne.n	80045cc <USART_ITConfig+0x6c>
  {
    usartxbase += 0x10;
 80045c2:	697b      	ldr	r3, [r7, #20]
 80045c4:	f103 0310 	add.w	r3, r3, #16
 80045c8:	617b      	str	r3, [r7, #20]
 80045ca:	e003      	b.n	80045d4 <USART_ITConfig+0x74>
  }
  else /* The IT is in CR3 register */
  {
    usartxbase += 0x14; 
 80045cc:	697b      	ldr	r3, [r7, #20]
 80045ce:	f103 0314 	add.w	r3, r3, #20
 80045d2:	617b      	str	r3, [r7, #20]
  }
  if (NewState != DISABLE)
 80045d4:	787b      	ldrb	r3, [r7, #1]
 80045d6:	2b00      	cmp	r3, #0
 80045d8:	d006      	beq.n	80045e8 <USART_ITConfig+0x88>
  {
    *(__IO uint32_t*)usartxbase  |= itmask;
 80045da:	697b      	ldr	r3, [r7, #20]
 80045dc:	697a      	ldr	r2, [r7, #20]
 80045de:	6811      	ldr	r1, [r2, #0]
 80045e0:	68ba      	ldr	r2, [r7, #8]
 80045e2:	430a      	orrs	r2, r1
 80045e4:	601a      	str	r2, [r3, #0]
 80045e6:	e007      	b.n	80045f8 <USART_ITConfig+0x98>
  }
  else
  {
    *(__IO uint32_t*)usartxbase &= ~itmask;
 80045e8:	697b      	ldr	r3, [r7, #20]
 80045ea:	697a      	ldr	r2, [r7, #20]
 80045ec:	6811      	ldr	r1, [r2, #0]
 80045ee:	68ba      	ldr	r2, [r7, #8]
 80045f0:	ea6f 0202 	mvn.w	r2, r2
 80045f4:	400a      	ands	r2, r1
 80045f6:	601a      	str	r2, [r3, #0]
  }
}
 80045f8:	f107 071c 	add.w	r7, r7, #28
 80045fc:	46bd      	mov	sp, r7
 80045fe:	bc80      	pop	{r7}
 8004600:	4770      	bx	lr
 8004602:	bf00      	nop

08004604 <USART_DMACmd>:
  * @note The DMA mode is not available for UART5 except in the STM32
  *       High density value line devices(STM32F10X_HD_VL).  
  * @retval None
  */
void USART_DMACmd(USART_TypeDef* USARTx, uint16_t USART_DMAReq, FunctionalState NewState)
{
 8004604:	b480      	push	{r7}
 8004606:	b083      	sub	sp, #12
 8004608:	af00      	add	r7, sp, #0
 800460a:	6078      	str	r0, [r7, #4]
 800460c:	4613      	mov	r3, r2
 800460e:	460a      	mov	r2, r1
 8004610:	807a      	strh	r2, [r7, #2]
 8004612:	707b      	strb	r3, [r7, #1]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_USART_DMAREQ(USART_DMAReq));  
  assert_param(IS_FUNCTIONAL_STATE(NewState)); 
  if (NewState != DISABLE)
 8004614:	787b      	ldrb	r3, [r7, #1]
 8004616:	2b00      	cmp	r3, #0
 8004618:	d008      	beq.n	800462c <USART_DMACmd+0x28>
  {
    /* Enable the DMA transfer for selected requests by setting the DMAT and/or
       DMAR bits in the USART CR3 register */
    USARTx->CR3 |= USART_DMAReq;
 800461a:	687b      	ldr	r3, [r7, #4]
 800461c:	8a9b      	ldrh	r3, [r3, #20]
 800461e:	b29a      	uxth	r2, r3
 8004620:	887b      	ldrh	r3, [r7, #2]
 8004622:	4313      	orrs	r3, r2
 8004624:	b29a      	uxth	r2, r3
 8004626:	687b      	ldr	r3, [r7, #4]
 8004628:	829a      	strh	r2, [r3, #20]
 800462a:	e00a      	b.n	8004642 <USART_DMACmd+0x3e>
  }
  else
  {
    /* Disable the DMA transfer for selected requests by clearing the DMAT and/or
       DMAR bits in the USART CR3 register */
    USARTx->CR3 &= (uint16_t)~USART_DMAReq;
 800462c:	687b      	ldr	r3, [r7, #4]
 800462e:	8a9b      	ldrh	r3, [r3, #20]
 8004630:	b29a      	uxth	r2, r3
 8004632:	887b      	ldrh	r3, [r7, #2]
 8004634:	ea6f 0303 	mvn.w	r3, r3
 8004638:	b29b      	uxth	r3, r3
 800463a:	4013      	ands	r3, r2
 800463c:	b29a      	uxth	r2, r3
 800463e:	687b      	ldr	r3, [r7, #4]
 8004640:	829a      	strh	r2, [r3, #20]
  }
}
 8004642:	f107 070c 	add.w	r7, r7, #12
 8004646:	46bd      	mov	sp, r7
 8004648:	bc80      	pop	{r7}
 800464a:	4770      	bx	lr

0800464c <USART_SetAddress>:
  *   USART1, USART2, USART3, UART4 or UART5.
  * @param  USART_Address: Indicates the address of the USART node.
  * @retval None
  */
void USART_SetAddress(USART_TypeDef* USARTx, uint8_t USART_Address)
{
 800464c:	b480      	push	{r7}
 800464e:	b083      	sub	sp, #12
 8004650:	af00      	add	r7, sp, #0
 8004652:	6078      	str	r0, [r7, #4]
 8004654:	460b      	mov	r3, r1
 8004656:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_USART_ADDRESS(USART_Address)); 
    
  /* Clear the USART address */
  USARTx->CR2 &= CR2_Address_Mask;
 8004658:	687b      	ldr	r3, [r7, #4]
 800465a:	8a1b      	ldrh	r3, [r3, #16]
 800465c:	b29b      	uxth	r3, r3
 800465e:	f023 030f 	bic.w	r3, r3, #15
 8004662:	b29a      	uxth	r2, r3
 8004664:	687b      	ldr	r3, [r7, #4]
 8004666:	821a      	strh	r2, [r3, #16]
  /* Set the USART address node */
  USARTx->CR2 |= USART_Address;
 8004668:	687b      	ldr	r3, [r7, #4]
 800466a:	8a1b      	ldrh	r3, [r3, #16]
 800466c:	b29a      	uxth	r2, r3
 800466e:	78fb      	ldrb	r3, [r7, #3]
 8004670:	b29b      	uxth	r3, r3
 8004672:	4313      	orrs	r3, r2
 8004674:	b29a      	uxth	r2, r3
 8004676:	687b      	ldr	r3, [r7, #4]
 8004678:	821a      	strh	r2, [r3, #16]
}
 800467a:	f107 070c 	add.w	r7, r7, #12
 800467e:	46bd      	mov	sp, r7
 8004680:	bc80      	pop	{r7}
 8004682:	4770      	bx	lr

08004684 <USART_WakeUpConfig>:
  *     @arg USART_WakeUp_IdleLine: WakeUp by an idle line detection
  *     @arg USART_WakeUp_AddressMark: WakeUp by an address mark
  * @retval None
  */
void USART_WakeUpConfig(USART_TypeDef* USARTx, uint16_t USART_WakeUp)
{
 8004684:	b480      	push	{r7}
 8004686:	b083      	sub	sp, #12
 8004688:	af00      	add	r7, sp, #0
 800468a:	6078      	str	r0, [r7, #4]
 800468c:	460b      	mov	r3, r1
 800468e:	807b      	strh	r3, [r7, #2]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_USART_WAKEUP(USART_WakeUp));
  
  USARTx->CR1 &= CR1_WAKE_Mask;
 8004690:	687b      	ldr	r3, [r7, #4]
 8004692:	899b      	ldrh	r3, [r3, #12]
 8004694:	b29b      	uxth	r3, r3
 8004696:	f423 6300 	bic.w	r3, r3, #2048	; 0x800
 800469a:	b29a      	uxth	r2, r3
 800469c:	687b      	ldr	r3, [r7, #4]
 800469e:	819a      	strh	r2, [r3, #12]
  USARTx->CR1 |= USART_WakeUp;
 80046a0:	687b      	ldr	r3, [r7, #4]
 80046a2:	899b      	ldrh	r3, [r3, #12]
 80046a4:	b29a      	uxth	r2, r3
 80046a6:	887b      	ldrh	r3, [r7, #2]
 80046a8:	4313      	orrs	r3, r2
 80046aa:	b29a      	uxth	r2, r3
 80046ac:	687b      	ldr	r3, [r7, #4]
 80046ae:	819a      	strh	r2, [r3, #12]
}
 80046b0:	f107 070c 	add.w	r7, r7, #12
 80046b4:	46bd      	mov	sp, r7
 80046b6:	bc80      	pop	{r7}
 80046b8:	4770      	bx	lr
 80046ba:	bf00      	nop

080046bc <USART_ReceiverWakeUpCmd>:
  * @param  NewState: new state of the USART mute mode.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void USART_ReceiverWakeUpCmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
 80046bc:	b480      	push	{r7}
 80046be:	b083      	sub	sp, #12
 80046c0:	af00      	add	r7, sp, #0
 80046c2:	6078      	str	r0, [r7, #4]
 80046c4:	460b      	mov	r3, r1
 80046c6:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_FUNCTIONAL_STATE(NewState)); 
  
  if (NewState != DISABLE)
 80046c8:	78fb      	ldrb	r3, [r7, #3]
 80046ca:	2b00      	cmp	r3, #0
 80046cc:	d008      	beq.n	80046e0 <USART_ReceiverWakeUpCmd+0x24>
  {
    /* Enable the USART mute mode  by setting the RWU bit in the CR1 register */
    USARTx->CR1 |= CR1_RWU_Set;
 80046ce:	687b      	ldr	r3, [r7, #4]
 80046d0:	899b      	ldrh	r3, [r3, #12]
 80046d2:	b29b      	uxth	r3, r3
 80046d4:	f043 0302 	orr.w	r3, r3, #2
 80046d8:	b29a      	uxth	r2, r3
 80046da:	687b      	ldr	r3, [r7, #4]
 80046dc:	819a      	strh	r2, [r3, #12]
 80046de:	e007      	b.n	80046f0 <USART_ReceiverWakeUpCmd+0x34>
  }
  else
  {
    /* Disable the USART mute mode by clearing the RWU bit in the CR1 register */
    USARTx->CR1 &= CR1_RWU_Reset;
 80046e0:	687b      	ldr	r3, [r7, #4]
 80046e2:	899b      	ldrh	r3, [r3, #12]
 80046e4:	b29b      	uxth	r3, r3
 80046e6:	f023 0302 	bic.w	r3, r3, #2
 80046ea:	b29a      	uxth	r2, r3
 80046ec:	687b      	ldr	r3, [r7, #4]
 80046ee:	819a      	strh	r2, [r3, #12]
  }
}
 80046f0:	f107 070c 	add.w	r7, r7, #12
 80046f4:	46bd      	mov	sp, r7
 80046f6:	bc80      	pop	{r7}
 80046f8:	4770      	bx	lr
 80046fa:	bf00      	nop

080046fc <USART_LINBreakDetectLengthConfig>:
  *     @arg USART_LINBreakDetectLength_10b: 10-bit break detection
  *     @arg USART_LINBreakDetectLength_11b: 11-bit break detection
  * @retval None
  */
void USART_LINBreakDetectLengthConfig(USART_TypeDef* USARTx, uint16_t USART_LINBreakDetectLength)
{
 80046fc:	b480      	push	{r7}
 80046fe:	b083      	sub	sp, #12
 8004700:	af00      	add	r7, sp, #0
 8004702:	6078      	str	r0, [r7, #4]
 8004704:	460b      	mov	r3, r1
 8004706:	807b      	strh	r3, [r7, #2]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_USART_LIN_BREAK_DETECT_LENGTH(USART_LINBreakDetectLength));
  
  USARTx->CR2 &= CR2_LBDL_Mask;
 8004708:	687b      	ldr	r3, [r7, #4]
 800470a:	8a1b      	ldrh	r3, [r3, #16]
 800470c:	b29b      	uxth	r3, r3
 800470e:	f023 0320 	bic.w	r3, r3, #32
 8004712:	b29a      	uxth	r2, r3
 8004714:	687b      	ldr	r3, [r7, #4]
 8004716:	821a      	strh	r2, [r3, #16]
  USARTx->CR2 |= USART_LINBreakDetectLength;  
 8004718:	687b      	ldr	r3, [r7, #4]
 800471a:	8a1b      	ldrh	r3, [r3, #16]
 800471c:	b29a      	uxth	r2, r3
 800471e:	887b      	ldrh	r3, [r7, #2]
 8004720:	4313      	orrs	r3, r2
 8004722:	b29a      	uxth	r2, r3
 8004724:	687b      	ldr	r3, [r7, #4]
 8004726:	821a      	strh	r2, [r3, #16]
}
 8004728:	f107 070c 	add.w	r7, r7, #12
 800472c:	46bd      	mov	sp, r7
 800472e:	bc80      	pop	{r7}
 8004730:	4770      	bx	lr
 8004732:	bf00      	nop

08004734 <USART_LINCmd>:
  * @param  NewState: new state of the USART LIN mode.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void USART_LINCmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
 8004734:	b480      	push	{r7}
 8004736:	b083      	sub	sp, #12
 8004738:	af00      	add	r7, sp, #0
 800473a:	6078      	str	r0, [r7, #4]
 800473c:	460b      	mov	r3, r1
 800473e:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 8004740:	78fb      	ldrb	r3, [r7, #3]
 8004742:	2b00      	cmp	r3, #0
 8004744:	d008      	beq.n	8004758 <USART_LINCmd+0x24>
  {
    /* Enable the LIN mode by setting the LINEN bit in the CR2 register */
    USARTx->CR2 |= CR2_LINEN_Set;
 8004746:	687b      	ldr	r3, [r7, #4]
 8004748:	8a1b      	ldrh	r3, [r3, #16]
 800474a:	b29b      	uxth	r3, r3
 800474c:	f443 4380 	orr.w	r3, r3, #16384	; 0x4000
 8004750:	b29a      	uxth	r2, r3
 8004752:	687b      	ldr	r3, [r7, #4]
 8004754:	821a      	strh	r2, [r3, #16]
 8004756:	e007      	b.n	8004768 <USART_LINCmd+0x34>
  }
  else
  {
    /* Disable the LIN mode by clearing the LINEN bit in the CR2 register */
    USARTx->CR2 &= CR2_LINEN_Reset;
 8004758:	687b      	ldr	r3, [r7, #4]
 800475a:	8a1b      	ldrh	r3, [r3, #16]
 800475c:	b29b      	uxth	r3, r3
 800475e:	f423 4380 	bic.w	r3, r3, #16384	; 0x4000
 8004762:	b29a      	uxth	r2, r3
 8004764:	687b      	ldr	r3, [r7, #4]
 8004766:	821a      	strh	r2, [r3, #16]
  }
}
 8004768:	f107 070c 	add.w	r7, r7, #12
 800476c:	46bd      	mov	sp, r7
 800476e:	bc80      	pop	{r7}
 8004770:	4770      	bx	lr
 8004772:	bf00      	nop

08004774 <USART_SendData>:
  *   USART1, USART2, USART3, UART4 or UART5.
  * @param  Data: the data to transmit.
  * @retval None
  */
void USART_SendData(USART_TypeDef* USARTx, uint16_t Data)
{
 8004774:	b480      	push	{r7}
 8004776:	b083      	sub	sp, #12
 8004778:	af00      	add	r7, sp, #0
 800477a:	6078      	str	r0, [r7, #4]
 800477c:	460b      	mov	r3, r1
 800477e:	807b      	strh	r3, [r7, #2]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_USART_DATA(Data)); 
    
  /* Transmit Data */
  USARTx->DR = (Data & (uint16_t)0x01FF);
 8004780:	887b      	ldrh	r3, [r7, #2]
 8004782:	ea4f 53c3 	mov.w	r3, r3, lsl #23
 8004786:	ea4f 53d3 	mov.w	r3, r3, lsr #23
 800478a:	b29a      	uxth	r2, r3
 800478c:	687b      	ldr	r3, [r7, #4]
 800478e:	809a      	strh	r2, [r3, #4]
}
 8004790:	f107 070c 	add.w	r7, r7, #12
 8004794:	46bd      	mov	sp, r7
 8004796:	bc80      	pop	{r7}
 8004798:	4770      	bx	lr
 800479a:	bf00      	nop

0800479c <USART_ReceiveData>:
  *   This parameter can be one of the following values:
  *   USART1, USART2, USART3, UART4 or UART5.
  * @retval The received data.
  */
uint16_t USART_ReceiveData(USART_TypeDef* USARTx)
{
 800479c:	b480      	push	{r7}
 800479e:	b083      	sub	sp, #12
 80047a0:	af00      	add	r7, sp, #0
 80047a2:	6078      	str	r0, [r7, #4]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  
  /* Receive Data */
  return (uint16_t)(USARTx->DR & (uint16_t)0x01FF);
 80047a4:	687b      	ldr	r3, [r7, #4]
 80047a6:	889b      	ldrh	r3, [r3, #4]
 80047a8:	b29b      	uxth	r3, r3
 80047aa:	ea4f 53c3 	mov.w	r3, r3, lsl #23
 80047ae:	ea4f 53d3 	mov.w	r3, r3, lsr #23
 80047b2:	b29b      	uxth	r3, r3
}
 80047b4:	4618      	mov	r0, r3
 80047b6:	f107 070c 	add.w	r7, r7, #12
 80047ba:	46bd      	mov	sp, r7
 80047bc:	bc80      	pop	{r7}
 80047be:	4770      	bx	lr

080047c0 <USART_SendBreak>:
  *   This parameter can be one of the following values:
  *   USART1, USART2, USART3, UART4 or UART5.
  * @retval None
  */
void USART_SendBreak(USART_TypeDef* USARTx)
{
 80047c0:	b480      	push	{r7}
 80047c2:	b083      	sub	sp, #12
 80047c4:	af00      	add	r7, sp, #0
 80047c6:	6078      	str	r0, [r7, #4]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  
  /* Send break characters */
  USARTx->CR1 |= CR1_SBK_Set;
 80047c8:	687b      	ldr	r3, [r7, #4]
 80047ca:	899b      	ldrh	r3, [r3, #12]
 80047cc:	b29b      	uxth	r3, r3
 80047ce:	f043 0301 	orr.w	r3, r3, #1
 80047d2:	b29a      	uxth	r2, r3
 80047d4:	687b      	ldr	r3, [r7, #4]
 80047d6:	819a      	strh	r2, [r3, #12]
}
 80047d8:	f107 070c 	add.w	r7, r7, #12
 80047dc:	46bd      	mov	sp, r7
 80047de:	bc80      	pop	{r7}
 80047e0:	4770      	bx	lr
 80047e2:	bf00      	nop

080047e4 <USART_SetGuardTime>:
  * @param  USART_GuardTime: specifies the guard time.
  * @note The guard time bits are not available for UART4 and UART5.   
  * @retval None
  */
void USART_SetGuardTime(USART_TypeDef* USARTx, uint8_t USART_GuardTime)
{    
 80047e4:	b480      	push	{r7}
 80047e6:	b083      	sub	sp, #12
 80047e8:	af00      	add	r7, sp, #0
 80047ea:	6078      	str	r0, [r7, #4]
 80047ec:	460b      	mov	r3, r1
 80047ee:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_123_PERIPH(USARTx));
  
  /* Clear the USART Guard time */
  USARTx->GTPR &= GTPR_LSB_Mask;
 80047f0:	687b      	ldr	r3, [r7, #4]
 80047f2:	8b1b      	ldrh	r3, [r3, #24]
 80047f4:	b29b      	uxth	r3, r3
 80047f6:	b2db      	uxtb	r3, r3
 80047f8:	b29a      	uxth	r2, r3
 80047fa:	687b      	ldr	r3, [r7, #4]
 80047fc:	831a      	strh	r2, [r3, #24]
  /* Set the USART guard time */
  USARTx->GTPR |= (uint16_t)((uint16_t)USART_GuardTime << 0x08);
 80047fe:	687b      	ldr	r3, [r7, #4]
 8004800:	8b1b      	ldrh	r3, [r3, #24]
 8004802:	b29a      	uxth	r2, r3
 8004804:	78fb      	ldrb	r3, [r7, #3]
 8004806:	b29b      	uxth	r3, r3
 8004808:	ea4f 2303 	mov.w	r3, r3, lsl #8
 800480c:	b29b      	uxth	r3, r3
 800480e:	4313      	orrs	r3, r2
 8004810:	b29a      	uxth	r2, r3
 8004812:	687b      	ldr	r3, [r7, #4]
 8004814:	831a      	strh	r2, [r3, #24]
}
 8004816:	f107 070c 	add.w	r7, r7, #12
 800481a:	46bd      	mov	sp, r7
 800481c:	bc80      	pop	{r7}
 800481e:	4770      	bx	lr

08004820 <USART_SetPrescaler>:
  * @param  USART_Prescaler: specifies the prescaler clock.  
  * @note   The function is used for IrDA mode with UART4 and UART5.
  * @retval None
  */
void USART_SetPrescaler(USART_TypeDef* USARTx, uint8_t USART_Prescaler)
{ 
 8004820:	b480      	push	{r7}
 8004822:	b083      	sub	sp, #12
 8004824:	af00      	add	r7, sp, #0
 8004826:	6078      	str	r0, [r7, #4]
 8004828:	460b      	mov	r3, r1
 800482a:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  
  /* Clear the USART prescaler */
  USARTx->GTPR &= GTPR_MSB_Mask;
 800482c:	687b      	ldr	r3, [r7, #4]
 800482e:	8b1b      	ldrh	r3, [r3, #24]
 8004830:	b29b      	uxth	r3, r3
 8004832:	f023 03ff 	bic.w	r3, r3, #255	; 0xff
 8004836:	b29a      	uxth	r2, r3
 8004838:	687b      	ldr	r3, [r7, #4]
 800483a:	831a      	strh	r2, [r3, #24]
  /* Set the USART prescaler */
  USARTx->GTPR |= USART_Prescaler;
 800483c:	687b      	ldr	r3, [r7, #4]
 800483e:	8b1b      	ldrh	r3, [r3, #24]
 8004840:	b29a      	uxth	r2, r3
 8004842:	78fb      	ldrb	r3, [r7, #3]
 8004844:	b29b      	uxth	r3, r3
 8004846:	4313      	orrs	r3, r2
 8004848:	b29a      	uxth	r2, r3
 800484a:	687b      	ldr	r3, [r7, #4]
 800484c:	831a      	strh	r2, [r3, #24]
}
 800484e:	f107 070c 	add.w	r7, r7, #12
 8004852:	46bd      	mov	sp, r7
 8004854:	bc80      	pop	{r7}
 8004856:	4770      	bx	lr

08004858 <USART_SmartCardCmd>:
  *   This parameter can be: ENABLE or DISABLE.     
  * @note The Smart Card mode is not available for UART4 and UART5. 
  * @retval None
  */
void USART_SmartCardCmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
 8004858:	b480      	push	{r7}
 800485a:	b083      	sub	sp, #12
 800485c:	af00      	add	r7, sp, #0
 800485e:	6078      	str	r0, [r7, #4]
 8004860:	460b      	mov	r3, r1
 8004862:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_123_PERIPH(USARTx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
 8004864:	78fb      	ldrb	r3, [r7, #3]
 8004866:	2b00      	cmp	r3, #0
 8004868:	d008      	beq.n	800487c <USART_SmartCardCmd+0x24>
  {
    /* Enable the SC mode by setting the SCEN bit in the CR3 register */
    USARTx->CR3 |= CR3_SCEN_Set;
 800486a:	687b      	ldr	r3, [r7, #4]
 800486c:	8a9b      	ldrh	r3, [r3, #20]
 800486e:	b29b      	uxth	r3, r3
 8004870:	f043 0320 	orr.w	r3, r3, #32
 8004874:	b29a      	uxth	r2, r3
 8004876:	687b      	ldr	r3, [r7, #4]
 8004878:	829a      	strh	r2, [r3, #20]
 800487a:	e007      	b.n	800488c <USART_SmartCardCmd+0x34>
  }
  else
  {
    /* Disable the SC mode by clearing the SCEN bit in the CR3 register */
    USARTx->CR3 &= CR3_SCEN_Reset;
 800487c:	687b      	ldr	r3, [r7, #4]
 800487e:	8a9b      	ldrh	r3, [r3, #20]
 8004880:	b29b      	uxth	r3, r3
 8004882:	f023 0320 	bic.w	r3, r3, #32
 8004886:	b29a      	uxth	r2, r3
 8004888:	687b      	ldr	r3, [r7, #4]
 800488a:	829a      	strh	r2, [r3, #20]
  }
}
 800488c:	f107 070c 	add.w	r7, r7, #12
 8004890:	46bd      	mov	sp, r7
 8004892:	bc80      	pop	{r7}
 8004894:	4770      	bx	lr
 8004896:	bf00      	nop

08004898 <USART_SmartCardNACKCmd>:
  *   This parameter can be: ENABLE or DISABLE.  
  * @note The Smart Card mode is not available for UART4 and UART5.
  * @retval None
  */
void USART_SmartCardNACKCmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
 8004898:	b480      	push	{r7}
 800489a:	b083      	sub	sp, #12
 800489c:	af00      	add	r7, sp, #0
 800489e:	6078      	str	r0, [r7, #4]
 80048a0:	460b      	mov	r3, r1
 80048a2:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_123_PERIPH(USARTx));  
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  if (NewState != DISABLE)
 80048a4:	78fb      	ldrb	r3, [r7, #3]
 80048a6:	2b00      	cmp	r3, #0
 80048a8:	d008      	beq.n	80048bc <USART_SmartCardNACKCmd+0x24>
  {
    /* Enable the NACK transmission by setting the NACK bit in the CR3 register */
    USARTx->CR3 |= CR3_NACK_Set;
 80048aa:	687b      	ldr	r3, [r7, #4]
 80048ac:	8a9b      	ldrh	r3, [r3, #20]
 80048ae:	b29b      	uxth	r3, r3
 80048b0:	f043 0310 	orr.w	r3, r3, #16
 80048b4:	b29a      	uxth	r2, r3
 80048b6:	687b      	ldr	r3, [r7, #4]
 80048b8:	829a      	strh	r2, [r3, #20]
 80048ba:	e007      	b.n	80048cc <USART_SmartCardNACKCmd+0x34>
  }
  else
  {
    /* Disable the NACK transmission by clearing the NACK bit in the CR3 register */
    USARTx->CR3 &= CR3_NACK_Reset;
 80048bc:	687b      	ldr	r3, [r7, #4]
 80048be:	8a9b      	ldrh	r3, [r3, #20]
 80048c0:	b29b      	uxth	r3, r3
 80048c2:	f023 0310 	bic.w	r3, r3, #16
 80048c6:	b29a      	uxth	r2, r3
 80048c8:	687b      	ldr	r3, [r7, #4]
 80048ca:	829a      	strh	r2, [r3, #20]
  }
}
 80048cc:	f107 070c 	add.w	r7, r7, #12
 80048d0:	46bd      	mov	sp, r7
 80048d2:	bc80      	pop	{r7}
 80048d4:	4770      	bx	lr
 80048d6:	bf00      	nop

080048d8 <USART_HalfDuplexCmd>:
  * @param  NewState: new state of the USART Communication.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void USART_HalfDuplexCmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
 80048d8:	b480      	push	{r7}
 80048da:	b083      	sub	sp, #12
 80048dc:	af00      	add	r7, sp, #0
 80048de:	6078      	str	r0, [r7, #4]
 80048e0:	460b      	mov	r3, r1
 80048e2:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 80048e4:	78fb      	ldrb	r3, [r7, #3]
 80048e6:	2b00      	cmp	r3, #0
 80048e8:	d008      	beq.n	80048fc <USART_HalfDuplexCmd+0x24>
  {
    /* Enable the Half-Duplex mode by setting the HDSEL bit in the CR3 register */
    USARTx->CR3 |= CR3_HDSEL_Set;
 80048ea:	687b      	ldr	r3, [r7, #4]
 80048ec:	8a9b      	ldrh	r3, [r3, #20]
 80048ee:	b29b      	uxth	r3, r3
 80048f0:	f043 0308 	orr.w	r3, r3, #8
 80048f4:	b29a      	uxth	r2, r3
 80048f6:	687b      	ldr	r3, [r7, #4]
 80048f8:	829a      	strh	r2, [r3, #20]
 80048fa:	e007      	b.n	800490c <USART_HalfDuplexCmd+0x34>
  }
  else
  {
    /* Disable the Half-Duplex mode by clearing the HDSEL bit in the CR3 register */
    USARTx->CR3 &= CR3_HDSEL_Reset;
 80048fc:	687b      	ldr	r3, [r7, #4]
 80048fe:	8a9b      	ldrh	r3, [r3, #20]
 8004900:	b29b      	uxth	r3, r3
 8004902:	f023 0308 	bic.w	r3, r3, #8
 8004906:	b29a      	uxth	r2, r3
 8004908:	687b      	ldr	r3, [r7, #4]
 800490a:	829a      	strh	r2, [r3, #20]
  }
}
 800490c:	f107 070c 	add.w	r7, r7, #12
 8004910:	46bd      	mov	sp, r7
 8004912:	bc80      	pop	{r7}
 8004914:	4770      	bx	lr
 8004916:	bf00      	nop

08004918 <USART_OverSampling8Cmd>:
  *     This function has to be called before calling USART_Init()
  *     function in order to have correct baudrate Divider value.   
  * @retval None
  */
void USART_OverSampling8Cmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
 8004918:	b480      	push	{r7}
 800491a:	b083      	sub	sp, #12
 800491c:	af00      	add	r7, sp, #0
 800491e:	6078      	str	r0, [r7, #4]
 8004920:	460b      	mov	r3, r1
 8004922:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 8004924:	78fb      	ldrb	r3, [r7, #3]
 8004926:	2b00      	cmp	r3, #0
 8004928:	d00a      	beq.n	8004940 <USART_OverSampling8Cmd+0x28>
  {
    /* Enable the 8x Oversampling mode by setting the OVER8 bit in the CR1 register */
    USARTx->CR1 |= CR1_OVER8_Set;
 800492a:	687b      	ldr	r3, [r7, #4]
 800492c:	899b      	ldrh	r3, [r3, #12]
 800492e:	b29b      	uxth	r3, r3
 8004930:	ea6f 4343 	mvn.w	r3, r3, lsl #17
 8004934:	ea6f 4353 	mvn.w	r3, r3, lsr #17
 8004938:	b29a      	uxth	r2, r3
 800493a:	687b      	ldr	r3, [r7, #4]
 800493c:	819a      	strh	r2, [r3, #12]
 800493e:	e009      	b.n	8004954 <USART_OverSampling8Cmd+0x3c>
  }
  else
  {
    /* Disable the 8x Oversampling mode by clearing the OVER8 bit in the CR1 register */
    USARTx->CR1 &= CR1_OVER8_Reset;
 8004940:	687b      	ldr	r3, [r7, #4]
 8004942:	899b      	ldrh	r3, [r3, #12]
 8004944:	b29b      	uxth	r3, r3
 8004946:	ea4f 4343 	mov.w	r3, r3, lsl #17
 800494a:	ea4f 4353 	mov.w	r3, r3, lsr #17
 800494e:	b29a      	uxth	r2, r3
 8004950:	687b      	ldr	r3, [r7, #4]
 8004952:	819a      	strh	r2, [r3, #12]
  }
}
 8004954:	f107 070c 	add.w	r7, r7, #12
 8004958:	46bd      	mov	sp, r7
 800495a:	bc80      	pop	{r7}
 800495c:	4770      	bx	lr
 800495e:	bf00      	nop

08004960 <USART_OneBitMethodCmd>:
  * @param  NewState: new state of the USART one bit sampling method.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void USART_OneBitMethodCmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
 8004960:	b480      	push	{r7}
 8004962:	b083      	sub	sp, #12
 8004964:	af00      	add	r7, sp, #0
 8004966:	6078      	str	r0, [r7, #4]
 8004968:	460b      	mov	r3, r1
 800496a:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
  
  if (NewState != DISABLE)
 800496c:	78fb      	ldrb	r3, [r7, #3]
 800496e:	2b00      	cmp	r3, #0
 8004970:	d008      	beq.n	8004984 <USART_OneBitMethodCmd+0x24>
  {
    /* Enable the one bit method by setting the ONEBITE bit in the CR3 register */
    USARTx->CR3 |= CR3_ONEBITE_Set;
 8004972:	687b      	ldr	r3, [r7, #4]
 8004974:	8a9b      	ldrh	r3, [r3, #20]
 8004976:	b29b      	uxth	r3, r3
 8004978:	f443 6300 	orr.w	r3, r3, #2048	; 0x800
 800497c:	b29a      	uxth	r2, r3
 800497e:	687b      	ldr	r3, [r7, #4]
 8004980:	829a      	strh	r2, [r3, #20]
 8004982:	e007      	b.n	8004994 <USART_OneBitMethodCmd+0x34>
  }
  else
  {
    /* Disable tthe one bit method by clearing the ONEBITE bit in the CR3 register */
    USARTx->CR3 &= CR3_ONEBITE_Reset;
 8004984:	687b      	ldr	r3, [r7, #4]
 8004986:	8a9b      	ldrh	r3, [r3, #20]
 8004988:	b29b      	uxth	r3, r3
 800498a:	f423 6300 	bic.w	r3, r3, #2048	; 0x800
 800498e:	b29a      	uxth	r2, r3
 8004990:	687b      	ldr	r3, [r7, #4]
 8004992:	829a      	strh	r2, [r3, #20]
  }
}
 8004994:	f107 070c 	add.w	r7, r7, #12
 8004998:	46bd      	mov	sp, r7
 800499a:	bc80      	pop	{r7}
 800499c:	4770      	bx	lr
 800499e:	bf00      	nop

080049a0 <USART_IrDAConfig>:
  *     @arg USART_IrDAMode_LowPower
  *     @arg USART_IrDAMode_Normal
  * @retval None
  */
void USART_IrDAConfig(USART_TypeDef* USARTx, uint16_t USART_IrDAMode)
{
 80049a0:	b480      	push	{r7}
 80049a2:	b083      	sub	sp, #12
 80049a4:	af00      	add	r7, sp, #0
 80049a6:	6078      	str	r0, [r7, #4]
 80049a8:	460b      	mov	r3, r1
 80049aa:	807b      	strh	r3, [r7, #2]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_USART_IRDA_MODE(USART_IrDAMode));
    
  USARTx->CR3 &= CR3_IRLP_Mask;
 80049ac:	687b      	ldr	r3, [r7, #4]
 80049ae:	8a9b      	ldrh	r3, [r3, #20]
 80049b0:	b29b      	uxth	r3, r3
 80049b2:	f023 0304 	bic.w	r3, r3, #4
 80049b6:	b29a      	uxth	r2, r3
 80049b8:	687b      	ldr	r3, [r7, #4]
 80049ba:	829a      	strh	r2, [r3, #20]
  USARTx->CR3 |= USART_IrDAMode;
 80049bc:	687b      	ldr	r3, [r7, #4]
 80049be:	8a9b      	ldrh	r3, [r3, #20]
 80049c0:	b29a      	uxth	r2, r3
 80049c2:	887b      	ldrh	r3, [r7, #2]
 80049c4:	4313      	orrs	r3, r2
 80049c6:	b29a      	uxth	r2, r3
 80049c8:	687b      	ldr	r3, [r7, #4]
 80049ca:	829a      	strh	r2, [r3, #20]
}
 80049cc:	f107 070c 	add.w	r7, r7, #12
 80049d0:	46bd      	mov	sp, r7
 80049d2:	bc80      	pop	{r7}
 80049d4:	4770      	bx	lr
 80049d6:	bf00      	nop

080049d8 <USART_IrDACmd>:
  * @param  NewState: new state of the IrDA mode.
  *   This parameter can be: ENABLE or DISABLE.
  * @retval None
  */
void USART_IrDACmd(USART_TypeDef* USARTx, FunctionalState NewState)
{
 80049d8:	b480      	push	{r7}
 80049da:	b083      	sub	sp, #12
 80049dc:	af00      	add	r7, sp, #0
 80049de:	6078      	str	r0, [r7, #4]
 80049e0:	460b      	mov	r3, r1
 80049e2:	70fb      	strb	r3, [r7, #3]
  /* Check the parameters */
  assert_param(IS_USART_ALL_PERIPH(USARTx));
  assert_param(IS_FUNCTIONAL_STATE(NewState));
    
  if (NewState != DISABLE)
 80049e4:	78fb      	ldrb	r3, [r7, #3]
 80049e6:	2b00      	cmp	r3, #0
 80049e8:	d008      	beq.n	80049fc <USART_IrDACmd+0x24>
  {
    /* Enable the IrDA mode by setting the IREN bit in the CR3 register */
    USARTx->CR3 |= CR3_IREN_Set;
 80049ea:	687b      	ldr	r3, [r7, #4]
 80049ec:	8a9b      	ldrh	r3, [r3, #20]
 80049ee:	b29b      	uxth	r3, r3
 80049f0:	f043 0302 	orr.w	r3, r3, #2
 80049f4:	b29a      	uxth	r2, r3
 80049f6:	687b      	ldr	r3, [r7, #4]
 80049f8:	829a      	strh	r2, [r3, #20]
 80049fa:	e007      	b.n	8004a0c <USART_IrDACmd+0x34>
  }
  else
  {
    /* Disable the IrDA mode by clearing the IREN bit in the CR3 register */
    USARTx->CR3 &= CR3_IREN_Reset;
 80049fc:	687b      	ldr	r3, [r7, #4]
 80049fe:	8a9b      	ldrh	r3, [r3, #20]
 8004a00:	b29b      	uxth	r3, r3
 8004a02:	f023 0302 	bic.w	r3, r3, #2
 8004a06:	b29a      	uxth	r2, r3
 8004a08:	687b      	ldr	r3, [r7, #4]
 8004a0a:	829a      	strh	r2, [r3, #20]
  }
}
 8004a0c:	f107 070c 	add.w	r7, r7, #12
 8004a10:	46bd      	mov	sp, r7
 8004a12:	bc80      	pop	{r7}
 8004a14:	4770      	bx	lr
 8004a16:	bf00      	nop

08004a18 <USART_GetFlagStatus>:
  *     @arg USART_FLAG_FE:   Framing Error flag
  *     @arg USART_FLAG_PE:   Parity Error flag
  * @retval The new state of USART_FLAG (SET or RESET).
  */
FlagStatus USART_GetFlagStatus(USART_TypeDef* USARTx, uint16_t USART_FLAG)
{
 8004a18:	b480      	push	{r7}
 8004a1a:	b085      	sub	sp, #20
 8004a1c:	af00      	add	r7, sp, #0
 8004a1e:	6078      	str	r0, [r7, #4]
 8004a20:	460b      	mov	r3, r1
 8004a22:	807b      	strh	r3, [r7, #2]
  FlagStatus bitstatus = RESET;
 8004a24:	f04f 0300 	mov.w	r3, #0
 8004a28:	73fb      	strb	r3, [r7, #15]
  if (USART_FLAG == USART_FLAG_CTS)
  {
    assert_param(IS_USART_123_PERIPH(USARTx));
  }  
  
  if ((USARTx->SR & USART_FLAG) != (uint16_t)RESET)
 8004a2a:	687b      	ldr	r3, [r7, #4]
 8004a2c:	881b      	ldrh	r3, [r3, #0]
 8004a2e:	b29a      	uxth	r2, r3
 8004a30:	887b      	ldrh	r3, [r7, #2]
 8004a32:	4013      	ands	r3, r2
 8004a34:	b29b      	uxth	r3, r3
 8004a36:	2b00      	cmp	r3, #0
 8004a38:	d003      	beq.n	8004a42 <USART_GetFlagStatus+0x2a>
  {
    bitstatus = SET;
 8004a3a:	f04f 0301 	mov.w	r3, #1
 8004a3e:	73fb      	strb	r3, [r7, #15]
 8004a40:	e002      	b.n	8004a48 <USART_GetFlagStatus+0x30>
  }
  else
  {
    bitstatus = RESET;
 8004a42:	f04f 0300 	mov.w	r3, #0
 8004a46:	73fb      	strb	r3, [r7, #15]
  }
  return bitstatus;
 8004a48:	7bfb      	ldrb	r3, [r7, #15]
}
 8004a4a:	4618      	mov	r0, r3
 8004a4c:	f107 0714 	add.w	r7, r7, #20
 8004a50:	46bd      	mov	sp, r7
 8004a52:	bc80      	pop	{r7}
 8004a54:	4770      	bx	lr
 8004a56:	bf00      	nop

08004a58 <USART_ClearFlag>:
  *   - TXE flag is cleared only by a write to the USART_DR register 
  *     (USART_SendData()).
  * @retval None
  */
void USART_ClearFlag(USART_TypeDef* USARTx, uint16_t USART_FLAG)
{
 8004a58:	b480      	push	{r7}
 8004a5a:	b083      	sub	sp, #12
 8004a5c:	af00      	add	r7, sp, #0
 8004a5e:	6078      	str	r0, [r7, #4]
 8004a60:	460b      	mov	r3, r1
 8004a62:	807b      	strh	r3, [r7, #2]
  if ((USART_FLAG & USART_FLAG_CTS) == USART_FLAG_CTS)
  {
    assert_param(IS_USART_123_PERIPH(USARTx));
  } 
   
  USARTx->SR = (uint16_t)~USART_FLAG;
 8004a64:	887b      	ldrh	r3, [r7, #2]
 8004a66:	ea6f 0303 	mvn.w	r3, r3
 8004a6a:	b29a      	uxth	r2, r3
 8004a6c:	687b      	ldr	r3, [r7, #4]
 8004a6e:	801a      	strh	r2, [r3, #0]
}
 8004a70:	f107 070c 	add.w	r7, r7, #12
 8004a74:	46bd      	mov	sp, r7
 8004a76:	bc80      	pop	{r7}
 8004a78:	4770      	bx	lr
 8004a7a:	bf00      	nop

08004a7c <USART_GetITStatus>:
  *     @arg USART_IT_FE:   Framing Error interrupt
  *     @arg USART_IT_PE:   Parity Error interrupt
  * @retval The new state of USART_IT (SET or RESET).
  */
ITStatus USART_GetITStatus(USART_TypeDef* USARTx, uint16_t USART_IT)
{
 8004a7c:	b480      	push	{r7}
 8004a7e:	b087      	sub	sp, #28
 8004a80:	af00      	add	r7, sp, #0
 8004a82:	6078      	str	r0, [r7, #4]
 8004a84:	460b      	mov	r3, r1
 8004a86:	807b      	strh	r3, [r7, #2]
  uint32_t bitpos = 0x00, itmask = 0x00, usartreg = 0x00;
 8004a88:	f04f 0300 	mov.w	r3, #0
 8004a8c:	60fb      	str	r3, [r7, #12]
 8004a8e:	f04f 0300 	mov.w	r3, #0
 8004a92:	617b      	str	r3, [r7, #20]
 8004a94:	f04f 0300 	mov.w	r3, #0
 8004a98:	60bb      	str	r3, [r7, #8]
  ITStatus bitstatus = RESET;
 8004a9a:	f04f 0300 	mov.w	r3, #0
 8004a9e:	74fb      	strb	r3, [r7, #19]
  {
    assert_param(IS_USART_123_PERIPH(USARTx));
  }   
  
  /* Get the USART register index */
  usartreg = (((uint8_t)USART_IT) >> 0x05);
 8004aa0:	887b      	ldrh	r3, [r7, #2]
 8004aa2:	b2db      	uxtb	r3, r3
 8004aa4:	ea4f 1353 	mov.w	r3, r3, lsr #5
 8004aa8:	b2db      	uxtb	r3, r3
 8004aaa:	60bb      	str	r3, [r7, #8]
  /* Get the interrupt position */
  itmask = USART_IT & IT_Mask;
 8004aac:	887b      	ldrh	r3, [r7, #2]
 8004aae:	f003 031f 	and.w	r3, r3, #31
 8004ab2:	617b      	str	r3, [r7, #20]
  itmask = (uint32_t)0x01 << itmask;
 8004ab4:	697b      	ldr	r3, [r7, #20]
 8004ab6:	f04f 0201 	mov.w	r2, #1
 8004aba:	fa02 f303 	lsl.w	r3, r2, r3
 8004abe:	617b      	str	r3, [r7, #20]
  
  if (usartreg == 0x01) /* The IT  is in CR1 register */
 8004ac0:	68bb      	ldr	r3, [r7, #8]
 8004ac2:	2b01      	cmp	r3, #1
 8004ac4:	d106      	bne.n	8004ad4 <USART_GetITStatus+0x58>
  {
    itmask &= USARTx->CR1;
 8004ac6:	687b      	ldr	r3, [r7, #4]
 8004ac8:	899b      	ldrh	r3, [r3, #12]
 8004aca:	b29b      	uxth	r3, r3
 8004acc:	697a      	ldr	r2, [r7, #20]
 8004ace:	4013      	ands	r3, r2
 8004ad0:	617b      	str	r3, [r7, #20]
 8004ad2:	e00f      	b.n	8004af4 <USART_GetITStatus+0x78>
  }
  else if (usartreg == 0x02) /* The IT  is in CR2 register */
 8004ad4:	68bb      	ldr	r3, [r7, #8]
 8004ad6:	2b02      	cmp	r3, #2
 8004ad8:	d106      	bne.n	8004ae8 <USART_GetITStatus+0x6c>
  {
    itmask &= USARTx->CR2;
 8004ada:	687b      	ldr	r3, [r7, #4]
 8004adc:	8a1b      	ldrh	r3, [r3, #16]
 8004ade:	b29b      	uxth	r3, r3
 8004ae0:	697a      	ldr	r2, [r7, #20]
 8004ae2:	4013      	ands	r3, r2
 8004ae4:	617b      	str	r3, [r7, #20]
 8004ae6:	e005      	b.n	8004af4 <USART_GetITStatus+0x78>
  }
  else /* The IT  is in CR3 register */
  {
    itmask &= USARTx->CR3;
 8004ae8:	687b      	ldr	r3, [r7, #4]
 8004aea:	8a9b      	ldrh	r3, [r3, #20]
 8004aec:	b29b      	uxth	r3, r3
 8004aee:	697a      	ldr	r2, [r7, #20]
 8004af0:	4013      	ands	r3, r2
 8004af2:	617b      	str	r3, [r7, #20]
  }
  
  bitpos = USART_IT >> 0x08;
 8004af4:	887b      	ldrh	r3, [r7, #2]
 8004af6:	ea4f 2313 	mov.w	r3, r3, lsr #8
 8004afa:	b29b      	uxth	r3, r3
 8004afc:	60fb      	str	r3, [r7, #12]
  bitpos = (uint32_t)0x01 << bitpos;
 8004afe:	68fb      	ldr	r3, [r7, #12]
 8004b00:	f04f 0201 	mov.w	r2, #1
 8004b04:	fa02 f303 	lsl.w	r3, r2, r3
 8004b08:	60fb      	str	r3, [r7, #12]
  bitpos &= USARTx->SR;
 8004b0a:	687b      	ldr	r3, [r7, #4]
 8004b0c:	881b      	ldrh	r3, [r3, #0]
 8004b0e:	b29b      	uxth	r3, r3
 8004b10:	68fa      	ldr	r2, [r7, #12]
 8004b12:	4013      	ands	r3, r2
 8004b14:	60fb      	str	r3, [r7, #12]
  if ((itmask != (uint16_t)RESET)&&(bitpos != (uint16_t)RESET))
 8004b16:	697b      	ldr	r3, [r7, #20]
 8004b18:	2b00      	cmp	r3, #0
 8004b1a:	d006      	beq.n	8004b2a <USART_GetITStatus+0xae>
 8004b1c:	68fb      	ldr	r3, [r7, #12]
 8004b1e:	2b00      	cmp	r3, #0
 8004b20:	d003      	beq.n	8004b2a <USART_GetITStatus+0xae>
  {
    bitstatus = SET;
 8004b22:	f04f 0301 	mov.w	r3, #1
 8004b26:	74fb      	strb	r3, [r7, #19]
 8004b28:	e002      	b.n	8004b30 <USART_GetITStatus+0xb4>
  }
  else
  {
    bitstatus = RESET;
 8004b2a:	f04f 0300 	mov.w	r3, #0
 8004b2e:	74fb      	strb	r3, [r7, #19]
  }
  
  return bitstatus;  
 8004b30:	7cfb      	ldrb	r3, [r7, #19]
}
 8004b32:	4618      	mov	r0, r3
 8004b34:	f107 071c 	add.w	r7, r7, #28
 8004b38:	46bd      	mov	sp, r7
 8004b3a:	bc80      	pop	{r7}
 8004b3c:	4770      	bx	lr
 8004b3e:	bf00      	nop

08004b40 <USART_ClearITPendingBit>:
  *   - TXE pending bit is cleared only by a write to the USART_DR register 
  *     (USART_SendData()).
  * @retval None
  */
void USART_ClearITPendingBit(USART_TypeDef* USARTx, uint16_t USART_IT)
{
 8004b40:	b480      	push	{r7}
 8004b42:	b085      	sub	sp, #20
 8004b44:	af00      	add	r7, sp, #0
 8004b46:	6078      	str	r0, [r7, #4]
 8004b48:	460b      	mov	r3, r1
 8004b4a:	807b      	strh	r3, [r7, #2]
  uint16_t bitpos = 0x00, itmask = 0x00;
 8004b4c:	f04f 0300 	mov.w	r3, #0
 8004b50:	81fb      	strh	r3, [r7, #14]
 8004b52:	f04f 0300 	mov.w	r3, #0
 8004b56:	81bb      	strh	r3, [r7, #12]
  if (USART_IT == USART_IT_CTS)
  {
    assert_param(IS_USART_123_PERIPH(USARTx));
  }   
  
  bitpos = USART_IT >> 0x08;
 8004b58:	887b      	ldrh	r3, [r7, #2]
 8004b5a:	ea4f 2313 	mov.w	r3, r3, lsr #8
 8004b5e:	81fb      	strh	r3, [r7, #14]
  itmask = ((uint16_t)0x01 << (uint16_t)bitpos);
 8004b60:	89fb      	ldrh	r3, [r7, #14]
 8004b62:	f04f 0201 	mov.w	r2, #1
 8004b66:	fa02 f303 	lsl.w	r3, r2, r3
 8004b6a:	81bb      	strh	r3, [r7, #12]
  USARTx->SR = (uint16_t)~itmask;
 8004b6c:	89bb      	ldrh	r3, [r7, #12]
 8004b6e:	ea6f 0303 	mvn.w	r3, r3
 8004b72:	b29a      	uxth	r2, r3
 8004b74:	687b      	ldr	r3, [r7, #4]
 8004b76:	801a      	strh	r2, [r3, #0]
}
 8004b78:	f107 0714 	add.w	r7, r7, #20
 8004b7c:	46bd      	mov	sp, r7
 8004b7e:	bc80      	pop	{r7}
 8004b80:	4770      	bx	lr
 8004b82:	bf00      	nop

08004b84 <HardFault_Handler>:
 8004b84:	f3ef 8009 	mrs	r0, PSP
 8004b88:	4659      	mov	r1, fp
 8004b8a:	b500      	push	{lr}
 8004b8c:	f7fb fcdc 	bl	8000548 <dump_stack>
 8004b90:	f85d eb04 	ldr.w	lr, [sp], #4
 8004b94:	f04e 0e04 	orr.w	lr, lr, #4
 8004b98:	4770      	bx	lr

08004b9a <set_user_mode>:
 8004b9a:	4804      	ldr	r0, [pc, #16]	; (8004bac <set_user_mode+0x12>)
 8004b9c:	f380 8809 	msr	PSP, r0
 8004ba0:	f04f 0003 	mov.w	r0, #3
 8004ba4:	f380 8814 	msr	CONTROL, r0
 8004ba8:	4770      	bx	lr
 8004baa:	0000      	.short	0x0000
 8004bac:	20001030 	.word	0x20001030

08004bb0 <_core_start>:
 8004bb0:	08004bc8 	.word	0x08004bc8
 8004bb4:	0800039d 	.word	0x0800039d

08004bb8 <_core_end>:
 8004bb8:	08004bf0 	.word	0x08004bf0
 8004bbc:	080004b5 	.word	0x080004b5

08004bc0 <module_NULL>:
 8004bc0:	08004c08 00000000                       .L......
