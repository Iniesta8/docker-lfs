#!/bin/bash
set -e

echo "Creating ramdisk..."

LOOP_DIR="$PWD"/"$LOOP"
RAMDISK="$PWD"/ramdisk

# Create yet another loop device if not exist
[ -e "$LOOP" ] || mknod "$LOOP" b 7 0

# Create ramdisk file of IMAGE_SIZE
dd if=/dev/zero of="$RAMDISK" bs=1k count="$IMAGE_SIZE"

# Plug off any virtual fs from loop device
losetup -d "$LOOP" || true

# Associate it with ${LOOP}
losetup $LOOP "$RAMDISK"

# Make an ext2 filesystem
mkfs.ext4 -q -m 0 "$LOOP" "$IMAGE_SIZE"

# Ensure loop2 directory
[ -d "$LOOP_DIR" ] || mkdir -pv "$LOOP_DIR"

# Mount it
mount "$LOOP" "$LOOP_DIR"
rm -rf "$LOOP_DIR"/lost+found

# Copy LFS system without build artifacts
pushd $INITRD_TREE
cp -dpR $(ls -A | grep -Ev "sources|tools") "$LOOP_DIR"
popd

# Show statistics
df "$LOOP_DIR"

echo "Compressing system ramdisk image..."
bzip2 -c "$RAMDISK" > "$IMAGE"

# Copy compressed image to /tmp dir
cp -v "$IMAGE" .

# Cleanup
umount "$LOOP_DIR"
losetup -d "$LOOP"
rm -rf "$LOOP_DIR"
rm -f "$RAMDISK"
