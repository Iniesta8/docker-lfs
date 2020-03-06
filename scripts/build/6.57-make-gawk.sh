#!/bin/bash
set -e

# 6.57. Gawk-5.0.1
# The Gawk package contains programs for manipulating text files

echo "Building gawk..."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 47 MB"

tar -xf /sources/gawk-*.tar.xz -C /tmp/ \
  && mv /tmp/gawk-* /tmp/gawk \
  && pushd /tmp/gawk

# First, ensure some unneeded files are not installed:
sed -i 's/extras//' Makefile.in

# Prepare Gawk for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

# Install the documentation:
if [ $LFS_DOCS -eq 1 ]; then
  mkdir -v /usr/share/doc/gawk-5.0.1
  cp    -v doc/{awkforai.txt,*.{eps,pdf,jpg}} /usr/share/doc/gawk-5.0.1
fi

popd \
  && rm -rf /tmp/gawk
