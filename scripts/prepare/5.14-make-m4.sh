#!/bin/bash
set -e

# 5.14. M4-1.4.18
# The M4 package contains a macro processor.

echo "Building m4..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 20 MB"

tar -xf m4-*.tar.* -C /tmp/ \
  && mv /tmp/m4-* /tmp/m4 \
  && pushd /tmp/m4

sed -i 's/IO_ftrylockfile/IO_EOF_SEEN/' lib/*.c
echo "#define _IO_IN_BACKUP 0x100" >> lib/stdio-impl.h

./configure --prefix=/tools

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make check; fi

make install

popd \
  && rm -rf /tmp/m4
