#!/bin/bash
set -e

# 6.60. GRUB-2.04
# The GRUB package contains the GRand Unified Bootloader.

echo "Building grub..."
echo "Approximate build time: 0.8 SBU"
echo "Required disk space: 161 MB"

tar -xf /sources/grub-*.tar.* -C /tmp/ \
  && mv /tmp/grub-* /tmp/grub \
  && pushd /tmp/grub

# Prepare GRUB for compilation:
./configure --prefix=/usr          \
            --sbindir=/sbin        \
            --sysconfdir=/etc      \
            --disable-efiemu       \
            --disable-werror

# Compile the package:
make -j"$JOB_COUNT"

# Install the package:
make install
mv -v /etc/bash_completion.d/grub /usr/share/bash-completion/completions

popd \
  && rm -rf /tmp/grub
