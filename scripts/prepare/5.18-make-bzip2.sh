#!/bin/bash
set -e

# 5.18. Bzip2-1.0.8
# The Bzip2 package contains programs for compressing and decompressing
# files. Compressing text files with bzip2 yields a much better compression
# percentage than with the traditional gzip. 

echo "Building bzip2..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.4 MB"

tar -xf bzip2-*.tar.* -C /tmp/ \
  && mv /tmp/bzip2-* /tmp/bzip2 \
  && pushd /tmp/bzip2

make -j"$JOB_COUNT" -f Makefile-libbz2_so
make clean

make -j"$JOB_COUNT"

make PREFIX=/tools install
cp -v bzip2-shared /tools/bin/bzip2
cp -av libbz2.so* /tools/lib
ln -sv libbz2.so.1.0 /tools/lib/libbz2.so

popd \
  && rm -rf /tmp/bzip2
