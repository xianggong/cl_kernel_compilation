#!/usr/bin/python

import os
import subprocess
from subprocess import call
import fileinput
import re

# Directories
root_dir = '../'
kernel_dir = root_dir + "kernel-src/"
header_dir = root_dir + "include/"

# Commands
gen_ir = "clang -S -emit-llvm "
gen_bc = "llvm-as "
opt_bc = "opt --mem2reg "
dis_bc = "llvm-dis "
m2c_as = "m2c --llvm2si "

# Compilation parameters
clpara = " -O0 -target r600-- -mcpu=verde "

# Headers
header = " -I " + header_dir
header += " -include " + header_dir + "m2c_buildin_fix.h " 
header += " -include " + header_dir + "clc/clc.h "
header += " -D cl_clang_storage_class_specifiers " 

def rename_variable_in_ir_file( file_name ):
        # Append all unnamed variable with prefix 'tmp_'
        ir_file_name = file_name + ".ll"
        if os.path.isfile(ir_file_name):
                fo = open(ir_file_name, "rw+")
                lines = fo.readlines()
                fo.seek(0)
                fo.truncate()
                for line in lines:
                        # Rename all unnamed variables
                        line = re.sub('\%([0-9]+)', r'%tmp_\1', line.rstrip())
                        # Also rename branch name
                        line = re.sub('(\;\ \<label\>\:)([0-9]+)', r'tmp_\2:', line.rstrip())
                        fo.write(line + '\n')
        
def runCommand(command):
        p = subprocess.Popen(command, 
                stdout=subprocess.PIPE, 
                stderr=subprocess.STDOUT)
        return iter(p.stdout.readline, b'')

for file in os.listdir(kernel_dir):
        if file.endswith(".cl"):
                file_name = os.path.splitext(file)[0]
                kernel_src = kernel_dir + file
                
                command_gen_ir = gen_ir + clpara + header + kernel_src + " -o " + file_name + ".ll"
                command_gen_bc = gen_bc + file_name + ".ll" 
                command_opt_bc = opt_bc + file_name + ".bc" + " -o " + file_name + ".opt.bc"
                command_dis_bc = dis_bc + file_name + ".opt.bc"
                command_m2s_as = m2c_as + file_name + ".opt.bc"

                # print command_gen_ir
                # print command_gen_bc
                # print command_opt_bc
                # print command_dis_bc
                 
                gen_ir_stdout = open(file_name + ".ll.stdout", "w+")
                for line in runCommand(command_gen_ir.split()):
                        gen_ir_stdout.write(line)

                rename_variable_in_ir_file(file_name)
                call(command_gen_bc.split())
                call(command_opt_bc.split())
                call(command_dis_bc.split())
                
		if os.path.isfile(file_name + ".opt.bc"):
	                m2c_as_debug = open(file_name + ".opt.m2cDump", "w+")
        	        for line in runCommand(command_m2s_as.split()):
                	        m2c_as_debug.write(line)

