#!/bin/bash
set -e

# 6.41. Perl-5.30.1
# The Perl package contains the Practical Extraction and Report Language.

echo "Building perl..."
echo "Approximate build time: 9.2 SBU"
echo "Required disk space: 272 MB"

tar -xf /sources/perl-*.tar.xz -C /tmp/ \
  && mv /tmp/perl-* /tmp/perl \
  && pushd /tmp/perl

# First create a basic /etc/hosts file to be referenced in one of
# Perl's configuration files as well as the optional test suite:
echo "127.0.0.1 localhost $(hostname)" > /etc/hosts

# Use libs installed in system:
export BUILD_ZLIB=False
export BUILD_BZIP2=0

# Configure
sh Configure -des -Dprefix=/usr                 \
                  -Dvendorprefix=/usr           \
                  -Dman1dir=/usr/share/man/man1 \
                  -Dman3dir=/usr/share/man/man3 \
                  -Dpager="/usr/bin/less -isR"  \
                  -Duseshrplib                  \
                  -Dusethreads

# Compile the package:
make

# Test the results (approximately 11 SBU):
if [ $LFS_TEST -eq 1 ]; then make test; fi

# Install the package and clean up:
make install
unset BUILD_ZLIB BUILD_BZIP2

popd \
  && rm -rf /tmp/perl
