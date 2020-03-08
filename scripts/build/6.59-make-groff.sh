#!/bin/bash
set -e

# 6.59. Groff-1.22.4
# The Groff package contains programs for processing and formatting text.

echo "Building groff..."
echo "Approximate build time: 0.5 SBU"
echo "Required disk space: 95 MB"

tar -xf /sources/groff-*.tar.* -C /tmp/ \
  && mv /tmp/groff-* /tmp/groff \
  && pushd /tmp/groff

# Prepare Groff for compilation:
PAGE=<paper_size> ./configure --prefix=/usr

# This package does not support parallel build. Compile the package:
make -j1

# Install the package:
make install

popd \
  && rm -rf /tmp/groff
