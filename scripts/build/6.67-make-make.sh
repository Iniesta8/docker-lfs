#!/bin/bash
set -e

# 6.67. Make-4.3
# The Make package contains a program for compiling packages.

echo "Building make..."
echo "Approximate build time: 0.5 SBU"
echo "Required disk space: 16 MB"

tar -xf /sources/make-*.tar.bz2 -C /tmp/ \
  && mv /tmp/make-* /tmp/make \
  && pushd /tmp/make

# Prepare Make for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make PERL5LIB=$PWD/tests/ check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/make
