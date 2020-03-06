#!/bin/bash
set -e

# 6.22. Attr-2.4.48
# The attr package contains utilities to administer the extended attributes
# on filesystem objects.

echo "Building Attr..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 4.2 MB"

tar -xf /sources/attr-*.tar.gz -C /tmp/ \
  && mv /tmp/attr-* /tmp/attr \
  && pushd /tmp/attr

# Prepare Attr for compilation:
./configure --prefix=/usr     \
            --disable-static  \
            --sysconfdir=/etc \
            --docdir=/usr/share/doc/attr-2.4.48

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make check; fi

# Install the package:
make install

# The shared library needs to be moved to /lib, and as a result the
# .so file in /usr/lib will need to be recreated:
mv -v /usr/lib/libattr.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libattr.so) /usr/lib/libattr.so

popd \
  && rm -rf /tmp/attr
