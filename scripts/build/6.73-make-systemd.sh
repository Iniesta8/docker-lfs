#!/bin/bash
set -e

# 6.73. Systemd-244
# The systemd package contains programs for controlling the startup,
# running, and shutdown of the system. 

echo "Building systemd..."
echo "Approximate build time: 0.6 SBU"
echo "Required disk space: 238 MB"

tar -xf /sources/systemd-*.tar.gz -C /tmp/ \
  && mv /tmp/systemd* /tmp/systemd \
  && pushd /tmp/systemd

# Create a symlink to work around missing xsltproc:
ln -sf /tools/bin/true /usr/bin/xsltproc

# Because we have not yet installed the final version of Util-Linux,
# create links to the libraries in the appropriate location:
for file in /tools/lib/lib{blkid,mount,uuid}.so*; do
  ln -sf "$file" /usr/lib/
done

# Set up the man pages:
tar -xf /sources/systemd-man-pages-244.tar.*

# Remove tests that cannot be built in chroot:
sed '177,$ d' -i src/resolve/meson.build

# Remove an unneeded group, render, from the default udev rules:
sed -i 's/GROUP="render", //' rules.d/50-udev-default.rules.in

# Prepare systemd for compilation:
mkdir -p build \
  && cd       build

PKG_CONFIG_PATH="/usr/lib/pkgconfig:/tools/lib/pkgconfig" \
LANG=en_US.UTF-8                   \
meson --prefix=/usr                \
      --sysconfdir=/etc            \
      --localstatedir=/var         \
      -Dblkid=true                 \
      -Dbuildtype=release          \
      -Ddefault-dnssec=no          \
      -Dfirstboot=false            \
      -Dinstall-tests=false        \
      -Dkmod-path=/bin/kmod        \
      -Dldconfig=false             \
      -Dmount-path=/bin/mount      \
      -Drootprefix=                \
      -Drootlibdir=/lib            \
      -Dsplit-usr=true             \
      -Dsulogin-path=/sbin/sulogin \
      -Dsysusers=false             \
      -Dumount-path=/bin/umount    \
      -Db_lto=false                \
      -Drpmmacrosdir=no            \
      ..

# Compile the package:
LANG=en_US.UTF-8 ninja

# Install the package:
LANG=en_US.UTF-8 ninja install

# Remove an unnecessary symbolic link:
rm -f /usr/bin/xsltproc

# Create the /etc/machine-id file needed by systemd-journald:
systemd-machine-id-setup

# Setup the basic target structure:
systemctl preset-all

# Disable a service that is known to cause problems with systems that use a network
# configuration other than what is provided by systemd-networkd:
systemctl disable systemd-time-wait-sync.service

# Cleanup symbolic links to Util-Linux libraries:
rm -fv /usr/lib/lib{blkid,uuid,mount}.so*

popd \
  && rm -rf /tmp/systemd
