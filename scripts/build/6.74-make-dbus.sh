#!/bin/bash
set -e

# 6.74. D-Bus-1.12.16
# D-Bus is a message bus system, a simple way for applications to talk to
# one another. D-Bus supplies both a system daemon (for events such as
# "new hardware device added" or "printer queue changed") and a
# per-user-login-session daemon (for general IPC needs among user
# applications). Also, the message bus is built on top of a general
# one-to-one message passing framework, which can be used by any two
# applications to communicate directly (without going through the
# message bus daemon).

echo "Building dbus..."
echo "Approximate build time: 0.2 SBU"
echo "Required disk space: 18 MB"

tar -xf /sources/dbus-*.tar.* -C /tmp/ \
  && mv /tmp/dbus-* /tmp/dbus \
  && pushd /tmp/dbus

# Prepare D-Bus for compilation:
./configure --prefix=/usr                       \
            --sysconfdir=/etc                   \
            --localstatedir=/var                \
            --disable-static                    \
            --disable-doxygen-docs              \
            --disable-xml-docs                  \
            --docdir=/usr/share/doc/dbus-1.12.16 \
            --with-console-auth-dir=/run/console

# Compile the package:
make

# Install the package:
make install

# The shared library needs to be moved to /lib, and as a result the .so file
# in /usr/lib will need to be recreated:
mv -v /usr/lib/libdbus-1.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libdbus-1.so) /usr/lib/libdbus-1.so

# Create a symlink, so that D-Bus and systemd can use the same machine-id file:
ln -sfv /etc/machine-id /var/lib/dbus

popd \
  && rm -rf /tmp/dbus
