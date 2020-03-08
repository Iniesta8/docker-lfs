#!/bin/bash
set -e

# 6.48. Libelf from Elfutils-0.178
# Libelf is a library for handling ELF (Executable and Linkable Format) files.

echo "Building Libelf..."
echo "Approximate build time: 0.9 SBU"
echo "Required disk space: 124 MB"

tar -xf /sources/elfutils-*.tar.* -C /tmp/ \
  && mv /tmp/elfutils-* /tmp/elfutils \
  && pushd /tmp/elfutils

# Prepare Libelf for compilation:
./configure --prefix=/usr --disable-debuginfod

# Compile the package:
make -j"$JOB_COUNT"

# Test the results (One test, run-elfclassify.sh, is known to fail):
if [ "$LFS_TEST" -eq 1 ]; then make check || true; fi

# Install only Libelf:
make -C libelf install
install -vm644 config/libelf.pc /usr/lib/pkgconfig
rm /usr/lib/libelf.a

popd \
  && rm -rf /tmp/elfutils
