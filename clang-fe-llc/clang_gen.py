#!/usr/bin/python

import os
from subprocess import call

# Directories
root_dir = '../'
kernel_dir = root_dir + "kernel-src/"
header_dir = root_dir + "include/"

# Commands
gen_ir = "clang -S -emit-llvm "
gen_bc = "llvm-as "
opt_bc = "opt --mem2reg "
dis_bc = "llvm-dis "

# Compilation parameters
clpara = " -O0 -target r600-- -mcpu=verde "

# Headers
header = " -I " + header_dir
header += " -include " + header_dir + "clc/clc.h "
header += " -include " + header_dir + "llc_buildin_fix.h " 
header += " -D cl_clang_storage_class_specifiers " 

for file in os.listdir(kernel_dir):
        if file.endswith(".cl"):
                file_name = os.path.splitext(file)[0]
                kernel_src = kernel_dir + file
                command_gen_ir = gen_ir + clpara + header + kernel_src + " -o " + file_name + ".ll"
                command_gen_bc = gen_bc + file_name + ".ll" 
                command_opt_bc = opt_bc + file_name + ".bc" + " -o " + file_name + ".opt.bc"
                command_dis_bc = dis_bc + file_name + ".opt.bc"
                # print command_gen_ir
                # print command_gen_bc
                # print command_opt_bc
                # print command_dis_bc
                call(command_gen_ir.split())
                call(command_gen_bc.split())
                call(command_opt_bc.split())
                call(command_dis_bc.split())

