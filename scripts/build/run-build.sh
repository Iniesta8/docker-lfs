#!/bin/bash
set -e
echo "Running build.."

# prepartion
sh /tools/6.2-prepare-vkfs.sh

# enter and continue in chroot environment with tools
chroot "$LFS" /tools/bin/env -i                 \
  HOME=/root TERM="$TERM" PS1='\u:\w\$ '        \
  PATH=/bin:/usr/bin:/sbin:/usr/sbin:/tools/bin \
  LFS="$LFS" LC_ALL="$LC_ALL"                   \
  LFS_TGT="$LFS_TGT" MAKEFLAGS="$MAKEFLAGS"     \
  LFS_TEST="$LFS_TEST" LFS_DOCS="$LFS_DOCS"     \
  JOB_COUNT="$JOB_COUNT"                        \
  /tools/bin/bash --login +h                    \
  -c "sh /tools/as-chroot-with-tools.sh"

# enter and continue in chroot environment with usr
chroot "$LFS" /usr/bin/env -i                   \
  HOME=/root TERM="$TERM" PS1='\u:\w\$ '        \
  PATH=/bin:/usr/bin:/sbin:/usr/sbin            \
  LFS="$LFS" LC_ALL="$LC_ALL"                   \
  LFS_TGT="$LFS_TGT" MAKEFLAGS="$MAKEFLAGS"     \
  LFS_TEST="$LFS_TEST" LFS_DOCS="$LFS_DOCS"     \
  JOB_COUNT="$JOB_COUNT"                        \
  /bin/bash --login                             \
  -c "sh /tools/as-chroot-with-usr.sh"

# cleanup
sh /tools/9.x-cleanup.sh
