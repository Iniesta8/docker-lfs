#!/bin/bash

set -e

echo "Cleanup..."

# Unmount VFS
umount -v $LFS/dev/pts
umount -v $LFS/dev
umount -v $LFS/run
umount -v $LFS/proc
umount -v $LFS/sys

# Unmount LFS
umount -v $LFS/usr
umount -v $LFS/home
umount -v $LFS
