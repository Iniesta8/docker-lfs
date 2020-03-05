#!/bin/bash

# 5.27. Make-4.3
# The Make package contains a program for compiling packages.

set -e

echo "Building make..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 16 MB"

tar -xf make-*.tar.bz2 -C /tmp/ \
  && mv /tmp/make-* /tmp/make \
  && pushd /tmp/make \
  && ./configure --prefix=/tools --without-guile \
  && make \
  && if [ $LFS_TEST -eq 1 ]; then make check; fi \ 
  && make install \ 
  && popd \
  && rm -rf /tmp/make
