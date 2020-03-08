#!/bin/bash
set -e

# 6.61. Less-551
# The Less package contains a text file viewer.

echo "Building less..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 4.1 MB"

tar -xf /sources/less-*.tar.* -C /tmp/ \
  && mv /tmp/less-* /tmp/less \
  && pushd /tmp/less

# Prepare Less for compilation:
./configure --prefix=/usr --sysconfdir=/etc

# Compile the package:
make

# Install the package:
make install

popd \
  && rm -rf /tmp/less
