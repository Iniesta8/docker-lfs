#!/bin/bash
set -e
echo "Setup systemd..."

# 7.10.2. Disabling Screen Clearing at Boot Time
mkdir -pv /etc/systemd/system/getty@tty1.service.d

cat > /etc/systemd/system/getty@tty1.service.d/noclear.conf << EOF
[Service]
TTYVTDisallocate=no
EOF
