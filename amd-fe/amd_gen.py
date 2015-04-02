#!/usr/bin/python

import os
from subprocess import call

root_dir = '.'

gen_bc = "llvm-as "
opt_bc = "opt --mem2reg "
dis_bc = "llvm-dis "

for file in os.listdir(root_dir):
	if file.endswith(".bc"):
                
                file_name = os.path.splitext(file)[0]

                # Genarate LLVM IR
		command_gen_ir = dis_bc + file + " -o " + file_name + ".ll"

                # Optimize LLVM bitcode
                command_opt_bc = opt_bc + file + " -o " + file_name + ".opt.bc"

                # Disassemble optimized LLVM bitcode
                command_gen_opt_ir = dis_bc + file_name + ".opt.bc" + " -o " + file_name + ".opt.ll"

                call(command_gen_ir.split())
                call(command_opt_bc.split())
                call(command_gen_opt_ir.split())



