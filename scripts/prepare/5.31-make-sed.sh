#!/bin/bash

# 5.31. Sed-4.8
# The Sed package contains a stream editor.

set -e

echo "Building sed..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 21 MB"

tar -xf sed-*.tar.xz -C /tmp/ \
  && mv /tmp/sed-* /tmp/sed \
  && pushd /tmp/sed

./configure --prefix=/tools

make

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install
  
popd \
  && rm -rf /tmp/sed
