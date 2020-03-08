#!/bin/bash
set -e

# 6.21. MPC-1.1.0
# The MPC package contains a library for the arithmetic of complex numbers
# with arbitrarily high precision and correct rounding of the result. 

echo "Building MPC..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 22 MB"

tar -xf /sources/mpc-*.tar.* -C /tmp/ \
  && mv /tmp/mpc-* /tmp/mpc \
  && pushd /tmp/mpc

# Prepare MPC for compilation:
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/mpc-1.1.0

# Compile the package and generate the HTML documentation:
make -j"$JOB_COUNT"
make html

# Test the results:
if [ "$LFS_TEST" -eq 1 ]; then make check; fi

# Install the package and its documentation:
make install
if [ "$LFS_DOCS" -eq 1 ]; then make install-html; fi

popd \
  && rm -rf /tmp/mpc
