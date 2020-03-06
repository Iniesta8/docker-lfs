#!/bin/bash
set -e

# 6.50. OpenSSL-1.1.1d
# The OpenSSL package contains management tools and libraries relating to cryptography.
# These are useful for providing cryptographic functions to other packages, such as
# OpenSSH, email applications and web browsers (for accessing HTTPS sites).

echo "Building OpenSSL..."
echo "Approximate build time: 2.1 SBU"
echo "Required disk space: 146 MB"

tar -xf /sources/openssl-*.tar.gz -C /tmp/ \
  && mv /tmp/openssl-* /tmp/openssl \
  && pushd /tmp/openssl

# Prepare OpenSSL for compilation:
./config --prefix=/usr         \
         --openssldir=/etc/ssl \
         --libdir=lib          \
         shared                \
         zlib-dynamic

# Compile the package:
make

# Test the results (One subtest in the test 20-test_enc.t is known to fail):
if [ $LFS_TEST -eq 1 ]; then make test || true; fi
 
# Install the package:
sed -i '/INSTALL_LIBS/s/libcrypto.a libssl.a//' Makefile
make MANSUFFIX=ssl install

# Install the documentation:
if [ $LFS_DOCS -eq 1 ]; then
  mv -v /usr/share/doc/openssl /usr/share/doc/openssl-1.1.1d
  cp -vfr doc/* /usr/share/doc/openssl-1.1.1d
fi

popd \
  && rm -rf /tmp/openssl
