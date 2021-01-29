#!/bin/bash
set -e

# 5.2. Binutils-2.35 - Pass 1 
# The Binutils package contains a linker, an assembler, and other
# tools for handling object files.

echo "Building binutils (pass 1)..."
echo "Approximate build time: 1 SBU"
echo "Required disk space: 617 MB"

tar -xf binutils-*.tar.* -C /tmp/ \
  && mv /tmp/binutils-* /tmp/binutils \
  && pushd /tmp/binutils

mkdir -v build \
  && cd build

../configure --prefix=/tools            \
             --with-sysroot="$LFS"      \
             --target="$LFS_TGT"        \
             --disable-nls              \
             --disable-werror

make -j"$JOB_COUNT"

make install

popd \
  && rm -rf /tmp/binutils
