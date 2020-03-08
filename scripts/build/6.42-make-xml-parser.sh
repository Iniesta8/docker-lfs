#!/bin/bash
set -e

# 6.42. XML::Parser-2.46
# The XML::Parser module is a Perl interface to James Clark's XML parser, Expat.

echo "Building XML::Parser..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 2.4 MB"

tar -xf /sources/XML-Parser-*.tar.* -C /tmp/ \
  && mv /tmp/XML-Parser-* /tmp/XML-Parser \
  && pushd /tmp/XML-Parser

# Prepare XML::Parser for compilation:
perl Makefile.PL

# Compile the package:
make

# Test the results:
if [ $LFS_TEST -eq 1 ]; then make test; fi

# Install the package:
make install

popd \
  && rm -rf /tmp/XML-Parser
