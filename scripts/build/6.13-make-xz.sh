#!/bin/bash
set -e

# 6.13. Xz-5.2.4
# The Xz package contains programs for compressing and decompressing files.
# It provides capabilities for the lzma and the newer xz compression formats.
# Compressing text files with xz yields a better compression percentage
# than with the traditional gzip or bzip2 commands.

echo "Building xz..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 16 MB"

tar -xf /sources/xz-*.tar.* -C /tmp/ \
  && mv /tmp/xz-* /tmp/xz \
  && pushd /tmp/xz

# Prepare xz for compilation:
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/xz-5.2.4

# Compile the package:
make -j"$JOB_COUNT"

# Test the results:
if [ "$LFS_TEST" -eq 1 ]; then make check; fi

# Install the package and make sure that all essential files are in the correct directory:
make install
mv -v   /usr/bin/{lzma,unlzma,lzcat,xz,unxz,xzcat} /bin
mv -v /usr/lib/liblzma.so.* /lib
ln -svf ../../lib/"$(readlink /usr/lib/liblzma.so)" /usr/lib/liblzma.so

popd \
  && rm -rf /tmp/xz
