#!/bin/bash
set -e

# 6.53. Meson-0.53.1
# Meson is an open source build system meant to be both extremely fast, and,
# even more importantly, as user friendly as possible.

echo "Building Meson..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 31 MB"

tar -xf /sources/meson-*.tar.* -C /tmp/ \
  && mv /tmp/meson-* /tmp/meson \
  && pushd /tmp/meson

# Compile Meson:
python3 setup.py build

# Install the package:
python3 setup.py install --root=dest
cp -rv dest/* /

popd \
  && rm -rf /tmp/meson
