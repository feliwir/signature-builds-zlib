#!/bin/bash

ARCH_DIR=elf/x86/32/fedora-zlib/
mkdir -p $ARCH_DIR
cp fedora-zlib.description $ARCH_DIR
cp zlib.sha1 $ARCH_DIR/fedora-zlib.sha1
python generate-pat.py --auto --overwrite --input zlib-linux_gcc_i686.pat --input zlib-linux_clang_i686.pat --output $ARCH_DIR/fedora-zlib.pat

ARCH_DIR=elf/x86/64/fedora-zlib/
mkdir -p $ARCH_DIR
cp fedora-zlib.description $ARCH_DIR
cp zlib.sha1 $ARCH_DIR/fedora-zlib.sha1
python generate-pat.py --auto --overwrite --input zlib-linux_gcc_x64.pat --input zlib-linux_clang_x64.pat --output $ARCH_DIR/fedora-zlib.pat