#!/bin/bash
set -e

# 6.35. Bash-5.0
# The Bash package contains the Bourne-Again SHell.

echo "Building bash..."
echo "Approximate build time: 1.9 SBU"
echo "Required disk space: 62 MB"

tar -xf /sources/bash-*.tar.gz -C /tmp/ \
  && mv /tmp/bash-* /tmp/bash \
  && pushd /tmp/bash

# Incorporate some upstream fixes:
patch -Np1 -i /sources/bash-5.0-upstream_fixes-1.patch

# Prepare Bash for compilation:
./configure --prefix=/usr                    \
            --docdir=/usr/share/doc/bash-5.0 \
            --without-bash-malloc            \
            --with-installed-readline

# Compile the package:
make

# Run tests
if [ $LFS_TEST -eq 1 ]; then
  # To prepare the tests, ensure that the nobody user can write to the sources tree:
  chown -Rv nobody .
  # Now, run the tests as the nobody user:
  su nobody -s /bin/bash -c "PATH=$PATH HOME=/home make tests"
fi

# Install the package and move the main executable to /bin:
make install
mv -vf /usr/bin/bash /bin

popd \
  && rm -rf /tmp/bash
