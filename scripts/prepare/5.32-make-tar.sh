#!/bin/bash

# 5.32. Tar-1.32
# The Tar package contains an archiving program.

set -e

echo "Building tar..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 38 MB"

tar -xf tar-*.tar.xz -C /tmp/ \
  && mv /tmp/tar-* /tmp/tar \
  && pushd /tmp/tar \
  && ./configure --prefix=/tools \
  && make \
  && if [ $LFS_TEST -eq 1 ]; then make check; fi \
  && make install \
  && popd \
  && rm -rf /tmp/tar || true
