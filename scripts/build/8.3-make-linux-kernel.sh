#!/bin/bash
set -e

# 8.3. Linux-5.5.3
# The Linux package contains the Linux kernel. 

echo "Building linux kernel..."
echo "Approximate build time: 4.4 - 66.0 SBU (typically about 6 SBU)"
echo "Required disk space: 960 - 4250 MB (typically about 1100 MB)"

tar -xf /sources/linux-*.tar.* -C /tmp/ \
  && mv /tmp/linux-* /tmp/linux \
  && pushd /tmp/linux

# Prepare for compilation by running the following command:
make mrproper

# Copy premade config
# manually configure by: make menuconfig
cp /tools/kernel.config .config

# Build kernel
make -j"$JOB_COUNT"

# Install modules
make modules_install

# Copy kernel image
cp -iv arch/x86/boot/bzImage /boot/vmlinuz-5.5.3-lfs-9.1-systemd

# Copy symbols
cp -iv System.map /boot/System.map-5.5.3

# Copy original configuration
cp -iv .config /boot/config-5.5.3

# Install documentation
if [ "$LFS_DOCS" -eq 1 ]; then
  install -d /usr/share/doc/linux-5.5.3
  cp -r Documentation/* /usr/share/doc/linux-5.5.3
fi

# 8.3.2. Configuring Linux Module Load Order
install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

popd \
  && rm -rf /tmp/linux
