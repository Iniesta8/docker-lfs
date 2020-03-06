#!/bin/bash
set -e

# 5.25. Grep-3.4
# The Grep package contains programs for searching through files.

echo "Building grep..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 25 MB"

tar -xf grep-*.tar.xz -C /tmp/ \
  && mv /tmp/grep-* /tmp/grep \
  && pushd /tmp/grep

./configure --prefix=/tools

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/grep
