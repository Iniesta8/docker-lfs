#!/bin/bash
set -e

# 6.32. Bison-3.5.2
# The Bison package contains a parser generator.

echo "Building Bison..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 43 MB"

tar -xf /sources/bison-*.tar.* -C /tmp/ \
  && mv /tmp/bison-* /tmp/bison \
  && pushd /tmp/bison

# Prepare Bison for compilation:
./configure --prefix=/usr --docdir=/usr/share/doc/bison-3.5.2

# Compile the package:
make -j"$JOB_COUNT"

# Install the package:
make install

popd \
  && rm -rf /tmp/bison
