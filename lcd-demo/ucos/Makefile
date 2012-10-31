include ../Makefile.common
CFLAGS+=-c

all: ucos

ucos: libuCOS-II.a

libuCOS-II.a:
	@echo  "+===========================================+"
	@echo  "            正在编译 $@                     "
	@echo  "+===========================================+"
	cd $(UCOSLIB)/uCOS-II/Source && \
		$(CC) $(CFLAGS) \
		-I$(UCOSLIB)/uCOS-II/Source \
		-I$(UCOSLIB)/uCOS-II/Ports/ARM-Cortex-M3/Generic/GCC \
		*c
	cd $(UCOSLIB)/uCOS-II/Ports/ARM-Cortex-M3/Generic/GCC && \
		$(CC) $(CFLAGS) \
		-I$(UCOSLIB)/uCOS-II/Source \
		-I$(UCOSLIB)/uCOS-II/Ports/ARM-Cortex-M3/Generic/GCC \
		*c
	cd $(UCOSLIB)/uCOS-II/Ports/ARM-Cortex-M3/Generic/GCC && \
		$(CC) -mcpu=cortex-m3 -mthumb -x assembler-with-cpp -c \
		*.s
	$(AR) cr $@ \
		$(UCOSLIB)/uCOS-II/Ports/ARM-Cortex-M3/Generic/GCC/*.o \
		$(UCOSLIB)/uCOS-II/Source/*.o
	@echo "============================================="
	@echo "               $@编译成功                    "
	@echo "============================================="

.PHONY:clean

clean:
	rm -f $(UCOSLIB)/libuCOS-II.a
	rm -f $(UCOSLIB)/uCOS-II/Ports/ARM-Cortex-M3/Generic/GCC/*.o
	rm -f $(UCOSLIB)/uCOS-II/Source/*.o
