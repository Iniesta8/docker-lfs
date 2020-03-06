#!/bin/bash
set -e

# 5.20. Diffutils-3.7
# The Diffutils package contains programs that show the differences
# between files or directories.

echo "Building diffutils..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 26 MB"

tar -xf diffutils-*.tar.xz -C /tmp/ \
  && mv /tmp/diffutils-* /tmp/diffutils \
  && pushd /tmp/diffutils

./configure --prefix=/tools

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/diffutils
