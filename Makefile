# Executables
CC=m68k-palmos-gcc
OBJ_RES=m68k-palmos-obj-res
PRC=build-prc
SDK=sdk-3.5

TARGET=hello
DB_NAME="Hello, World"
CRID=WRLD

SRC= \
	Src/hello.c

all: build/${TARGET}.prc

build:
	mkdir -p build

set-sdk:
	palmdev-prep -d ${SDK}

build/${TARGET}.bin: set-sdk ${SRC} | build
	${CC} -g ${SRC} -o build/${TARGET}.bin

build/*.${TARGET}.bin.grc: build/${TARGET}.bin
	(cd build && ${OBJ_RES} ${TARGET}.bin)

build/${TARGET}.prc: build/*.${TARGET}.bin.grc
	${PRC} build/${TARGET}.prc ${DB_NAME} ${CRID} build/*.grc

clean:
	rm -rf build

.PHONY: all clean set-sdk