#!/bin/bash
set -e

# 5.33. Texinfo-6.7
#  The Texinfo package contains programs for reading, writing, and
# converting info pages.

echo "Building texinfo..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 104 MB"

tar -xf texinfo-*.tar.* -C /tmp/ \
  && mv /tmp/texinfo-* /tmp/texinfo \
  && pushd /tmp/texinfo

./configure --prefix=/tools

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/texinfo
