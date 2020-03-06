#!/bin/bash
set -e

# 5.21. File-5.38
# The File package contains a utility for determining the type
# of a given file or files.

echo "Building file..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 20 MB"

tar -xf file-*.tar.gz -C /tmp/ \
  && mv /tmp/file-* /tmp/file \
  && pushd /tmp/file

./configure --prefix=/tools

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/file
