#!/bin/bash
set -e

# 6.27. Ncurses-6.2
# The Ncurses package contains libraries for terminal-independent handling of
# character screens.

echo "Building ncurses..."
echo "Approximate build time: 0.4 SBU"
echo "Required disk space: 43 MB"

tar -xf /sources/ncurses-*.tar.* -C /tmp/ \
  && mv /tmp/ncurses-* /tmp/ncurses \
  && pushd /tmp/ncurses

# Don't install a static library that is not handled by configure:
sed -i '/LIBTOOL_INSTALL/d' c++/Makefile.in

# Prepare Ncurses for compilation:
./configure --prefix=/usr           \
            --mandir=/usr/share/man \
            --with-shared           \
            --without-debug         \
            --without-normal        \
            --enable-pc-files       \
            --enable-widec

# Compile the package:
make -j"$JOB_COUNT"

# Install the package:
make install

# Move the shared libraries to the /lib directory,
# where they are expected to reside:
mv -v /usr/lib/libncursesw.so.6* /lib

# Because the libraries have been moved, one symlink points to a
# non-existent file. Recreate it:
ln -sfv ../../lib/"$(readlink /usr/lib/libncursesw.so)" /usr/lib/libncursesw.so

# Many applications still expect the linker to be able to find
# non-wide-character Ncurses libraries. Trick such applications
# into linking with wide-character libraries by means of
# symlinks and linker scripts:
for lib in ncurses form panel menu ; do
  rm -vf                    /usr/lib/lib${lib}.so
  echo "INPUT(-l${lib}w)" > /usr/lib/lib${lib}.so
  ln -sfv ${lib}w.pc        /usr/lib/pkgconfig/${lib}.pc
done

# Finally, make sure that old applications that look for -lcurses
# at build time are still buildable:
rm -vf                     /usr/lib/libcursesw.so
echo "INPUT(-lncursesw)" > /usr/lib/libcursesw.so
ln -sfv libncurses.so      /usr/lib/libcurses.so

# Install the Ncurses documentation:
if [ "$LFS_DOCS" -eq 1 ]; then
  mkdir -v       /usr/share/doc/ncurses-6.2
  cp -v -R doc/* /usr/share/doc/ncurses-6.2
fi

popd \
  && rm -rf /tmp/ncurses
