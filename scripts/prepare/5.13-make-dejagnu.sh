#!/bin/bash
set -e

# 5.13. DejaGNU-1.6.2
# The DejaGNU package contains a framework for testing other programs.

echo "Building DejaGNU..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 3.2 MB"

tar -xf dejagnu-*.tar.gz -C /tmp/ \
  && mv /tmp/dejagnu-* /tmp/dejagnu \
  && pushd /tmp/dejagnu

./configure --prefix=/tools

make -j$JOB_COUNT install

if [ $LFS_TEST -eq 1 ]; then make check; fi

popd \
  && rm -rf /tmp/dejagnu
