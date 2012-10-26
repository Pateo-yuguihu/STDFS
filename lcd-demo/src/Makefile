include ../Makefile.common

OBJS+=startup.o
OBJS+=main.o
OBJS+=fsmc_sram.o ili9320_api.o ili9320.o lcd_init.o xprintf.o

all: src

src: app.a

app.a: $(OBJS)
	$(AR) cr app.a $(OBJS)

.PHONY:src clean

clean:
	rm -f app.a $(OBJS)
