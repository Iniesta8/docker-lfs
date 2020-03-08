#!/bin/bash
set -e

# 6.47. Gettext-0.20.1
# The Gettext package contains utilities for internationalization and localization.
# These allow programs to be compiled with NLS (Native Language Support), enabling
# them to output messages in the user's native language.

echo "Building gettext..."
echo "Approximate build time: 2.7 SBU"
echo "Required disk space: 249 MB"

tar -xf /sources/gettext-*.tar.* -C /tmp/ \
  && mv /tmp/gettext-* /tmp/gettext \
  && pushd /tmp/gettext

# Prepare Gettext for compilation:
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/gettext-0.20.1

# Compile the package:
make

# Test the results (this takes a long time, around 3 SBUs)
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install
chmod -v 0755 /usr/lib/preloadable_libintl.so

popd \
  && rm -rf /tmp/gettext
