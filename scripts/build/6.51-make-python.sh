#!/bin/bash
set -e

# 6.51. Python-3.8.1
# The Python 3 package contains the Python development environment.
# It is useful for object-oriented programming, writing scripts, prototyping large
# programs or developing entire applications.

echo "Building Python..."
echo "Approximate build time: 1.2 SBU"
echo "Required disk space: 426 MB"

tar -xf /sources/Python-*.tar.xz -C /tmp/ \
  && mv /tmp/Python-* /tmp/python \
  && pushd /tmp/python

# Prepare Python for compilation:
./configure --prefix=/usr       \
            --enable-shared     \
            --with-system-expat \
            --with-system-ffi   \
            --with-ensurepip=yes

# Compile the package
make

# Install the package:
make install
chmod -v 755 /usr/lib/libpython3.8.so
chmod -v 755 /usr/lib/libpython3.so
ln -sfv pip3.8 /usr/bin/pip3

# install the preformatted documentation:
if [ $LFS_DOCS -eq 1 ]; then
  install -v -dm755 /usr/share/doc/python-3.8.1/html 

  tar --strip-components=1  \
      --no-same-owner       \
      --no-same-permissions \
      -C /usr/share/doc/python-3.8.1/html \
      -xvf ../python-3.8.1-docs-html.tar.bz2
fi

popd \
  && rm -rf /tmp/python
