#!/bin/bash
set -e

# 5.7. Glibc-2.31
# The Glibc package contains the main C library.
# This library provides the basic routines for allocating memory,
# searching directories, opening and closing files, reading and
# writing files, string handling, pattern matching, arithmetic,
# and so on. 

echo "Building glibc..."
echo "Approximate build time: 4.5 SBU"
echo "Required disk space: 896 MB"

tar -xf glibc-*.tar.* -C /tmp/ \
  && mv /tmp/glibc-* /tmp/glibc \
  && pushd /tmp/glibc

mkdir -v build \
  && cd build

../configure                         \
  --prefix=/tools                    \
  --host=$LFS_TGT                    \
  --build=$(../scripts/config.guess) \
  --enable-kernel=3.2                \
  --with-headers=/tools/include

make -j$JOB_COUNT
make install

popd \
  && rm -rf /tmp/glibc

# Perform a sanity check that basic functions (compiling and linking)
# are working as expected
echo 'int main(){}' > dummy.c \
  && $LFS_TGT-gcc dummy.c \
  && readelf -l a.out | grep ': /tools' \
  && rm -v dummy.c a.out
