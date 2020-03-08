#!/bin/bash
set -e

# 6.46. Kmod-26
# The Kmod package contains libraries and utilities for loading kernel modules.

echo "Building kmod..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 13 MB"

tar -xf /sources/kmod-*.tar.* -C /tmp/ \
  && mv /tmp/kmod-* /tmp/kmod \
  && pushd /tmp/kmod

# Prepare Kmod for compilation:
./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib

# Compile the package:
make -j"$JOB_COUNT"

# Install the package, and create symlinks for compatibility with Module-Init-Tools
# (the package that previously handled Linux kernel modules):
make install
for target in depmod insmod lsmod modinfo modprobe rmmod; do
  ln -sfv ../bin/kmod /sbin/$target
done
ln -sfv kmod /bin/lsmod

popd \
  && rm -rf /tmp/kmod
