#!/bin/bash
set -e

# 6.45. Automake-1.16.1
# The Automake package contains programs for generating Makefiles for use with Autoconf.

echo "Building Automake..."
echo "Approximate build time: less than 0.1 SBU (about 8.1 SBU with tests)"
echo "Required disk space: 107 MB"

tar -xf /sources/automake-*.tar.* -C /tmp/ \
  && mv /tmp/automake-* /tmp/automake \
  && pushd /tmp/automake

# Prepare Automake for compilation:
./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.1

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make -j4 check || true; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/automake
