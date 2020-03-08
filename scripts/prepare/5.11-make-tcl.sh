#!/bin/bash
set -e

# 5.11. Tcl-8.6.10
# The Tcl package contains the Tool Command Language. 

echo "Building Tcl..."
echo "Approximate build time: 0.9 SBU"
echo "Required disk space: 72 MB"

tar -xf tcl*-src.tar.* -C /tmp/ \
  && mv /tmp/tcl* /tmp/tcl \
  && pushd /tmp/tcl

cd unix \
  && ./configure --prefix=/tools

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then TZ=UTC make test; fi

make install

chmod -v u+w /tools/lib/libtcl8.6.so

make install-private-headers

ln -sv tclsh8.6 /tools/bin/tclsh

popd \
  && rm -rf /tmp/tcl-core
