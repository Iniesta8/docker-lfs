#!/bin/bash
set -e

# 6.55. Check-0.14.0
# Check is a unit testing framework for C.

echo "Building Check..."
echo "Approximate build time: 0.1 SBU (about 3.5 SBU with tests)"
echo "Required disk space: 13 MB"

tar -xf /sources/check-*.tar.gz -C /tmp/ \
  && mv /tmp/check-* /tmp/check \
  && pushd /tmp/check

# Prepare Check for compilation:
./configure --prefix=/usr

# Build the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package and fix a script:
make docdir=/usr/share/doc/check-0.14.0 install &&
sed -i '1 s/tools/usr/' /usr/bin/checkmk

popd \
  && rm -rf /tmp/check
