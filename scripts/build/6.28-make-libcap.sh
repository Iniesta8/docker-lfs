#!/bin/bash
set -e

# 6.28. Libcap-2.31
# The Libcap package implements the user-space interfaces to the POSIX 1003.1e
# capabilities available in Linux kernels. These capabilities are a partitioning
# of the all powerful root privilege into a set of distinct privileges.

echo "Building Libcap.."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 8.5 MB"

tar -xf /sources/libcap-*.tar.xz -C /tmp/ \
  && mv /tmp/libcap-* /tmp/libcap \
  && pushd /tmp/libcap

# Prevent two static libraries from being installed:
sed -i '/install.*STA...LIBNAME/d' libcap/Makefile

# Compile the package:
make lib=lib

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make test; fi

# Install the package:
make lib=lib install
chmod -v 755 /lib/libcap.so.2.31

popd \
  && rm -rf /tmp/libcap
