#!/usr/bin/python

import os
from subprocess import call

root_dir = '../'
kernel_dir = root_dir + "kernel-src/"
header_dir = root_dir + "include/"
prefix_ir = "clang -S -emit-llvm "
prefix_bc = "clang -c -emit-llvm "
#clpara = " -target amdgcn "
#clpara = " -triple=spir64-unknow-unknow "
#clpara = " -target amdgcn -mcpu=verde "
clpara = " -target r600-- -mcpu=verde "
header = " -I " + header_dir + " -include " + header_dir + "clc/clc.h " + " -D cl_clang_storage_class_specifiers " 
#header = ""

for file in os.listdir(kernel_dir):
	if file.endswith(".cl"):
		output = " -o " + os.path.splitext(file)[0] 
		kernel = kernel_dir + file
		gen_ir = prefix_ir + clpara + header + kernel + output + ".ll"
		gen_bc = prefix_bc + clpara + header + kernel + output + ".bc" 
		print gen_ir
		print gen_bc
		call(gen_ir.split())
		call(gen_bc.split())

