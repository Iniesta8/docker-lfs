#!/bin/bash

# 5.23. Gawk-5.0.1
# The Gawk package contains programs for manipulating text files.

set -e

echo "Building gawk..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 46 MB"

tar -xf gawk-*.tar.xz -C /tmp/ \
  && mv /tmp/gawk-* /tmp/gawk \
  && pushd /tmp/gawk \
  && ./configure --prefix=/tools \
  && make \
  && if [ $LFS_TEST -eq 1 ]; then make check; fi \
  && make install \
  && popd \
  && rm -rf /tmp/gawk
