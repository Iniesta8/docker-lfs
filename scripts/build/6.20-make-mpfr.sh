#!/bin/bash
set -e

# 6.20. MPFR-4.0.2
# The MPFR package contains functions for multiple precision math.

echo "Building MPFR..."
echo "Approximate build time: 0.8 SBU"
echo "Required disk space: 37 MB"

tar -xf /sources/mpfr-*.tar.xz -C /tmp/ \
  && mv /tmp/mpfr-* /tmp/mpfr \
  && pushd /tmp/mpfr

# Prepare MPFR for compilation:
./configure --prefix=/usr        \
            --disable-static     \
            --enable-thread-safe \
            --docdir=/usr/share/doc/mpfr-4.0.2

# Compile the package and generate the HTML documentation:
make
make html

# Test the results and ensure that all tests passed:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package and its documentation:
make install
if [ $LFS_DOCS -eq 1 ]; then make install-html; fi

popd \
  && rm -rf /tmp/mpfr
