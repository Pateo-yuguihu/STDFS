#include "stm32f10x.h"
#include "ili9320.h"
#include <string.h>

#define HZK_FLASH_BASE 0x08030000  
#define  GUI_CmpColor(color1, color2)	( (color1&0x01) == (color2&0x01) )
u16 GUI_Color565(u32 RGB)
{
	u8  r, g, b;

	b = ( RGB >> (0+3) ) & 0x1f;
	g = ( RGB >> (8+2) ) & 0x3f;
	r = ( RGB >> (16+3)) & 0x1f;

	return( (r<<11) + (g<<5) + (b<<0) );		
}

void GUI_Text(u16 x, u16 y, u8 *str, u16 Color, u16 bkColor)
{
	u8 i;

	int length = strlen(str);
	for (i=0; i < length; i++)
	{
		ili9320_PutChar((x+8*i),y,*str++,Color,bkColor);
	}
}

void GUI_Chn(u16 x, u16 y, u8 *str, u16 len, u16 Color, u16 bkColor)
{
	int i = 0;
	u32 offset;
	unsigned char buf[32];
	unsigned char qh, wh, m, n, j;

	for(i = 0; i < len / 2; i++)
	{
		qh = *(str + 2 * i) - 0xa0;
		wh = *(str + 2 * i + 1) - 0xa0;	
		offset = (94 * (qh - 1) + (wh - 1)) * 32;
		memcpy(buf, (unsigned char const*)(HZK_FLASH_BASE + offset), 32);

		for (m = 0; m < 16; m++)
			for(n = 0; n < 2; n++)
			{
				for(j = 0; j < 8; j++)
				{
					if (buf[m * 2 + n] & (0x80 >> j))
						ili9320_SetPoint(i * 16 + x + j + n * 8, y + m, Color);
					else
						ili9320_SetPoint(i * 16 + x + j + n * 8, y + m, bkColor);
				}
			}

	}
}

void GUI_Line(u16 x0, u16 y0, u16 x1, u16 y1,u16 color)
{
	u16 x,y;
	u16 dx;// = abs(x1 - x0);
	u16 dy;// = abs(y1 - y0);

	if(y0==y1)
	{
		if(x0<=x1)
		{
			x=x0;
		}
		else
		{
			x=x1;
			x1=x0;
		}
		while(x <= x1)
		{
			ili9320_SetPoint(x,y0,color);
			x++;
		}
		return;
	}
	else if(y0>y1)
	{
		dy=y0-y1;
	}
	else
	{
		dy=y1-y0;
	}

	if(x0==x1)
	{
		if(y0<=y1)
		{
			y=y0;
		}
		else
		{
			y=y1;
			y1=y0;
		}
		while(y <= y1)
		{
			ili9320_SetPoint(x0,y,color);
			y++;
		}
		return;
	}
	else if(x0 > x1)
	{
		dx=x0-x1;
		x = x1;
		x1 = x0;
		y = y1;
		y1 = y0;
	}
	else
	{
		dx=x1-x0;
		x = x0;
		y = y0;
	}

	if(dx == dy)
	{
		while(x <= x1)
		{

			x++;
			if(y>y1)
			{
				y--;
			}
			else
			{
				y++;
			}
			ili9320_SetPoint(x,y,color);
		}
	}
	else
	{
		ili9320_SetPoint(x, y, color);
		if(y < y1)
		{
			if(dx > dy)
			{
				s16 p = dy * 2 - dx;
				s16 twoDy = 2 * dy;
				s16 twoDyMinusDx = 2 * (dy - dx);
				while(x < x1)
				{
					x++;
					if(p < 0)
					{
						p += twoDy;
					}
					else
					{
						y++;
						p += twoDyMinusDx;
					}
					ili9320_SetPoint(x, y,color);
				}
			}
			else
			{
				s16 p = dx * 2 - dy;
				s16 twoDx = 2 * dx;
				s16 twoDxMinusDy = 2 * (dx - dy);
				while(y < y1)
				{
					y++;
					if(p < 0)
					{
						p += twoDx;
					}
					else
					{
						x++;
						p+= twoDxMinusDy;
					}
					ili9320_SetPoint(x, y, color);
				}
			}
		}
		else
		{
			if(dx > dy)
			{
				s16 p = dy * 2 - dx;
				s16 twoDy = 2 * dy;
				s16 twoDyMinusDx = 2 * (dy - dx);
				while(x < x1)
				{
					x++;
					if(p < 0)
					{
						p += twoDy;
					}
					else
					{
						y--;
						p += twoDyMinusDx;
					}
					ili9320_SetPoint(x, y,color);
				}
			}
			else
			{
				s16 p = dx * 2 - dy;
				s16 twoDx = 2 * dx;
				s16 twoDxMinusDy = 2 * (dx - dy);
				while(y1 < y)
				{
					y--;
					if(p < 0)
					{
						p += twoDx;
					}
					else
					{
						x++;
						p+= twoDxMinusDy;
					}
					ili9320_SetPoint(x, y,color);
				}
			}
		}
	}
}

void GUI_Circle(u16 cx,u16 cy,u16 r,u16 color,u8 fill)
{
	u16 x,y;
	s16 delta,tmp;
	x=0;
	y=r;
	delta=3-(r<<1);

	while(y>x)
	{
		if(fill)
		{
			GUI_Line(cx+x,cy+y,cx-x,cy+y,color);
			GUI_Line(cx+x,cy-y,cx-x,cy-y,color);
			GUI_Line(cx+y,cy+x,cx-y,cy+x,color);
			GUI_Line(cx+y,cy-x,cx-y,cy-x,color);
		}
		else
		{
			ili9320_SetPoint(cx+x,cy+y,color);
			ili9320_SetPoint(cx-x,cy+y,color);
			ili9320_SetPoint(cx+x,cy-y,color);
			ili9320_SetPoint(cx-x,cy-y,color);
			ili9320_SetPoint(cx+y,cy+x,color);
			ili9320_SetPoint(cx-y,cy+x,color);
			ili9320_SetPoint(cx+y,cy-x,color);
			ili9320_SetPoint(cx-y,cy-x,color);
		}
		x++;
		if(delta>=0)
		{
			y--;
			tmp=(x<<2);
			tmp-=(y<<2);
			delta+=(tmp+10);
		}
		else
		{
			delta+=((x<<2)+6);
		}
	}
}

void GUI_Rectangle(u16 x0, u16 y0, u16 x1, u16 y1,u16 color,u8 fill)
{
	if(fill)
	{
		u16 i;
		if(x0>x1)
		{
			i=x1;
			x1=x0;
		}
		else
		{
			i=x0;
		}
		for(;i<=x1;i++)
		{
			GUI_Line(i,y0,i,y1,color);
		}
		return;
	}
	GUI_Line(x0,y0,x0,y1,color);
	GUI_Line(x0,y1,x1,y1,color);
	GUI_Line(x1,y1,x1,y0,color);
	GUI_Line(x1,y0,x0,y0,color);
}

void  GUI_Square(u16 x0, u16 y0, u16 with, u16 color,u8 fill)
{
	GUI_Rectangle(x0, y0, x0+with, y0+with, color,fill);
}
