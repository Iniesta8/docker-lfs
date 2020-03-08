#!/bin/bash
set -e

# 6.37. GDBM-1.18.1
# The GDBM package contains the GNU Database Manager. It is a library of database
# functions that use extensible hashing and work similar to the standard UNIX dbm.
# The library provides primitives for storing key/data pairs, searching and
# retrieving the data by its key and deleting a key along with its data.

echo "Building GDBM..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 11 MB"

tar -xf /sources/gdbm-*.tar.* -C /tmp/ \
  && mv /tmp/gdbm-* /tmp/gdbm \
  && pushd /tmp/gdbm

# Prepare GDBM for compilation:
./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/gdbm
