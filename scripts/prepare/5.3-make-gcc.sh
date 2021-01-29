#!/bin/bash
set -e

# 5.3. GCC-10.2.0 - Pass 1
# The GCC package contains the GNU compiler collection,
# which includes the C and C++ compilers. 

echo "Building gcc (pass 1)..."
echo "Approximate build time: 11 SBU"
echo "Required disk space: 3.8 GB"

tar -xf gcc-*.tar.* -C /tmp/ \
  && mv /tmp/gcc-* /tmp/gcc \
  && pushd /tmp/gcc

tar -xf "$LFS"/sources/mpfr-*.tar.* \
  && mv -v mpfr-* mpfr
tar -xf "$LFS"/sources/gmp-*.tar.* \
  && mv -v gmp-* gmp
tar -xf "$LFS"/sources/mpc-*.tar.* \
  && mv -v mpc-* mpc

case $(uname -m) in
     x86_64) sed -e '/m64=/s/lib64/lib/' -i.orig gcc/config/i386/t-linux64 ;;
esac

mkdir -v build \
  && cd build \

../configure                                     \
  --target="$LFS_TGT"                            \
  --prefix=/tools                                \
  --with-glibc-version=2.11                      \
  --with-sysroot="$LFS"                          \
  --with-newlib                                  \
  --without-headers                              \
  --enable-initfini-array                        \
  --disable-nls                                  \
  --disable-shared                               \
  --disable-multilib                             \
  --disable-decimal-float                        \
  --disable-threads                              \
  --disable-libatomic                            \
  --disable-libgomp                              \
  --disable-libquadmath                          \
  --disable-libssp                               \
  --disable-libvtv                               \
  --disable-libstdcxx                            \
  --enable-languages=c,c++

make -j"$JOB_COUNT"
make install

cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
    "$(dirname "$("$LFS_TGT"-gcc -print-libgcc-file-name)")"/install-tools/include/limits.h

popd \
  && rm -rf /tmp/gcc
