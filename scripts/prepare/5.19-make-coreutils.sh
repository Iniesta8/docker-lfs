#!/bin/bash

# 5.19. Coreutils-8.31
# The Coreutils package contains utilities for showing and setting
# the basic system characteristics. 

set -e

echo "Building Coreutils..."
echo "Approximate build time: 0.7 SBU"
echo "Required disk space: 157 MB"

tar -xf coreutils-*.tar.xz -C /tmp/ \
  && mv /tmp/coreutils-* /tmp/coreutils \
  && pushd /tmp/coreutils \
  && ./configure --prefix=/tools --enable-install-program=hostname \
  && make \
  && if [ $LFS_TEST -eq 1 ]; then make RUN_EXPENSIVE_TESTS=yes check || true; fi \
  && make install \
  && popd \
  && rm -rf /tmp/coreutils
