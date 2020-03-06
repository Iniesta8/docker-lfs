#!/bin/bash
set -e

# 6.69. Man-DB-2.9.0
# The Man-DB package contains programs for finding and viewing man pages.

echo "Building man-db..."
echo "Approximate build time: 0.5 SBU"
echo "Required disk space: 40 MB"

tar -xf /sources/man-db-*.tar.xz -C /tmp/ \
  && mv /tmp/man-db-* /tmp/man-db \
  && pushd /tmp/man-db

# Prepare Man-DB for compilation:
sed -i '/find/s@/usr@@' init/systemd/man-db.service.in

./configure --prefix=/usr                        \
            --docdir=/usr/share/doc/man-db-2.9.0 \
            --sysconfdir=/etc                    \
            --disable-setuid                     \
            --enable-cache-owner=bin             \
            --with-browser=/usr/bin/lynx         \
            --with-vgrind=/usr/bin/vgrind        \
            --with-grap=/usr/bin/grap

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/man-db || true
