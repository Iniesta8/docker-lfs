#!/bin/bash
set -e

# 6.31. Iana-Etc-2.30
# The Iana-Etc package provides data for network services and protocols.

echo "Building Iana-Etc..."
echo "Approximate build time: less than 0.1 SBU"
echo "Required disk space: 2.3 MB"

tar -xf /sources/iana-etc-*.tar.* -C /tmp/ \
  && mv /tmp/iana-etc-* /tmp/iana-etc \
  && pushd /tmp/iana-etc

# The following command converts the raw data provided by IANA into the correct
# formats for the /etc/protocols and /etc/services data files:
make -j"$JOB_COUNT"

# Install the package:
make install

popd \
  && rm -rf /tmp/iana-etc
