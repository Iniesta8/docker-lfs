#!/bin/bash
set -e

# 6.49. Libffi-3.3
# The Libffi library provides a portable, high level programming interface to
# various calling conventions. This allows a programmer to call any function
# specified by a call interface description at run time.

echo "Building Libffi..."
echo "Approximate build time: 1.9 SBU"
echo "Required disk space: 10 MB"

tar -xf /sources/libffi-*.tar.* -C /tmp/ \
  && mv /tmp/libffi-* /tmp/libffi \
  && pushd /tmp/libffi


# Prepare libffi for compilation:
./configure --prefix=/usr --disable-static --with-gcc-arch=native

# Compile the package:
make

# Test the results (Six tests, all related to test-callback.c, are known to fail):
if [ $LFS_TEST -eq 1 ]; then make check || true; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/libffi
