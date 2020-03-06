#!/bin/bash

# 5.4. Binutils-2.34 - Pass 1 
# The Binutils package contains a linker, an assembler, and other
# tools for handling object files.

set -e

echo "Building binutils..."
echo "Approximate build time: 1 SBU"
echo "Required disk space: 625 MB"

tar -xf binutils-*.tar.xz -C /tmp/ \
  && mv /tmp/binutils-* /tmp/binutils \
  && pushd /tmp/binutils

mkdir -v build \
  && cd build

../configure                 \
  --prefix=/tools            \
  --with-sysroot=$LFS        \
  --with-lib-path=/tools/lib \
  --target=$LFS_TGT          \
  --disable-nls              \
  --disable-werror           \

make

case $(uname -m) in
  x86_64) mkdir -v /tools/lib && ln -sv lib /tools/lib64 ;;
esac

make install

popd \
  && rm -rf /tmp/binutils
