#!/bin/bash

# 5.35. Xz-5.2.4
# The Xz package contains programs for compressing and decompressing files.
# It provides capabilities for the lzma and the newer xz compression formats.
# Compressing text files with xz yields a better compression percentage
# than with the traditional gzip or bzip2 commands.

set -e

echo "Building xz..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 18 MB"

tar -xf xz-*.tar.xz -C /tmp/ \
  && mv /tmp/xz-* /tmp/xz \
  && pushd /tmp/xz \
  && ./configure --prefix=/tools \
  && make \
  && if [ $LFS_TEST -eq 1 ]; then make check; fi \
  && make install \
  && popd \
  && rm -rf /tmp/xz
