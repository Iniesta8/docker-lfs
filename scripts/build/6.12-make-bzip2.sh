#!/bin/bash
set -e

# 6.12. Bzip2-1.0.8
# The Bzip2 package contains programs for compressing and decompressing
# files. Compressing text files with bzip2 yields a much better compression
# percentage than with the traditional gzip.

echo "Building bzip2..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 7.7 MB"

tar -xf /sources/bzip2-*.tar.* -C /tmp/ \
  && mv /tmp/bzip2-* /tmp/bzip2 \
  && pushd /tmp/bzip2

# Apply a patch that will install the documentation for this package:
patch -Np1 -i /sources/bzip2-1.0.8-install_docs-1.patch

# The following command ensures installation of symbolic links are relative
sed -i 's@\(ln -s -f \)$(PREFIX)/bin/@\1@' Makefile

# Ensure the man pages are installed into the correct location:
sed -i "s@(PREFIX)/man@(PREFIX)/share/man@g" Makefile

# Prepare Bzip2 for compilation:
make -f Makefile-libbz2_so
make clean

# Compile and test the package:
make

# Install the programs:
make PREFIX=/usr install

# Install the shared bzip2 binary into the /bin directory, make some
# necessary symbolic links, and clean up:
cp -v bzip2-shared /bin/bzip2
cp -av libbz2.so* /lib
ln -sv ../../lib/libbz2.so.1.0 /usr/lib/libbz2.so
rm -v /usr/bin/{bunzip2,bzcat,bzip2}
ln -sv bzip2 /bin/bunzip2
ln -sv bzip2 /bin/bzcat

popd \
  && rm -rf /tmp/bzip2
