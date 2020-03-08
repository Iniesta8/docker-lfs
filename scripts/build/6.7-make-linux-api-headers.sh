#!/bin/bash
set -e

# 6.7. Linux-5.5.3 API Headers
# The Linux API Headers (in linux-5.5.3.tar.*) expose the kernel's API for use by Glibc.

echo "Building Linux API headers..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 1 GB"

# 6.7.1. Install Linux API Headers
tar -xf /sources/linux-*.tar.* -C /tmp/ \
  && mv /tmp/linux-* /tmp/linux \
  && pushd /tmp/linux

make mrproper

make headers
find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include/* /usr/include

popd \
  && rm -rf /tmp/linux
