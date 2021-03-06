#!/bin/bash
set -e

# 5.23. Gawk-5.0.1
# The Gawk package contains programs for manipulating text files.

echo "Building gawk..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 46 MB"

tar -xf gawk-*.tar.* -C /tmp/ \
  && mv /tmp/gawk-* /tmp/gawk \
  && pushd /tmp/gawk

./configure --prefix=/tools

make -j"$JOB_COUNT"

if [ "$LFS_TEST" -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/gawk
