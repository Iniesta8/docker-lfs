#!/bin/bash
set -e

# 6.19. GMP-6.2.0
# The GMP package contains math libraries. These have useful functions for
# arbitrary precision arithmetic.

echo "Building GMP..."
echo "Approximate build time: 1.1 SBU"
echo "Required disk space: 51 MB"

tar -xf /sources/gmp-*.tar.xz -C /tmp/ \
  && mv /tmp/gmp-* /tmp/gmp \
  && pushd /tmp/gmp

# Prepare GMP for compilation:
./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.2.0

# Compile the package and generate the HTML documentation:
make
make html

# Test the results:
if [ $LFS_TEST -eq 1 ]; then
  make check 2>&1 | tee gmp-check-log
  awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log
fi

# Install the package and its documentation:
make install
if [ $LFS_DOCS -eq 1 ]; then make install-html; fi

popd \
  && rm -rf /tmp/gmp
