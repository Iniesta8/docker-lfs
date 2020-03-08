#!/bin/bash
set -e

# 6.43. Intltool-0.51.0
# The Intltool is an internationalization tool used for extracting translatable strings
# from source files.

echo "Building Intltool..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 1.5 MB"

tar -xf /sources/intltool-*.tar.* -C /tmp/ \
  && mv /tmp/intltool-* /tmp/intltool \
  && pushd /tmp/intltool

# First fix a warning that is caused by perl-5.22 and later
sed -i 's:\\\${:\\\$\\{:' intltool-update.in

# Prepare Intltool for compilation:
./configure --prefix=/usr

# Compile the package:
make -j"$JOB_COUNT"

# Test the results:
if [ "$LFS_TEST" -eq 1 ]; then make check; fi

# Install the package:
make install
install -v -Dm644 doc/I18N-HOWTO /usr/share/doc/intltool-0.51.0/I18N-HOWTO

popd \
  && rm -rf /tmp/intltool
