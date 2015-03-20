#!/usr/bin/python

import os
from subprocess import call

root_dir = '../kernel-src/'

for file in os.listdir(root_dir):
	if file.endswith(".cl"):
		filepath = root_dir + file
		cpfile = "cp " + filepath + " ./"
		call(cpfile.split())
		call(["m2c", "--cl2llvm", file])
		file_llvm = file.split(".")[0] + ".llvm"
		if os.path.isfile(file_llvm):
			call(["llvm-dis", file_llvm])
		call(["rm", "-rf", file])	


