#
# Makefile for the linux lkfs-filesystem routines.
#
obj-m = lkfs.o
lkfs-y := super.o inode.o dir.o file.o namei.o ialloc.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) modules
clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(shell pwd) clean
#obj-$(CONFIG_LKFS_FS) += lkfs.o
#lkfs-y := super.o inode.o dir.o file.o namei.o ialloc.o
