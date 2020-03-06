#!/bin/bash
set -e

# 6.17. Bc-2.5.3
# The Bc package contains an arbitrary precision numeric processing language.

echo "Building bc..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 2.9 MB"

tar -xf /sources/bc-*.tar.gz -C /tmp/ \
  && mv /tmp/bc-* /tmp/bc \
  && pushd /tmp/bc

# Prepare Bc for compilation:
PREFIX=/usr CC=gcc CFLAGS="-std=c99" ./configure.sh -G -O3

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make test; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/bc
