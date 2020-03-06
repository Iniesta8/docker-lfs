#!/bin/bash
set -e

# 6.23. Acl-2.2.53
# The Acl package contains utilities to administer Access Control Lists,
# which are used to define more fine-grained discretionary access rights
# for files and directories.

echo "Building Acl..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 6.4 MB"

tar -xf /sources/acl-*.tar.gz -C /tmp/ \
  && mv /tmp/acl-* /tmp/acl \
  && pushd /tmp/acl

# Prepare Acl for compilation:
./configure --prefix=/usr         \
            --disable-static      \
            --libexecdir=/usr/lib \
            --docdir=/usr/share/doc/acl-2.2.53

# Compile the package:
make

# Install the package:
make install

# The shared library needs to be moved to /lib, and as a result the
# .so file in /usr/lib will need to be recreated:
mv -v /usr/lib/libacl.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libacl.so) /usr/lib/libacl.so

popd \
  && rm -rf /tmp/acl
