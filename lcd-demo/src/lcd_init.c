#include "fsmc_sram.h"

#define Bank1_LCD_D    ((uint32_t)0x60020000)    //disp Data ADDR
#define Bank1_LCD_C    ((uint32_t)0x60000000)	 //disp Reg ADDR

unsigned long color1=0;
void LCD_Init(void);
void LCD_WR_REG(unsigned int index);
void LCD_WR_CMD(unsigned int index,unsigned int val);
void LCD_WR_Data(unsigned int val);
unsigned int color[]={0xf800,0x07e0,0x001f,0xffe0,0x0000,0xffff,0x07ff,0xf81f};	
unsigned int LCD_RD_data(void);

extern void lcd_rst(void);
extern void Delay(__IO uint32_t nCount);

void LCD_WR_REG(unsigned int index)
{
	*(__IO uint16_t *)(Bank1_LCD_C)= index;

}

void LCD_WR_CMD(unsigned int index,unsigned int val)
{	
	*(__IO uint16_t *)(Bank1_LCD_C)= index;	
	*(__IO uint16_t *)(Bank1_LCD_D)= val;
}

unsigned int LCD_RD_data(void){
	unsigned int a=0;
	a=*(__IO uint16_t *) (Bank1_LCD_D); //L

	return(a);	
}

void LCD_WR_Data(unsigned int val)
{   
	*(__IO uint16_t *) (Bank1_LCD_D)= val; 	
}

void LCD_WR_Data_8(unsigned int val)
{
	*(__IO uint16_t *) (Bank1_LCD_D)= val;
}

void LCD_Init(void)
{
	lcd_rst();	 

	LCD_WR_CMD(0x00E3, 0x3008); // Set internal timing
	LCD_WR_CMD(0x00E7, 0x0012); // Set internal timing
	LCD_WR_CMD(0x00EF, 0x1231); // Set internal timing
	LCD_WR_CMD(0x0000, 0x0001); // Start Oscillation
	LCD_WR_CMD(0x0001, 0x0100); // set SS and SM bit
	LCD_WR_CMD(0x0002, 0x0700); // set 1 line inversion

	LCD_WR_CMD(0x0003, 0x1018); // set GRAM write direction and BGR=0,262K colors,1 transfers/pixel.
	LCD_WR_CMD(0x0004, 0x0000); // Resize register
	LCD_WR_CMD(0x0008, 0x0202); // set the back porch and front porch
	LCD_WR_CMD(0x0009, 0x0000); // set non-display area refresh cycle ISC[3:0]
	LCD_WR_CMD(0x000A, 0x0000); // FMARK function
	LCD_WR_CMD(0x000C, 0x0000); // RGB interface setting
	LCD_WR_CMD(0x000D, 0x0000); // Frame marker Position
	LCD_WR_CMD(0x000F, 0x0000); // RGB interface polarity
	//Power On sequence 
	LCD_WR_CMD(0x0010, 0x0000); // SAP, BT[3:0], AP, DSTB, SLP, STB
	LCD_WR_CMD(0x0011, 0x0007); // DC1[2:0], DC0[2:0], VC[2:0]
	LCD_WR_CMD(0x0012, 0x0000); // VREG1OUT voltage
	LCD_WR_CMD(0x0013, 0x0000); // VDV[4:0] for VCOM amplitude
	Delay(200); // Dis-charge capacitor power voltage
	LCD_WR_CMD(0x0010, 0x1690); // SAP, BT[3:0], AP, DSTB, SLP, STB
	LCD_WR_CMD(0x0011, 0x0227); // R11h=0x0221 at VCI=3.3V, DC1[2:0], DC0[2:0], VC[2:0]
	Delay(50); // Delay 50ms
	LCD_WR_CMD(0x0012, 0x001C); // External reference voltage= Vci;
	Delay(50); // Delay 50ms
	LCD_WR_CMD(0x0013, 0x1800); // R13=1200 when R12=009D;VDV[4:0] for VCOM amplitude
	LCD_WR_CMD(0x0029, 0x001C); // R29=000C when R12=009D;VCM[5:0] for VCOMH
	LCD_WR_CMD(0x002B, 0x000D); // Frame Rate = 91Hz
	Delay(50); // Delay 50ms
	LCD_WR_CMD(0x0020, 0x0000); // GRAM horizontal Address
	LCD_WR_CMD(0x0021, 0x0000); // GRAM Vertical Address
	// ----------- Adjust the Gamma Curve ----------//
	LCD_WR_CMD(0x0030, 0x0007);
	LCD_WR_CMD(0x0031, 0x0302);
	LCD_WR_CMD(0x0032, 0x0105);
	LCD_WR_CMD(0x0035, 0x0206);
	LCD_WR_CMD(0x0036, 0x0808);
	LCD_WR_CMD(0x0037, 0x0206);
	LCD_WR_CMD(0x0038, 0x0504);
	LCD_WR_CMD(0x0039, 0x0007);
	LCD_WR_CMD(0x003C, 0x0105);
	LCD_WR_CMD(0x003D, 0x0808);
	//------------------ Set GRAM area ---------------//
	LCD_WR_CMD(0x0050, 0x0000); // Horizontal GRAM Start Address
	LCD_WR_CMD(0x0051, 0x00EF); // Horizontal GRAM End Address
	LCD_WR_CMD(0x0052, 0x0000); // Vertical GRAM Start Address
	LCD_WR_CMD(0x0053, 0x013F); // Vertical GRAM Start Address
	LCD_WR_CMD(0x0060, 0xA700); // Gate Scan Line
	LCD_WR_CMD(0x0061, 0x0001); // NDL,VLE, REV
	LCD_WR_CMD(0x006A, 0x0000); // set scrolling line
	//-------------- Partial Display Control ---------//
	LCD_WR_CMD(0x0080, 0x0000);
	LCD_WR_CMD(0x0081, 0x0000);
	LCD_WR_CMD(0x0082, 0x0000);
	LCD_WR_CMD(0x0083, 0x0000);
	LCD_WR_CMD(0x0084, 0x0000);
	LCD_WR_CMD(0x0085, 0x0000);
	//-------------- Panel Control -------------------//
	LCD_WR_CMD(0x0090, 0x0010);
	LCD_WR_CMD(0x0092, 0x0000);
	LCD_WR_CMD(0x0093, 0x0003);
	LCD_WR_CMD(0x0095, 0x0110);
	LCD_WR_CMD(0x0097, 0x0000);
	LCD_WR_CMD(0x0098, 0x0000);
	LCD_WR_CMD(0x0007, 0x0133); // 262K color and display ON

	LCD_WR_CMD(32, 0);
	LCD_WR_CMD(33, 0x013F);
	*(__IO uint16_t *) (Bank1_LCD_C)= 34;

	for(color1=0;color1<76800;color1++)
	{
		LCD_WR_Data(0xffff);
	}
	color1=0;				

}
