#!/usr/bin/python

import os
from subprocess import call

root_dir = '.'

for file in os.listdir(root_dir):
	if file.endswith(".cl"):
		prefix = "clang -S -emit-llvm -o "
		output = os.path.splitext(file)[0] + ".ll"
		clpara = " -x cl "
		kernel = file
		arg = prefix + output + clpara + kernel
		print arg
		call(arg.split())

