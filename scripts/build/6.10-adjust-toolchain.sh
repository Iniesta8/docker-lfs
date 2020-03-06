#!/bin/bash
set -e

echo "Adjusting toolchain..."

# 6.10. Adjusting the Toolchain
# First, backup the /tools linker, and replace it with the adjusted linker
# we made in chapter 5. We'll also create a link to its counterpart in
# /tools/$(uname -m)-pc-linux-gnu/bin:
mv -v /tools/bin/{ld,ld-old}
mv -v /tools/$(uname -m)-pc-linux-gnu/bin/{ld,ld-old}
mv -v /tools/bin/{ld-new,ld}
ln -sv /tools/bin/ld /tools/$(uname -m)-pc-linux-gnu/bin/ld

# Amend the GCC specs file so that it points to the new dynamic linker:
gcc -dumpspecs | sed -e 's@/tools@@g'                   \
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}' \
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >      \
    `dirname $(gcc --print-libgcc-file-name)`/specs

# Perform check:
echo 'int main(){}' > dummy.c \
  && cc dummy.c -v -Wl,--verbose &> dummy.log \
  && readelf -l a.out | grep ': /lib'

# Additional checks (observe output manually):
grep -o '/usr/lib.*/crt[1in].*succeeded' dummy.log
grep -B1 '^ /usr/include' dummy.log
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
grep "/lib.*/libc.so.6 " dummy.log
grep found dummy.log
# cleanup
rm -v dummy.c a.out dummy.log
