include ../Makefile.common
CFLAGS+=-c

all: uCGUI

uCGUI: libgui.a

libgui.a:
	@echo  "+===========================================+"
	@echo  "            正在编译 $@                     "
	@echo  "+===========================================+"
	cd $(GUILIB)/AntiAlias && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/ConvertColor && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/ConvertMono && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/Font && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/Core && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/GUIDemo && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/MemDev && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/JPEG && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/MultiLayer && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/Widget && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/WM && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	cd $(GUILIB)/TFT && \
		$(CC) $(CFLAGS) \
		-I$(GUILIB)/Config \
		*.c
	$(AR) cr $@ \
		$(GUILIB)/AntiAlias/*.o \
		$(GUILIB)/ConvertColor/*.o \
		$(GUILIB)/ConvertMono/*.o \
		$(GUILIB)/Core/*.o \
		$(GUILIB)/Font/*.o \
		$(GUILIB)/GUIDemo/*.o \
		$(GUILIB)/MemDev/*.o \
		$(GUILIB)/JPEG/*.o \
		$(GUILIB)/Widget/*.o \
		$(GUILIB)/WM/*.o \
		$(GUILIB)/MultiLayer/*.o \
		$(GUILIB)/TFT/*.o
	@echo "============================================="
	@echo "               $@编译成功                    "
	@echo "============================================="

.PHONY:clean

clean:
	rm -f $(GUILIB)/libgui.a
	rm -f $(GUILIB)/AntiAlias/*.o 
	rm -f $(GUILIB)/ConvertColor/*.o 
	rm -f $(GUILIB)/ConvertMono/*.o 
	rm -f $(GUILIB)/Core/*.o 
	rm -f $(GUILIB)/Font/*.o 
	rm -f $(GUILIB)/GUIDemo/*.o 
	rm -f $(GUILIB)/MemDev/*.o 
	rm -f $(GUILIB)/JPEG/*.o 
	rm -f $(GUILIB)/Widget/*.o 
	rm -f $(GUILIB)/WM/*.o 
	rm -f $(GUILIB)/MultiLayer/*.o
	rm -f $(GUILIB)/TFT/*.o
