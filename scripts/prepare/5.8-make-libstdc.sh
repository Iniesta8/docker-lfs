#!/bin/bash
set -e

# 5.8. Libstdc++ from GCC-9.2.0 
# Libstdc++ is the standard C++ library.
# It is needed to compile C++ code (part of GCC is written in C++),
# but we had to defer its installation when we built gcc-pass1
# because it depends on glibc, which was not yet available in /tools. 

echo "Building libstdc..."
echo "Approximate build time: 0.5 SBU"
echo "Required disk space: 878 MB"

tar -xf gcc-*.tar.* -C /tmp/ \
  && mv /tmp/gcc-* /tmp/gcc \
  && pushd /tmp/gcc

mkdir -v build \
  && cd build

../libstdc++-v3/configure         \
  --host="$LFS_TGT"               \
  --prefix=/tools                 \
  --disable-multilib              \
  --disable-nls                   \
  --disable-libstdcxx-threads     \
  --disable-libstdcxx-pch         \
  --with-gxx-include-dir=/tools/"$LFS_TGT"/include/c++/9.2.0

make -j"$JOB_COUNT"
make install

popd \
  && rm -rf /tmp/gcc
