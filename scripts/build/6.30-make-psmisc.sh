#!/bin/bash
set -e

# 6.30. Psmisc-23.2
# The Psmisc package contains programs for displaying information about running processes.

echo "Building Psmisc..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 4.6 MB"

tar -xf /sources/psmisc-*.tar.xz -C /tmp/ \
  && mv /tmp/psmisc-* /tmp/psmisc \
  && pushd /tmp/psmisc

# Prepare Psmisc for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Install the package:
make install

# Finally, move the killall and fuser programs to the location specified by the FHS:
mv -v /usr/bin/fuser   /bin
mv -v /usr/bin/killall /bin

popd \
  && rm -rf /tmp/psmisc
