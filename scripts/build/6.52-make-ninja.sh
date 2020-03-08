#!/bin/bash
set -e

# 6.52. Ninja-1.10.0
# Ninja is a small build system with a focus on speed.

echo "Building Ninja..."
echo "Approximate build time: 0.3 SBU"
echo "Required disk space: 89 MB"

tar -xf /sources/ninja-*.tar.* -C /tmp/ \
  && mv /tmp/ninja-* /tmp/ninja \
  && pushd /tmp/ninja

# Add the capability to use the environment variable NINJAJOBS:
sed -i '/int Guess/a \
  int   j = 0;\
  char* jobs = getenv( "NINJAJOBS" );\
  if ( jobs != NULL ) j = atoi( jobs );\
  if ( j > 0 ) return j;\
' src/ninja.cc

# Build Ninja:
python3 configure.py --bootstrap

# Test the results:
if [ $LFS_TEST -eq 1 ]; then
  ./ninja ninja_test
  ./ninja_test --gtest_filter=-SubprocessTest.SetWithLots
fi

# Install the package:
install -vm755 ninja /usr/bin/
install -vDm644 misc/bash-completion /usr/share/bash-completion/completions/ninja
install -vDm644 misc/zsh-completion  /usr/share/zsh/site-functions/_ninja

# cleanup
popd \
  && rm -rf /tmp/python
