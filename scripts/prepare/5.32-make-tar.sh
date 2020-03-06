#!/bin/bash
set -e

# 5.32. Tar-1.32
# The Tar package contains an archiving program.

echo "Building tar..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 38 MB"

tar -xf tar-*.tar.xz -C /tmp/ \
  && mv /tmp/tar-* /tmp/tar \
  && pushd /tmp/tar

./configure --prefix=/tools

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/tar
