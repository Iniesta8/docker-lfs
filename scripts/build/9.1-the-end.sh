#!/bin/bash
set -e

# 9.1. The End

echo "Finalize LFS configuration.."

# LFS version file
echo 9.1-systemd > /etc/lfs-release

# LSB version file
cat > /etc/lsb-release << "EOF"
DISTRIB_ID="Linux From Scratch"
DISTRIB_RELEASE="9.1-systemd"
DISTRIB_CODENAME="$DISTRIB_CODENAME"
DISTRIB_DESCRIPTION="Linux From Scratch"
EOF

# OS-Release version file
cat > /etc/os-release << "EOF"
NAME="Linux From Scratch"
VERSION="9.1-systemd"
ID=lfs
PRETTY_NAME="Linux From Scratch 9.1-systemd"
VERSION_CODENAME="$DISTRIB_CODENAME"
EOF

# Define empty password for root
cat > /etc/shadow << "EOF"
root::12699:0:::::
EOF
