#!/bin/bash
set -e

# 6.70. Tar-1.32
# The Tar package contains an archiving program.

echo "Building tar..."
echo "Approximate build time: 2.0 SBU"
echo "Required disk space: 45 MB"

tar -xf /sources/tar-*.tar.xz -C /tmp/ \
  && mv /tmp/tar-* /tmp/tar \
  && pushd /tmp/tar

# Prepare Tar for compilation:
FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin

# Compile the package:
make

# Test the results (about 3 SBUs):
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install
make -C doc install-html docdir=/usr/share/doc/tar-1.32

popd \
  && rm -rf /tmp/tar || true
