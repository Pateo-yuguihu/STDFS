include ../Makefile.common
CFLAGS+=-c

GUI_SRC +=  $(wildcard $(GUILIB)/AntiAlias/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/ConvertColor/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/ConvertMono/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/Font/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/Core/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/TFT/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/WM/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/Widget/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/GUIDemo/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/JPEG/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/MultiLayer/*.c)
GUI_SRC +=  $(wildcard $(GUILIB)/MemDev/*.c)

GUI_OBJS = $(patsubst %.c, %.o, $(GUI_SRC))

all: uCGUI

uCGUI: libgui.a

libgui.a:$(GUI_OBJS)
	@echo "============================================="
	@echo "               $@开始编译                    "
	@echo "============================================="
	$(AR) -cr $@ $(GUI_OBJS)
	@echo "============================================="
	@echo "               $@开始编译                    "
	@echo "============================================="

#$(GUI_OBJS): %.o: %.c
#	$(CC) $(CFLAGS) $<

.PHONY:clean
clean:
	rm -f $(GUILIB)/libgui.a
	find -type f -name '*.o' -print0 |xargs -0 rm -f
