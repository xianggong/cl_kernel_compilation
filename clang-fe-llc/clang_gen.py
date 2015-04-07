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
llc_as = "llc -march=r600 -mcpu=verde "

# Compilation parameters
clpara = " -O0 -target r600-- -mcpu=verde "

# Headers
header = " -I " + header_dir
header += " -include " + header_dir + "clc/clc.h "
header += " -D cl_clang_storage_class_specifiers " 

def rename_buildin_in_ir_file( file_name ):
        # Change default build-in functions to corresponding build-in functions used in llc
        ir_file_name = file_name + ".ll"
        if os.path.isfile(ir_file_name):
                fo = open(ir_file_name, "rw+")
                lines = fo.readlines()
                fo.seek(0)
                fo.truncate()
                for line in lines:
                        # Rename build in functions if any
                        line = re.sub('get_global_id\(i32 0\)', r'llvm.r600.read.tgid.x()', line.rstrip())
                        line = re.sub('get_global_id\(i32 1\)', r'llvm.r600.read.tgid.y()', line.rstrip())
                        line = re.sub('get_global_id\(i32 2\)', r'llvm.r600.read.tgid.z()', line.rstrip())
                        line = re.sub('get_global_size\(i32 0\)', r'llvm.r600.read.global.size.x()', line.rstrip())
                        line = re.sub('get_global_size\(i32 1\)', r'llvm.r600.read.global.size.y()', line.rstrip())
                        line = re.sub('get_global_size\(i32 2\)', r'llvm.r600.read.global.size.z()', line.rstrip())
                        line = re.sub('get_local_id\(i32 0\)', r'llvm.r600.read.tidig.x()', line.rstrip())
                        line = re.sub('get_local_id\(i32 1\)', r'llvm.r600.read.tidig.y()', line.rstrip())
                        line = re.sub('get_local_id\(i32 2\)', r'llvm.r600.read.tidig.z()', line.rstrip())
                        line = re.sub('get_local_size\(i32 0\)', r'llvm.r600.read.local.size.x()', line.rstrip())
                        line = re.sub('get_local_size\(i32 1\)', r'llvm.r600.read.local.size.y()', line.rstrip())
                        line = re.sub('get_local_size\(i32 2\)', r'llvm.r600.read.local.size.z()', line.rstrip())
                        line = re.sub('get_num_groups\(i32 0\)', r'llvm.r600.read.ngroups.x()', line.rstrip())
                        line = re.sub('get_num_groups\(i32 1\)', r'llvm.r600.read.ngroups.y()', line.rstrip())
                        line = re.sub('get_num_groups\(i32 2\)', r'llvm.r600.read.ngroups.z()', line.rstrip())

                        line = re.sub('declare i32 @get_global_id\(i32\) #1', r'expand declare get_global_id', line.rstrip())
                        if line == 'expand declare get_global_id':
                                line  = 'declare i32 @llvm.r600.read.tgid.x() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.tgid.y() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.tgid.z() #1' + '\n'

                        line = re.sub('declare i32 @get_global_size\(i32\) #1', r'expand declare get_global_size', line.rstrip())
                        if line == 'expand declare get_global_size':
                                line  = 'declare i32 @llvm.r600.read.global.size.x() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.global.size.y() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.global.size.z() #1' + '\n'

                        line = re.sub('declare i32 @get_local_id\(i32\) #1', r'expand declare get_local_id', line.rstrip())
                        if line == 'expand declare get_local_id':
                                line  = 'declare i32 @llvm.r600.read.tidig.x() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.tidig.y() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.tidig.z() #1' + '\n'

                        line = re.sub('declare i32 @get_local_size\(i32\) #1', r'expand declare get_local_size', line.rstrip())
                        if line == 'expand declare get_local_size':
                                line  = 'declare i32 @llvm.r600.read.local.size.x() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.local.size.y() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.local.size.z() #1' + '\n'

                        line = re.sub('declare i32 @get_num_groups\(i32\) #1', r'expand declare get_num_groups', line.rstrip())
                        if line == 'expand declare get_num_groups':
                                line  = 'declare i32 @llvm.r600.read.ngroups.x() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.ngroups.y() #1' + '\n'
                                line += 'declare i32 @llvm.r600.read.ngroups.z() #1' + '\n'

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
                command_llc_as = llc_as + file_name + ".bc"
                command_llc_as_opt = llc_as + file_name + ".opt.bc"

                # print command_gen_ir
                # print command_gen_bc
                # print command_opt_bc
                # print command_dis_bc

                gen_ir_stdout = open(file_name + ".ll.stdout", "w+")
                for line in runCommand(command_gen_ir.split()):
                        gen_ir_stdout.write(line)

                rename_buildin_in_ir_file(file_name)
                call(command_gen_bc.split())
                call(command_opt_bc.split())
                call(command_dis_bc.split())

                if os.path.isfile(file_name + ".opt.bc"):
                        llc_as_debug = open(file_name + ".opt.llcDump", "w+")
                        for line in runCommand(command_llc_as_opt.split()):
                                llc_as_debug.write(line)