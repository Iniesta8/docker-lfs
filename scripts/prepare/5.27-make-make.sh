#!/bin/bash
set -e

# 5.27. Make-4.3
# The Make package contains a program for compiling packages.

echo "Building make..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 16 MB"

tar -xf make-*.tar.bz2 -C /tmp/ \
  && mv /tmp/make-* /tmp/make \
  && pushd /tmp/make

./configure --prefix=/tools --without-guile

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install 

popd \
  && rm -rf /tmp/make
