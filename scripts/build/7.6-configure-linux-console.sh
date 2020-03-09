#!/bin/bash
set -e
echo "Setup linux console configuration..."

# 7.6. Configuring the Linux Console
cat > /etc/vconsole.conf << "EOF"
KEYMAP=de-latin1
FONT=Lat2-Terminus16
EOF