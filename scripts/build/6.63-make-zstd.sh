#!/bin/bash
set -e

# 6.63. Zstd-1.4.4
# Zstandard is a real-time compression algorithm, providing high compression ratios.
# It offers a very wide range of compression / speed trade-offs, while being backed
# by a very fast decoder.

echo "Building zstd..."
echo "Approximate build time: 0.7 SBU"
echo "Required disk space: 16 MB"

tar -xf /sources/zstd-*.tar.xz -C /tmp/ \
  && mv /tmp/zstd-* /tmp/zstd \
  && pushd /tmp/zstd

# Compile the package:
make

# Install the package:
make prefix=/usr install

# Remove the static library and move the shared library to /lib.
# Also, the .so file in /usr/lib will need to be recreated:
rm -v /usr/lib/libzstd.a
mv -v /usr/lib/libzstd.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libzstd.so) /usr/lib/libzstd.so

popd \
  && rm -rf /tmp/zstd
