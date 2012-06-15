STDFS
=====

about lake file system:
	just a study file system used to learn linux filesystem architecture.

*(V1)Disk struct:
[boot block 0 ][super block 1][inode table block 2 .. 33][data block 34 .. 1023]

*(V2)
[boot block0][super block1][blockbitmap n ][inodebitmap n/4] [inodetable bitmap] [data blocks...]

*For example:
blocksize =1024
disksize = 64MiB
block bitmap count = 64MiB/1024/8/1024= disksize/8M = 8(blocks)
inode bitmap count = disksize /32M =2(blocks)
inode table block count = 2 * 1024 *128 /1024 = 256(blocks)
