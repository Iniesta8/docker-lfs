#!/bin/bash
set -e

# 5.15. Ncurses-6.2
# The Ncurses package contains libraries for terminal-independent
# handling of character screens. 

echo "Building Ncurses..."
echo "Approximate build time:  0.6 SBU"
echo "Required disk space: 41 MB"

tar -xf ncurses-*.tar.* -C /tmp/ \
  && mv /tmp/ncurses-* /tmp/ncurses \
  && pushd /tmp/ncurses

sed -i s/mawk// configure

./configure --prefix=/tools \
            --with-shared   \
            --without-debug \
            --without-ada   \
            --enable-widec  \
            --enable-overwrite

make -j"$JOB_COUNT"

make install
ln -s libncursesw.so /tools/lib/libncurses.so

popd \
  && rm -rf /tmp/ncurses
