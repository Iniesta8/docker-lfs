#!/bin/bash
set -e

# 6.14. File-5.38
# The File package contains a utility for determining the type of a given file or files. 

echo "Building file..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 20 MB"

tar -xf /sources/file-*.tar.gz -C /tmp/ \
  && mv /tmp/file-* /tmp/file \
  && pushd /tmp/file

# Prepare File for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/file
