#!/bin/bash
set -e
echo "Downloading toolchain.."

pushd $LFS/sources

case "$FETCH_TOOLCHAIN_MODE" in
  "0")
    echo "Downloading LFS packages.."
    echo "Getting wget-list.."
    wget --timestamping http://www.linuxfromscratch.org/lfs/view/9.1-systemd/wget-list

    echo "Getting packages.."
    wget --timestamping --continue --input-file=wget-list

    echo "Getting md5.."
    wget --timestamping http://www.linuxfromscratch.org/lfs/view/9.1-systemd/md5sums

    echo "Check hashes.."
    md5sum -c md5sums
    ;;
  # "1")
  #   echo "Assume toolchain from host is already placed in sources folder"
  #   ;;
  # "2")
  #   wget --timestamping https://github.com/reinterpretcat/lfs/releases/download/v8.2.0/toolchain.tar.gz
  #   tar -xvf toolchain.tar.gz
  #   rm toolchain.tar.gz
  #   ;;
  *)
    echo "Undefined way to get toolchain!"
    false
    ;;
esac

popd
