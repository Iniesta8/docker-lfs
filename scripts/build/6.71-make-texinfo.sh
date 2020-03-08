#!/bin/bash
set -e

# 6.71. Texinfo-6.7
# The Texinfo package contains programs for reading, writing, and converting info pages.

echo "Building texinfo..."
echo "Approximate build time: 0.7 SBU"
echo "Required disk space: 116 MB"

tar -xf /sources/texinfo-*.tar.* -C /tmp/ \
  && mv /tmp/texinfo-* /tmp/texinfo \
  && pushd /tmp/texinfo

# Prepare Texinfo for compilation:
./configure --prefix=/usr --disable-static

# Compile the package:
make -j"$JOB_COUNT"

# Test the results:
if [ "$LFS_TEST" -eq 1 ]; then make check; fi

# Install the package:
make install
make TEXMF=/usr/share/texmf install-tex


# Fix package out of sync issue with the info pages installed on the system
pushd /usr/share/info
rm -v dir
for f in *
  do install-info "$f" dir 2>/dev/null
done
popd

popd \
  && rm -rf /tmp/texinfo
