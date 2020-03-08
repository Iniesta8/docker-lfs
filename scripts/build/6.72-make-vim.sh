#!/bin/bash
set -e

# 6.72. Vim-8.2.0190
# The Vim package contains a powerful text editor.

echo "Building vim.."
echo "Approximate build time: 1.7 SBU"
echo "Required disk space: 202 MB"

tar -xf /sources/vim-*.tar.* -C /tmp/ \
  && mv /tmp/vim* /tmp/vim \
  && pushd /tmp/vim

# Change default location of the vimrc configuration file to /etc
echo '#define SYS_VIMRC_FILE "/etc/vimrc"' >> src/feature.h

# Prepare Vim for compilation:
./configure --prefix=/usr

# Compile the package:
make -j"$JOB_COUNT"

if [ "$LFS_TEST" -eq 1 ]; then
  chown -Rv nobody .
  su nobody -s /bin/bash -c "LANG=en_US.UTF-8 make -j1 test" &> vim-test.log
fi

# Install the package:
make install

# Create symlink for vi
ln -sv vim /usr/bin/vi
for L in  /usr/share/man/{,*/}man1/vim.1; do
    ln -sv vim.1 "$(dirname $L)"/vi.1
done

ln -sv ../vim/vim82/doc /usr/share/doc/vim-8.2.0190

# 6.72.2. Configuring Vim
cat > /etc/vimrc << "EOF"
" Begin /etc/vimrc

" Ensure defaults are set before customizing settings, not after
source $VIMRUNTIME/defaults.vim
let skip_defaults_vim=1 

set nocompatible
set backspace=2
set mouse=
syntax on
if (&term == "xterm") || (&term == "putty")
  set background=dark
endif

" End /etc/vimrc
EOF
touch ~/.vimrc

popd \
  && rm -rf /tmp/vim
