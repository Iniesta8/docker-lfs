#!/bin/bash
set -e

# 5.24. Gettext-0.20.1
# The Gettext package contains utilities for internationalization and
# localization. These allow programs to be compiled with NLS
# (Native Language Support), enabling them to output messages in the
# user's native language.

echo "Building gettext..."
echo "Approximate build time: 1.6 SBU"
echo "Required disk space: 300 MB"

tar -xf gettext-*.tar.* -C /tmp/ \
  && mv /tmp/gettext-* /tmp/gettext \
  && pushd /tmp/gettext

./configure --disable-shared

make -j"$JOB_COUNT"

cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /tools/bin

popd \
  && rm -rf /tmp/gettext
