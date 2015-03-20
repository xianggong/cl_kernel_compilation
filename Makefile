
.PHONY: amd clang m2c

all: amd clang m2c

amd:
	cd amd-fe && $(MAKE)	

clang:
	cd clang-fe && $(MAKE)	

m2c:
	cd m2c-fe && $(MAKE)	

clean:
	cd amd-fe && $(MAKE) clean	
	cd clang-fe && $(MAKE) clean	
	cd m2c-fe && $(MAKE) clean	
