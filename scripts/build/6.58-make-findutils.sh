#!/bin/bash
set -e

# 6.58. Findutils-4.7.0
# The Findutils package contains programs to find files. These programs are provided
# to recursively search through a directory tree and to create, maintain, and search
# a database (often faster than the recursive find, but unreliable if the database
# has not been recently updated).

echo "Building findutils..."
echo "Approximate build time: 0.7 SBU"
echo "Required disk space: 57 MB"

tar -xf /sources/findutils-*.tar.* -C /tmp/ \
  && mv /tmp/findutils-* /tmp/findutils \
  && pushd /tmp/findutils

# Prepare Findutils for compilation:
./configure --prefix=/usr --localstatedir=/var/lib/locate

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

# Some packages in BLFS and beyond expect the find program in /bin, so make sure it's placed there:
mv -v /usr/bin/find /bin
sed -i 's|find:=${BINDIR}|find:=/bin|' /usr/bin/updatedb

popd \
  && rm -rf /tmp/findutils
