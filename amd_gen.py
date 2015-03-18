#!/usr/bin/python

import os
from subprocess import call

root_dir = '.'

for file in os.listdir(root_dir):
	if file.endswith(".cl"):
		call(["m2c", "--cl2llvm", file])


