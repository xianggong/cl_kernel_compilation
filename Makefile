
.PHONY: m2c clang

all: m2c clang

m2c:
	python m2c_gen.py

clang:
	python clang_gen.py

clean:
	rm -rf *.clp *.llvm *.ll
