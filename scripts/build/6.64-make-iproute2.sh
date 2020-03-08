#!/bin/bash
set -e

# 6.64. IPRoute2-5.5.0
# The IPRoute2 package contains programs for basic and advanced IPV4-based networking.

echo "Building IPRoute2..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 14 MB"

tar -xf /sources/iproute2-*.tar.* -C /tmp/ \
  && mv /tmp/iproute2-* /tmp/iproute2 \
  && pushd /tmp/iproute2

sed -i /ARPD/d Makefile
rm -fv man/man8/arpd.8

# It is also necessary to disable building two modules:
sed -i 's/.m_ipt.o//' tc/Makefile

# Compile the package:
make -j"$JOB_COUNT"

# Install the package:
make DOCDIR=/usr/share/doc/iproute2-4.15.0 install

popd \
  && rm -rf /tmp/iproute2
