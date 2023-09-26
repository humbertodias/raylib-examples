PROJECTS = $(shell ls -d */)
CURRENT_DIR = $(shell pwd) 

all:
	@echo "ESQ to close the game"
	for PROJECT in ${PROJECTS} ; do \
		$(MAKE) run PROJECT=$$PROJECT ; \
		cd ${CURRENT_DIR} ; \
	done

run:
	$(MAKE) PROJECT=$$PROJECT compile-cmake ; \
	cd $$PROJECT/build && ./main ; \

compile-gcc:
	echo $$PROJECT
	cd $$PROJECT \
	&& gcc src/main.c -o main `pkg-config --cflags --libs raylib`

compile-cmake:
	cd $$PROJECT \
	&& mkdir -p build \
	&& cd build \
	&& cmake .. -DCMAKE_BUILD_TYPE=Release \
	&& $(MAKE) && echo OK || break;

compile-web:
	cd $$PROJECT \
	mkdir build
	cd build
	emcmake cmake .. -DCMAKE_BUILD_TYPE=Release -DPLATFORM=Web
	emmake make

clean:
	for PROJECT in ${PROJECTS} ; do \
		cd $$PROJECT && rm -rf build main ; \
		cd ${CURRENT_DIR} ; \
	done

ln:
	for PROJECT in ${PROJECTS} ; do \
		cd $$PROJECT && ln -s ../CMakeLists-common.txt CMakeLists.txt ; \
		cd ${CURRENT_DIR} ; \
	done

unlink:
	for PROJECT in ${PROJECTS} ; do \
		rm -f $$PROJECT/CMakeLists.txt ; \
	done