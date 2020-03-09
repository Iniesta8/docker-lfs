#!/bin/bash
set -e
echo "Using GRUB to setup the boot process..."

cd /tmp 
grub-mkrescue --output=grub-img.iso 
xorriso -as cdrecord -v dev=/dev/cdrw blank=as_needed grub-img.iso

# Install the GRUB files into /boot/grub and set up the boot track:
grub-install /dev/sda

# Creating the GRUB Configuration File:
cat > /boot/grub/grub.cfg << "EOF"
# Begin /boot/grub/grub.cfg
set default=0
set timeout=5

insmod ext2
set root=(hd0,2)

menuentry "GNU/Linux, Linux 5.5.3-lfs-9.1-systemd" {
        linux   /boot/vmlinuz-5.5.3-lfs-9.1-systemd root=/dev/sda2 ro
}
EOF
