#!/bin/bash
set -e

# 6.77. E2fsprogs-1.45.5
# The E2fsprogs package contains the utilities for handling the ext2 file system.
# It also supports the ext3 and ext4 journaling file systems.

echo "Building e2fsprogs..."
echo "Approximate build time: 3.3 SBU"
echo "Required disk space: 58 MB"

tar -xf /sources/e2fsprogs-*.tar.gz -C /tmp/ \
  && mv /tmp/e2fsprogs-* /tmp/e2fsprogs \
  && pushd /tmp/e2fsprogs

mkdir -v build \
  && cd build

# Prepare E2fsprogs for compilation:
../configure --prefix=/usr           \
             --bindir=/bin           \
             --with-root-prefix=""   \
             --enable-elf-shlibs     \
             --disable-libblkid      \
             --disable-libuuid       \
             --disable-uuidd         \
             --disable-fsck

# Compile the package:
make

echo "e2fsprogs test skipped due to high memory attempt."
# Test the results
# if [ $LFS_TEST -eq 1 ]; then
#     make  check || true
# fi

# Install the package:
make install

chmod -v u+w /usr/lib/{libcom_err,libe2p,libext2fs,libss}.a
gunzip -v /usr/share/info/libext2fs.info.gz
install-info --dir-file=/usr/share/info/dir /usr/share/info/libext2fs.info

# Create and install some additional documentation
if [ $LFS_DOCS -eq 1 ]; then
  makeinfo -o      doc/com_err.info ../lib/et/com_err.texinfo
  install -v -m644 doc/com_err.info /usr/share/info
  install-info --dir-file=/usr/share/info/dir /usr/share/info/com_err.info
fi

popd \
  && rm -rf /tmp/e2fsprogs
