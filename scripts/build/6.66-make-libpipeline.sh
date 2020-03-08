#!/bin/bash
set -e

# 6.66. Libpipeline-1.5.2
# The Libpipeline package contains a library for manipulating pipelines of subprocesses
# in a flexible and convenient way.

echo "Building libpipeline..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 9.2 MB"

tar -xf /sources/libpipeline-*.tar.* -C /tmp/ \
  && mv /tmp/libpipeline-* /tmp/libpipeline \
  && pushd /tmp/libpipeline

# Prepare Libpipeline for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/libpipeline
