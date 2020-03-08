#!/bin/bash
set -e

# 6.15. Readline-8.0
# The Readline package is a set of libraries that offers command-line editing
# and history capabilities.

echo "Building readline..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 15 MB"

tar -xf /sources/readline-*.tar.* -C /tmp/ \
  && mv /tmp/readline-* /tmp/readline \
  && pushd /tmp/readline

# Reinstalling Readline will cause the old libraries to be moved to <libraryname>.old.
# While this is normally not a problem, in some cases it can trigger a linking bug in
# ldconfig. This can be avoided by issuing the following two seds:
sed -i '/MV.*old/d' Makefile.in
sed -i '/{OLDSUFF}/c:' support/shlib-install

# Prepare Readline for compilation:
./configure --prefix=/usr    \
            --disable-static \
            --docdir=/usr/share/doc/readline-8.0

# Compile the package:
make -j"$JOB_COUNT" SHLIB_LIBS="-L/tools/lib -lncursesw"

# Install the package:
make SHLIB_LIBS="-L/tools/lib -lncurses" install

# Move the dynamic libraries to a more appropriate location and fix up some
# permissions and symbolic links:
mv -v /usr/lib/lib{readline,history}.so.* /lib
chmod -v u+w /lib/lib{readline,history}.so.*
ln -sfv ../../lib/"$(readlink /usr/lib/libreadline.so)" /usr/lib/libreadline.so
ln -sfv ../../lib/"$(readlink /usr/lib/libhistory.so )" /usr/lib/libhistory.so

# Install the documentation:
if [ "$LFS_DOCS" -eq 1 ]; then
    install -v -m644 doc/*.{ps,pdf,html,dvi} /usr/share/doc/readline-8.0
fi

popd \
  && rm -rf /tmp/readline
