#!/bin/bash
set -e

# 6.65. Kbd-2.2.0
# The Kbd package contains key-table files, console fonts, and keyboard utilities.

echo "Building kbd..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 36 MB"

tar -xf /sources/kbd-*.tar.xz -C /tmp/ \
  && mv /tmp/kbd-* /tmp/kbd \
  && pushd /tmp/kbd

# Fixes an issue for i386 keymaps:
patch -Np1 -i /sources/kbd-2.2.0-backspace-1.patch

# Remove the redundant resizecons program:
sed -i 's/\(RESIZECONS_PROGS=\)yes/\1no/g' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

# Prepare Kbd for compilation:
PKG_CONFIG_PATH=/tools/lib/pkgconfig ./configure --prefix=/usr --disable-vlock

# Compile the package:
make

if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

if [ $LFS_DOCS -eq 1 ]; then
  mkdir -v       /usr/share/doc/kbd-2.2.0
  cp -R -v docs/doc/* /usr/share/doc/kbd-2.2.0
fi

popd \
  && rm -rf /tmp/kbd
