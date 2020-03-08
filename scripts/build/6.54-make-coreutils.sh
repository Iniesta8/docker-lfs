#!/bin/bash
set -e

# 6.54. Coreutils-8.31
# The Coreutils package contains utilities for showing and setting the basic
# system characteristics.

echo "Building coreutils..."
echo "Approximate build time: 2.3 SBU"
echo "Required disk space: 202 MB"

tar -xf /sources/coreutils-*.tar.* -C /tmp/ \
  && mv /tmp/coreutils-* /tmp/coreutils \
  && pushd /tmp/coreutils

# The following patch fixes a non-compliance and other
# internationalization-related bugs.
patch -Np1 -i /sources/coreutils-8.31-i18n-1.patch

# Suppress a test which on some machines can loop forever:
sed -i '/test.lock/s/^/#/' gnulib-tests/gnulib.mk

# Now prepare Coreutils for compilation:
autoreconf -fiv
FORCE_UNSAFE_CONFIGURE=1 ./configure \
            --prefix=/usr            \
            --enable-no-install-program=kill,uptime

# Compile the package:
make

echo "
Coreutils tests skipped.

Test programs test-getlogin and date-debug are known to fail
in a partially built system environment like the chroot
environment here.
"

## Test the results:
#if [ $LFS_TEST -eq 1 ]; then
#    make NON_ROOT_USERNAME=nobody check-root
#    echo "dummy:x:1000:nobody" >> /etc/group
#    chown -Rv nobody .
#    # test programs test-getlogin and date-debug are known to fail in a partially
#    # built system environment like the chroot environment here
#    su nobody -s /bin/bash \
#          -c "PATH=$PATH make RUN_EXPENSIVE_TESTS=yes check" || true
#    sed -i '/dummy/d' /etc/group
#fi

# Install the package:
make install

# Move programs to the locations specified by the FHS
mv -v /usr/bin/{cat,chgrp,chmod,chown,cp,date,dd,df,echo} /bin
mv -v /usr/bin/{false,ln,ls,mkdir,mknod,mv,pwd,rm} /bin
mv -v /usr/bin/{rmdir,stty,sync,true,uname} /bin
mv -v /usr/bin/chroot /usr/sbin
mv -v /usr/share/man/man1/chroot.1 /usr/share/man/man8/chroot.8
sed -i s/\"1\"/\"8\"/1 /usr/share/man/man8/chroot.8

mv -v /usr/bin/{head,nice,sleep,touch} /bin

popd \
  && rm -rf /tmp/coreutils
