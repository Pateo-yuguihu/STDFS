include ../Makefile.common
LIBS+=libstm32.a
CFLAGS+=-c

all: libs

libs: $(LIBS)

libstm32.a:
	@echo -n "Building $@..."
	cd $(STMLIB)/SRC && \
		$(CC) $(CFLAGS) \
		-D"assert_param(expr)=((void)0)"\
		-I./inc \
		*.c
	cd $(STMLIB)/../ && \
		$(CC) -mcpu=cortex-m3 -mthumb -x assembler-with-cpp -c \
		context_gcc.S
	cd $(STMLIB)/../ && \
		$(CC) $(CFLAGS) \
		syscalls.c

	$(AR) cr $(LIBDIR)/$@ \
		$(STMLIB)/SRC/*.o \
		$(STMLIB)/../*.o
	@echo "done."

PHONY:libs clean

clean:
	rm -f $(STMLIB)/SRC/*.o
	rm -f $(LIBS)
	rm -f $(STMLIB)/../*.o


