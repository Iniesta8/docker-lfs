#!/bin/bash
set -e

# 6.68. Patch-2.7.6
# The Patch package contains a program for modifying or creating files by
# applying a “patch” file typically created by the diff program.

echo "Building patch..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 13 MB"

tar -xf /sources/patch-*.tar.xz -C /tmp/ \
  && mv /tmp/patch-* /tmp/patch \
  && pushd /tmp/patch

# Prepare Patch for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/patch
