#!/usr/bin/python

import os
from subprocess import call

root_dir = '..'
kernel_dir = root_dir + "/kernel-src/"
header_dir = root_dir + "/include/"
prefix = "clang -S -emit-llvm "
clpara = " -target amdgcn-- -mcpu=verde "
header = " -I" + header_dir + " -include " + header_dir + "clc/clc.h " + " -D cl_clang_storage_class_specifiers " 

for file in os.listdir(kernel_dir):
	if file.endswith(".cl"):
		output = " -o " + os.path.splitext(file)[0] + ".ll"
		kernel = kernel_dir + file
		arg = prefix + clpara + header + kernel + output
		print arg
		call(arg.split())

