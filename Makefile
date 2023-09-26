PROJECTS = $(shell ls -d */)
CURRENT_DIR = $(shell pwd) 

run:	compile
	@echo "ESQ to close the game"
	find . -name build -exec sh -c "cd {} ; ./main" \;

compile:
	for PROJECT in ${PROJECTS} ; do \
		$(MAKE) PROJECT=$$PROJECT build ; \
		cd ${CURRENT_DIR} ; \
	done

build:
	cd $$PROJECT \
	&& mkdir -p build \
	&& cd build \
	&& cmake -Wno-dev -DCMAKE_BUILD_TYPE=Debug .. \
	&& $(MAKE) && echo OK || break;

clean:
	for PROJECT in ${PROJECTS} ; do \
		cd $$PROJECT && rm -rf build main ; \
		cd ${CURRENT_DIR} ; \
	done
