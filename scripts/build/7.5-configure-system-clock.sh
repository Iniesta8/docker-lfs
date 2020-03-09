#!/bin/bash
set -e
echo "Setup general time/date configuration..."

# 7.5. Configuring the system clock
cat > /etc/adjtime << "EOF"
0.0 0 0.0
0
LOCAL
EOF
