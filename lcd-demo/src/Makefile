##############################
# Author: Hu Yugui <yugui.hu@hotmail.com>
# Project for Breshless DC motor
##############################
include ../Makefile.common

SRC_OBJ = startup.o main.o fsmc_sram.o ili9320_api.o ili9320.o \
	lcd_init.o xprintf.o console.o toolbox.o

src: $(SRC_OBJ)
$(SRC_OBJ): %.o: %.c
	$(CC) -c $(CFLAGS) $<

.PHONY: clean

clean:
	rm -f $(SRC_OBJ)
