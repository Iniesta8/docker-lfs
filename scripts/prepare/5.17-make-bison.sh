#!/bin/bash
set -e

# 5.17. Bison-3.5.2
# The Bison package contains a parser generator.

echo "Building bison..."
echo "Approximate build time:  0.3 SBU"
echo "Required disk space: 43 MB"

tar -xf bison-*.tar.* -C /tmp/ \
  && mv /tmp/bison-* /tmp/bison \
  && pushd /tmp/bison

./configure --prefix=/tools

make -j"$JOB_COUNT"

if [ "$LFS_TEST" -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/bison
