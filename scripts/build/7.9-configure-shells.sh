#!/bin/bash
set -e
echo "Setup shells..."

# 7.9. Creating the /etc/shells File 
cat > /etc/shells <<"EOF"
/bin/sh
/bin/bash
EOF
