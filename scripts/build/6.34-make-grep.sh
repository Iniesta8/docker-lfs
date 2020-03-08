#!/bin/bash
set -e

# 6.34. Grep-3.4
# The Grep package contains programs for searching through files.

echo "Building Grep..."
echo "Approximate build time: 0.7 SBU"
echo "Required disk space: 39 MB"

tar -xf /sources/grep-*.tar.* -C /tmp/ \
  && mv /tmp/grep-* /tmp/grep \
  && pushd /tmp/grep

# Prepare Grep for compilation:
./configure --prefix=/usr --bindir=/bin

# Compile the package:
make -j"$JOB_COUNT"

# Test the results:
if [ "$LFS_TEST" -eq 1 ]; then make check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/grep
