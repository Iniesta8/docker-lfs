#!/bin/bash
set -e

# 6.26. Pkg-config-0.29.2
# The pkg-config package contains a tool for passing the include path and/or 
# library paths to build tools during the configure and make file execution.

echo "Building pkg config..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 30 MB"

tar -xf /sources/pkg-config-*.tar.* -C /tmp/ \
  && mv /tmp/pkg-config-* /tmp/pkg-config \
  && pushd /tmp/pkg-config

# Prepare Pkg-config for compilation:
./configure --prefix=/usr              \
            --with-internal-glib       \
            --disable-host-tool        \
            --docdir=/usr/share/doc/pkg-config-0.29.2

# Compile the package:
make -j"$JOB_COUNT"

# Test the results:
if [ "$LFS_TEST" -eq 1 ]; then make check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/pkg-config
