#!/bin/bash
set -e

# 6.8. Man-pages-5.05
# The Man-pages package contains over 2,200 man pages.

echo "Building man pages..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 31 MB"

# 6.8.1. Install Man-pages
tar -xf /sources/man-pages-*.tar.* -C /tmp/ \
  && mv /tmp/man-pages-* /tmp/man-pages \
  && pushd /tmp/man-pages

make -j"$JOB_COUNT" install

popd \
  && rm -rf /tmp/man-pages
