#!/bin/bash
set -e

# 5.12. Expect-5.45.4
# The Expect package contains a program for carrying out
# scripted dialogues with other interactive programs.

echo "Building expect..."
echo "Approximate build time: 0.1 SBU"
echo "Required disk space: 4.0 MB"

tar -xf expect*.tar.* -C /tmp/ \
  && mv /tmp/expect* /tmp/expect \
  && pushd /tmp/expect

cp -v configure{,.orig}
sed 's:/usr/local/bin:/bin:' configure.orig > configure

./configure --prefix=/tools       \
            --with-tcl=/tools/lib \
            --with-tclinclude=/tools/include

make -j$JOB_COUNT

if [ $LFS_TEST -eq 1 ]; then make test; fi

make SCRIPTS="" install

popd \
  && rm -rf /tmp/expect
