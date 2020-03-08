#!/bin/bash
set -e

# 5.26. Gzip-1.10
# The Gzip package contains programs for compressing and decompressing files.

echo "Building gzip.."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 10 MB"

tar -xf gzip-*.tar.* -C /tmp/ \
  && mv /tmp/gzip-* /tmp/gzip \
  && pushd /tmp/gzip

./configure --prefix=/tools

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/gzip
