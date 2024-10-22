#include <stdarg.h>
#include "stm32f10x_usart.h"
#include <init.h>

/* These types must be 16-bit, 32-bit or larger integer */
typedef int             INT;
typedef unsigned int    UINT;

/* These types must be 8-bit integer */
typedef signed char     CHAR;
typedef unsigned char   UCHAR;
typedef unsigned char   BYTE;

/* These types must be 16-bit integer */
typedef short           SHORT;
typedef unsigned short  USHORT;
typedef unsigned short  WORD;
typedef unsigned short  WCHAR;

/* These types must be 32-bit integer */
typedef long            LONG;
typedef unsigned long   ULONG;
typedef unsigned long   DWORD;

extern void put_char(char ch);
int xatoi (char **str, long *res)
{
	DWORD val;
	BYTE c, radix, s = 0;


	while ((c = **str) == ' ') (*str)++;
	if (c == '-') {
		s = 1;
		c = *(++(*str));
	}
	if (c == '0') {
		c = *(++(*str));
		if (c <= ' ') {
			*res = 0; return 1;
		}
		if (c == 'x') {
			radix = 16;
			c = *(++(*str));
		} else {
			if (c == 'b') {
				radix = 2;
				c = *(++(*str));
			} else {
				if ((c >= '0')&&(c <= '9'))
					radix = 8;
				else
					return 0;
			}
		}
	} else {
		if ((c < '1')||(c > '9'))
			return 0;
		radix = 10;
	}
	val = 0;
	while (c > ' ') {
		if (c >= 'a') c -= 0x20;
		c -= '0';
		if (c >= 17) {
			c -= 7;
			if (c <= 9) return 0;
		}
		if (c >= radix) return 0;
		val = val * radix + c;
		c = *(++(*str));
	}
	if (s) val = -val;
	*res = val;
	return 1;
}

void put_char(char ch)
{
  	USART_SendData(USART1, (unsigned char) ch);
  	while (!(USART1->SR & USART_FLAG_TXE));
}

extern OS_EVENT *uart_receive_sem;
extern char uart_chr;
char comm_get(void)
{
	INT8U err;
	OSSemPend(uart_receive_sem, 0, &err);
	if (err == OS_ERR_NONE)
		return uart_chr;//(char)USART_ReceiveData(USART1);
	else
		xprintf("uart_sem error:%d\n", err);
}

void xputc (char c)
{
	if (c == '\n') put_char('\r');
	put_char(c);
}

void xputs (const char* str)
{
	while (*str)
		xputc(*str++);
}

void xitoa (long val, int radix, int len)
{
	BYTE c, r, sgn = 0, pad = ' ';
	BYTE s[20], i = 0;
	DWORD v;


	if (radix < 0) {
		radix = -radix;
		if (val < 0) {
			val = -val;
			sgn = '-';
		}
	}
	v = val;
	r = radix;
	if (len < 0) {
		len = -len;
		pad = '0';
	}
	if (len > 20) return;
	do {
		c = (BYTE)(v % r);
		if (c >= 10) c += 7;
		c += '0';
		s[i++] = c;
		v /= r;
	} while (v);
	if (sgn) s[i++] = sgn;
	while (i < len)
		s[i++] = pad;
	do
		xputc(s[--i]);
	while (i);
}

void xprintf (const char* str, ...)
{
	va_list arp;
	int d, r, w, s, l;


	va_start(arp, str);

	while ((d = *str++) != 0) {
		if (d != '%') {
			xputc(d); continue;
		}
		d = *str++; w = r = s = l = 0;
		if (d == '0') {
			d = *str++; s = 1;
		}
		while ((d >= '0')&&(d <= '9')) {
			w += w * 10 + (d - '0');
			d = *str++;
		}
		if (s) w = -w;
		if (d == 'l') {
			l = 1;
			d = *str++;
		}
		if (!d) break;
		if (d == 's') {
			xputs(va_arg(arp, char*));
			continue;
		}
		if (d == 'c') {
			xputc((char)va_arg(arp, int));
			continue;
		}
		if (d == 'u') r = 10;
		if (d == 'd') r = -10;
		if (d == 'X' || d == 'x') r = 16; // 'x' added by mthomas in increase compatibility
		if (d == 'b') r = 2;
		if (!r) break;
		if (l) {
			xitoa((long)va_arg(arp, long), r, w);
		} else {
			if (r > 0)
				xitoa((unsigned long)va_arg(arp, int), r, w);
			else
				xitoa((long)va_arg(arp, int), r, w);
		}
	}

	va_end(arp);
}

void put_dump (const BYTE *buff, DWORD ofs, int cnt)
{
	BYTE n;


	xprintf("%08lX ", ofs);
	for(n = 0; n < cnt; n++)
		xprintf(" %02X", buff[n]);
	xputc(' ');
	for(n = 0; n < cnt; n++) {
		if ((buff[n] < 0x20)||(buff[n] >= 0x7F))
			xputc('.');
		else
			xputc(buff[n]);
	}
	xputc('\n');
}

void get_line (char *buff, int len)
{
	char c;
	int idx = 0;

	for (;;) {
		c = comm_get();
		if ((c == '\r') || (c== '\n')) 
			break;
		if ((c == '\b') && idx) {
			idx--; xputc(c);
			xputc(' '); xputc(c); // added by mthomas for Eclipse Terminal plug-in
		}
		if (((BYTE)c >= ' ') && (idx < len - 1)) {
			buff[idx++] = c; xputc(c);
			if (idx == (len - 1))
				break;
		}
	}
	buff[idx] = 0;
	xputc('\n');
}

#if 0
// function added by mthomas:
int get_line_r (char *buff, int len, int* idx)
{
	char c;
	int retval = 0;
	int myidx;

	if (xavail() ) {
		myidx = *idx;
		c = comm_get();
		if (c == '\r') {
			buff[myidx] = 0;
			xputc('\n');
			retval = 1;
		} else {
			if ((c == '\b') && myidx) {
				myidx--; xputc(c);
				xputc(' '); xputc(c); // added by mthomas for Eclipse Terminal plug-in
			}
			if (((BYTE)c >= ' ') && (myidx < len - 1)) {
					buff[myidx++] = c; xputc(c);
			}
		}
		*idx = myidx;
	}

	return retval;
}
#endif
