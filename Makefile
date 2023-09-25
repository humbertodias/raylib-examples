PROJECTS = $(shell ls -d */)
CURRENT_DIR = $(shell pwd) 

all:
	for PROJECT in ${PROJECTS} ; do \
		cd $$PROJECT && mkdir -p build && cd build && cmake .. && $(MAKE) && echo OK || break; \
		cd ${CURRENT_DIR} ; \
	done
	$(MAKE) usage

usage:
	@echo "Try to run the following executables:"
	@find . -name main | grep build

clean:
	for PROJECT in ${PROJECTS} ; do \
		cd $$PROJECT && rm -rf build main ; \
		cd ${CURRENT_DIR} ; \
	done