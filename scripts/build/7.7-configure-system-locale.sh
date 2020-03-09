#!/bin/bash
set -e
echo "Configure system locale..."

# 7.7. Configuring the System Locale 
localectl set-locale LANG="$LANG"