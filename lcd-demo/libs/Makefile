include ../Makefile.common
LIBS+=libstm32.a
CFLAGS+=-c

all: libs

libs: $(LIBS)

libstm32.a:
	@echo -n "Building $@..."
	cd $(STMLIB)/CMSIS/CM3/CoreSupport && \
		$(CC) $(CFLAGS) \
		core_cm3.c
	cd $(STMLIB)/CMSIS/CM3/DeviceSupport/ST/STM32F10x && \
		$(CC) $(CFLAGS) \
		system_stm32f10x.c
	cd $(STMLIB)/STM32F10x_StdPeriph_Driver/src && \
		$(CC) $(CFLAGS) \
		-D"assert_param(expr)=((void)0)"\
		-I../../CMSIS/CM3/CoreSupport \
		-I../../CMSIS/CM3/DeviceSupport/ST/STM32F10x \
		-I../inc \
		*.c
	cd $(STMLIB)/../../ && \
		$(CC) -mcpu=cortex-m3 -mthumb -x assembler-with-cpp -c \
		context_gcc.S
	$(AR) cr $(LIBDIR)/$@ \
		$(STMLIB)/CMSIS/CM3/CoreSupport/core_cm3.o \
		$(STMLIB)/CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.o \
		$(STMLIB)/STM32F10x_StdPeriph_Driver/src/*.o \
		$(STMLIB)/../../context_gcc.o
	@echo "done."

PHONY:libs clean

clean:
	rm -f $(STMLIB)/STM32F10x_StdPeriph_Driver/src/*.o
	rm -f $(STMLIB)/CMSIS/CM3/CoreSupport/core_cm3.o
	rm -f $(STMLIB)/CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.o
	rm -f $(LIBS)
	rm -f $(STMLIB)/../../context_gcc.o


