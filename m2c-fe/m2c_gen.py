#!/usr/bin/python

import os
from subprocess import call

# Directories
root_dir = '../kernel-src/'

# Commands
gen_ir = "m2c --cl2llvm "
dis_bc = "llvm-dis "
opt_bc = "opt --mem2reg "

for file in os.listdir(root_dir):
	if file.endswith(".cl"):

                file_name = file.split(".")[0]

                # Copy kernel sources
		filepath = root_dir + file
		command_cp_kernel_src = "cp " + filepath + " ./"
                
                # Generate LLVM bitcode using M2C frontend
                command_gen_ir = gen_ir + file
                command_rename = "mv " + file_name + ".llvm " + file_name + ".bc" 
		
                # Disassemble LLVM bitcode
                command_dis_bc = dis_bc + file_name + ".bc" + " -o " + file_name + ".ll"

                # Optimize LLVM bitcode
                command_opt_bc = opt_bc + file_name + ".bc -o " + file_name + ".opt.bc"

                # Generate IR from optimized LLVM bitcode
                command_dis_opt_bc = dis_bc + file_name + ".opt.bc" + " -o " + file_name + ".opt.ll"

                # Remove kernel sources
                call(command_cp_kernel_src.split())
                call(command_gen_ir.split())
                if os.path.isfile(file_name + ".llvm"):
                        call(command_rename.split())
                        call(command_dis_bc.split())
                        call(command_opt_bc.split())
                        call(command_dis_opt_bc.split())

		call(["rm", "-rf", file])	


