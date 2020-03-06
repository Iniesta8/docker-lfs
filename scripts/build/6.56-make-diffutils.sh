#!/bin/bash
set -e

# 6.56. Diffutils-3.7
# The Diffutils package contains programs that show the differences between
# files or directories.

echo "Building diffutils..."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 36 MB"

tar -xf /sources/diffutils-*.tar.xz -C /tmp/ \
  && mv /tmp/diffutils-* /tmp/diffutils \
  && pushd /tmp/diffutils

# Prepare Diffutils for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/diffutils
