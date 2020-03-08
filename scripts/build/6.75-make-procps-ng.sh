#!/bin/bash
set -e

# 6.75. Procps-ng-3.3.15
# The Procps-ng package contains programs for monitoring processes.

echo "Building procps-ng..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 17 MB"

tar -xf /sources/procps-ng-*.tar.* -C /tmp/ \
  && mv /tmp/procps-ng-* /tmp/procps-ng \
  && pushd /tmp/procps-ng

# Prepare procps-ng for compilation:
./configure --prefix=/usr                            \
            --exec-prefix=                           \
            --libdir=/usr/lib                        \
            --docdir=/usr/share/doc/procps-ng-3.3.15 \
            --disable-static                         \
            --disable-kill                           \
            --with-systemd

# Compile the package:
make -j"$JOB_COUNT"

# Test the results:
if [ "$LFS_TEST" -eq 1 ]; then
  sed -i -r 's|(pmap_initname)\\\$|\1|' testsuite/pmap.test/pmap.exp
  sed -i '/set tty/d' testsuite/pkill.test/pkill.exp
  rm testsuite/pgrep.test/pgrep.exp
  make check
fi

# Install the package:
make install
mv -v /usr/lib/libprocps.so.* /lib
ln -sfv ../../lib/"$(readlink /usr/lib/libprocps.so)" /usr/lib/libprocps.so

popd \
  && rm -rf /tmp/procps-ng
