#!/bin/bash
set -e

# 6.11. Zlib-1.2.11
# The Zlib package contains compression and decompression routines used by some programs.

echo "Building zlib..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 5.1 MB"

tar -xf /sources/zlib-*.tar.* -C /tmp/ \
  && mv /tmp/zlib-* /tmp/zlib \
  && pushd /tmp/zlib

# Prepare Zlib for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install
mv -v /usr/lib/libz.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libz.so) /usr/lib/libz.so

popd \
  && rm -rf /tmp/zlib
