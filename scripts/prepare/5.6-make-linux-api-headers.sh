#!/bin/bash
set -e

# 5.6. Linux-5.5.3 API Headers
# The Linux API Headers (in linux-5.5.3.tar.*) expose
# the kernel's API for use by Glibc. 

echo "Building Linux API Headers..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 1 GB"

tar -xf linux-*.tar.* -C /tmp/ \
  && mv /tmp/linux-* /tmp/linux \
  && pushd /tmp/linux

make mrproper
make -j"$JOB_COUNT" headers

cp -rv usr/include/* /tools/include

popd \
  && rm -rf /tmp/linux
