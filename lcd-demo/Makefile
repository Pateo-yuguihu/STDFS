include Makefile.common
LDFLAGS=$(COMMONFLAGS) -fno-exceptions -ffunction-sections -fdata-sections \
	-L$(LIBDIR) -L$(UCOSLIB) -L$(GUILIB) -nostartfiles -Wl,--gc-sections,-Tlinker.ld

LDLIBS += -lc
LDLIBS += -lstm32  -lgui -luCOS-II -lm

all: libs src ucos
	@echo "1. Make ELF without function map table"
	$(CC) -o $(PROGRAM)_tmp.elf $(LDFLAGS) \
		src/*.o \
		$(LDLIBS)
	arm-none-eabi-nm -n $(PROGRAM)_tmp.elf > $(PROGRAM).map
	rm -f map.c map.o
	python map.py > map.c
	$(CC) $(CFLAGS) -c map.c
	@echo "2. Make ELF again"
	$(CC) -o $(PROGRAM).elf $(LDFLAGS) \
		src/*.o map.o\
		$(LDLIBS)
	$(OBJCOPY) -O ihex $(PROGRAM).elf $(PROGRAM).hex
	$(OBJCOPY) -O binary $(PROGRAM).elf $(PROGRAM).bin
	arm-none-eabi-nm -n $(PROGRAM).elf > $(PROGRAM).map
	@arm-none-eabi-size   -d $(PROGRAM).elf
	cp main.bin /media/sf_ubuntu/

.PHONY:libs src ucos uCGUI clean

libs:
	$(MAKE) -C libs $@

src:
	$(MAKE) -C src $@

ucos:
	$(MAKE) -C ucos $@

uCGUI:
	$(MAKE) -C uCGUI $@
	
clean:
	$(MAKE) -C src $@
	$(MAKE) -C libs $@
	rm -f $(PROGRAM).elf $(PROGRAM).hex $(PROGRAM).bin $(PROGRAM).info_elf $(PROGRAM).info_size map.o map.c main_tmp.elf main.map
	$(MAKE) -C ucos $@
	$(MAKE) -C uCGUI $@
