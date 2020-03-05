#!/bin/bash

# 5.33. Texinfo-6.7
#  The Texinfo package contains programs for reading, writing, and
# converting info pages.

set -e

echo "Building texinfo..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 104 MB"

tar -xf texinfo-*.tar.xz -C /tmp/ \
  && mv /tmp/texinfo-* /tmp/texinfo \
  && pushd /tmp/texinfo \
  && ./configure --prefix=/tools \
  && make \
  && if [ $LFS_TEST -eq 1 ]; then make check; fi \
  && make install \
  && popd \
  && rm -rf /tmp/texinfo
