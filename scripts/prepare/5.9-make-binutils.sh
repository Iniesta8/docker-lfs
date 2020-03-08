#!/bin/bash
set -e

# 5.9. Binutils-2.34 - Pass 2
# The Binutils package contains a linker, an assembler,
# and other tools for handling object files. 

echo "Building binutils (pass 2)..."
echo "Approximate build time: 1.1 SBU"
echo "Required disk space: 651 MB"

tar -xf binutils-*.tar.* -C /tmp/ \
  && mv /tmp/binutils-* /tmp/binutils \
  && pushd /tmp/binutils

mkdir -v build \
  && cd build

CC=$LFS_TGT-gcc              \
AR=$LFS_TGT-ar               \
RANLIB=$LFS_TGT-ranlib       \
../configure                 \
  --prefix=/tools            \
  --disable-nls              \
  --disable-werror           \
  --with-lib-path=/tools/lib \
  --with-sysroot

make -j$JOB_COUNT
make install

make -C ld clean
make -C ld LIB_PATH=/usr/lib:/lib
cp -v ld/ld-new /tools/bin

popd \
  && rm -rf /tmp/binutils
