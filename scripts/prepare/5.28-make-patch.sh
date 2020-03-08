#!/bin/bash
set -e

# 5.28. Patch-2.7.6
# The Patch package contains a program for modifying or creating files
# by applying a “patch” file typically created by the diff program. 

echo "Building patch..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 13 MB"

tar -xf patch-*.tar.* -C /tmp/ \
  && mv /tmp/patch-* /tmp/patch \
  && pushd /tmp/patch

./configure --prefix=/tools

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/patch
