#!/bin/bash

VERSION=1.3
FOLDER_NAME=zlib-$VERSION
ARCHIVE_NAME=zlib-$VERSION.tar.gz
LIB_NAME=libz.a
MIRROR=https://www.zlib.net/fossils/

declare -a TOOLCHAINS=("linux_gcc_i686" "linux_clang_i686" "linux_gcc_x64" "linux_clang_x64")

wget -nc $MIRROR$ARCHIVE_NAME
tar -xf $ARCHIVE_NAME

for TOOLCHAIN in "${TOOLCHAINS[@]}"
do
  mkdir -p build-$TOOLCHAIN
  cmake -S $FOLDER_NAME -B build-$TOOLCHAIN -DCMAKE_INSTALL_PREFIX=install-$TOOLCHAIN -DCMAKE_TOOLCHAIN_FILE=../toolchains/$TOOLCHAIN.cmake -G Ninja
  ninja -C build-$TOOLCHAIN install
  mkdir -p objects-$TOOLCHAIN
  ar x ./install-$TOOLCHAIN/lib/$LIB_NAME --output objects-$TOOLCHAIN
  sha1sum ./install-$TOOLCHAIN/lib/$LIB_NAME >> zlib.sha1
  find objects-$TOOLCHAIN/ -type f -name "*.o" | xargs -I % rz-sign -e flirt.node.optimize=0 -o %.pat %
  python generate-pat.py --auto --overwrite --recursive -d objects-$TOOLCHAIN/ -o zlib-$TOOLCHAIN.pat
done
