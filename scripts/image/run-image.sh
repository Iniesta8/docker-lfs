#!/bin/bash
set -e
echo "Start building bootable image..."

pushd /tmp
mkdir isolinux

sh /tools/1-create-ramdisk.sh
sh /tools/2-build-iso.sh

rm -rf isolinux
popd
