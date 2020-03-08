#!/bin/bash
set -e

# 6.18. Binutils-2.34
# The Binutils package contains a linker, an assembler, and other tools for
# handling object files.

echo "Building binutils..."
echo "Approximate build time: 6.7 SBU"
echo "Required disk space: 5.1 GB"

tar -xf /sources/binutils-*.tar.* -C /tmp/ \
  && mv /tmp/binutils-* /tmp/binutils \
  && pushd /tmp/binutils

# Verify that the PTYs are working properly inside the chroot environment
# by performing a simple test:
expect -c "spawn ls"

# Remove one test that prevents the tests from running to completion:
sed -i '/@\tincremental_copy/d' gold/testsuite/Makefile.in

mkdir -v build \
  && cd build

# Prepare Binutils for compilation:
../configure --prefix=/usr       \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib

# Compile the package:
make tooldir=/usr

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make -k check || true; fi

# Install the package:
make tooldir=/usr install

popd \
  && rm -rf /tmp/binutils
