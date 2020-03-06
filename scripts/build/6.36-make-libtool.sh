#!/bin/bash
set -e

# 6.36. Libtool-2.4.6
# The Libtool package contains the GNU generic library support script.
# It wraps the complexity of using shared libraries in a consistent,
# portable interface.

echo "Building libtool..."
echo "Approximate build time: 1.8 SBU"
echo "Required disk space: 43 MB"

tar -xf /sources/libtool-*.tar.xz -C /tmp/ \
  && mv /tmp/libtool-* /tmp/libtool \
  && pushd /tmp/libtool

# Prepare Libtool for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Five tests are known to fail in the LFS build environment due to a circular
# dependency, but all tests pass if rechecked after automake is installed
if [ $LFS_TEST -eq 1 ]; then make check TESTSUITEFLAGS=-j2 || true; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/libtool
