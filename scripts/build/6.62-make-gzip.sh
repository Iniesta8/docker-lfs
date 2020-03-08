#!/bin/bash
set -e

# 6.62. Gzip-1.10
# The Gzip package contains programs for compressing and decompressing files.

echo "Building Gzip..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 20 MB"

tar -xf /sources/gzip-*.tar.* -C /tmp/ \
  && mv /tmp/gzip-* /tmp/gzip \
  && pushd /tmp/gzip

# Prepare Gzip for compilation:
./configure --prefix=/usr

# Compile the package:
make -j"$JOB_COUNT"

# Test the results (Two tests are known to fail in the LFS environment: help-version and zmore):
if [ "$LFS_TEST" -eq 1 ]; then make check || true; fi

# Install the package:
make install
mv -v /usr/bin/gzip /bin

popd \
  && rm -rf /tmp/gzip
