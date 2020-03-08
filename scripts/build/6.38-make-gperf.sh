#!/bin/bash
set -e

# 6.38. Gperf-3.1
# Gperf generates a perfect hash function from a key set.

echo "Building gperf..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.3 MB"

tar -xf /sources/gperf-*.tar.* -C /tmp/ \
  && mv /tmp/gperf-* /tmp/gperf \
  && pushd /tmp/gperf

# Prepare Gperf for compilation:
./configure --prefix=/usr --docdir=/usr/share/doc/gperf-3.1

# Compile the package:
make -j"$JOB_COUNT"

# Test the results:
if [ "$LFS_TEST" -eq 1 ]; then make -j1 check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/gperf
