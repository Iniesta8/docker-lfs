#!/bin/bash
set -e

# 6.33. Flex-2.6.4
# The Flex package contains a utility for generating programs that recognize patterns in text.
echo "Building Flex..."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 36 MB"

tar -xf /sources/flex-*.tar.* -C /tmp/ \
  && mv /tmp/flex-* /tmp/flex \
  && pushd /tmp/flex

# First, fix a problem introduced with glibc-2.26:
sed -i "/math.h/a #include <malloc.h>" src/flexdef.h

# Prepare Flex for compilation:
HELP2MAN=/tools/bin/true \
./configure --prefix=/usr --docdir=/usr/share/doc/flex-2.6.4

# Compile the package:
make

# Test the results (about 0.5 SBU)
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install
ln -sv flex /usr/bin/lex

popd \
  && rm -rf /tmp/flex
