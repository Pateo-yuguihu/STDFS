#!/usr/bin/env python
# coding=utf-8

import string
import os

output=[]
fd=open("main.map")
sum = 0

print "#include \"src/init.h\""
print "const struct sys_func_map func_map[] = {"
for line in fd:
	if sum >0:
		if line.strip():
			line=line.rstrip()
			p=line.split()
			print "{0x%s,\"%s\"}," %(p[0], p[2])
	sum = sum + 1
print "};"
