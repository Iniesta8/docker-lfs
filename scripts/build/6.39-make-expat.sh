#!/bin/bash
set -e

# 6.39. Expat-2.2.9
# The Expat package contains a stream oriented C library for parsing XML.

echo "Building Expat..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 11 MB"

tar -xf /sources/expat-*.tar.* -C /tmp/ \
  && mv /tmp/expat-* /tmp/expat \
  && pushd /tmp/expat

# First fix a problem with the regression tests in the LFS environment:
sed -i 's|usr/bin/env |bin/|' run.sh.in

# Prepare Expat for compilation:
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/expat-2.2.9

# Compile the package:
make -j"$JOB_COUNT"

# Test the results:
if [ "$LFS_TEST" -eq 1 ]; then make check; fi

# Install the package:
make install

# Install the documentation:
if [ "$LFS_DOCS" -eq 1 ]; then
  install -v -m644 doc/*.{html,png,css} /usr/share/doc/expat-2.2.9
fi

popd \
  && rm -rf /tmp/expat
