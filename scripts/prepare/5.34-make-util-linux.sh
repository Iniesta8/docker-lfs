#!/bin/bash

# 5.34. Util-linux-2.35.1
# The Util-linux package contains miscellaneous utility programs.

set -e

echo "Building util-linux..."
echo "Approximate build time: 0.9 SBU"
echo "Required disk space: 154 MB"

tar -xf util-linux-*.tar.xz -C /tmp/ \
  && mv /tmp/util-linux-* /tmp/util-linux \
  && pushd /tmp/util-linux \
  && ./configure --prefix=/tools    \
     --without-python               \
     --disable-makeinstall-chown    \
     --without-systemdsystemunitdir \
     --without-ncurses              \
     PKG_CONFIG=""                  \
  && make \
  && make install \
  && popd \
  && rm -rf /tmp/util-linux
