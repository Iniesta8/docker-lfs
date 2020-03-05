#!/bin/bash
set -e
echo "Continue with chroot environment.."

# SKIP remove the "I have no name!" promp
# exec /tools/bin/bash --login +h

# build toolchain
sh /tools/6.5-create-directories.sh
sh /tools/6.6-create-essentials.sh
sh /tools/6.7-make-linux-api-headers.sh
sh /tools/6.8-make-man-pages.sh
sh /tools/6.9-make-glibc.sh
sh /tools/6.10-adjust-toolchain.sh
sh /tools/6.11-make-zlib.sh
sh /tools/6.12-make-file.sh
sh /tools/6.13-make-readline.sh
sh /tools/6.14-make-m4.sh
sh /tools/6.15-make-bc.sh
sh /tools/6.16-make-binutils.sh
sh /tools/6.17-make-gmp.sh
sh /tools/6.18-make-mpfr.sh
sh /tools/6.19-make-mpc.sh
sh /tools/6.20-make-gcc.sh
sh /tools/6.21-make-bzip2.sh
sh /tools/6.22-make-pkg-config.sh
sh /tools/6.23-make-ncurses.sh
sh /tools/6.24-make-attr.sh
sh /tools/6.25-make-acl.sh
sh /tools/6.26-make-libcap.sh
sh /tools/6.27-make-sed.sh
sh /tools/6.28-make-shadow.sh
sh /tools/6.29-make-psmisc.sh
sh /tools/6.30-make-iana-etc.sh
sh /tools/6.31-make-bison.sh
sh /tools/6.32-make-flex.sh
sh /tools/6.33-make-grep.sh
sh /tools/6.34-make-bash.sh

# SKIP switching to built bash
#exec /bin/bash --login +h

sh /tools/6.35-make-libtool.sh
sh /tools/6.36-make-gdbm.sh
sh /tools/6.37-make-gperf.sh
sh /tools/6.38-make-expat.sh
sh /tools/6.39-make-inetutils.sh
sh /tools/6.40-make-perl.sh
sh /tools/6.41-make-xml-parser.sh
sh /tools/6.42-make-intltool.sh
sh /tools/6.43-make-autoconf.sh
sh /tools/6.44-make-automake.sh
sh /tools/6.45-make-xz.sh
sh /tools/6.46-make-kmod.sh
sh /tools/6.47-make-gettext.sh
sh /tools/6.48-make-libelf.sh
sh /tools/6.49-make-libffi.sh
sh /tools/6.50-make-openssl.sh
sh /tools/6.51-make-python.sh
sh /tools/6.52-make-ninja.sh
sh /tools/6.53-make-meson.sh
sh /tools/6.54-make-procps-ng.sh
sh /tools/6.55-make-e2fsprogs.sh
sh /tools/6.56-make-coreutils.sh
sh /tools/6.57-make-check.sh
sh /tools/6.58-make-diffutils.sh
sh /tools/6.59-make-gawk.sh
sh /tools/6.60-make-findutils.sh
sh /tools/6.61-make-groff.sh
sh /tools/6.62-make-grub.sh
sh /tools/6.63-make-less.sh
sh /tools/6.64-make-gzip.sh
sh /tools/6.65-make-iproute2.sh
sh /tools/6.66-make-kbd.sh
sh /tools/6.67-make-libpipeline.sh
sh /tools/6.68-make-make.sh
sh /tools/6.69-make-patch.sh
sh /tools/6.70-make-sysklogd.sh
sh /tools/6.71-make-sysvinit.sh
sh /tools/6.72-make-eudev.sh
sh /tools/6.73-make-util-linux.sh
sh /tools/6.74-make-man-db.sh
sh /tools/6.75-make-tar.sh
sh /tools/6.76-make-texinfo.sh
sh /tools/6.77-make-vim.sh
sh /tools/6.79-strip.sh
sh /tools/6.80-clean.sh

exit
