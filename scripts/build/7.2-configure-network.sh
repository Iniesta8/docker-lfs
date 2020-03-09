#!/bin/bash
set -e
echo "Setup general network configuration..."

# 7.2.1.1 Network Device Naming
cat > /etc/systemd/network/10-ether0.link << "EOF"
[Match]
# Change the MAC address as appropriate for your network device
MACAddress="$NET_DEVICE_MAC"

[Link]
Name="$NET_DEVICE_NAME"
EOF

# 7.2.1.3 DHCP Configuration
cat > /etc/systemd/network/10-eth-dhcp.network << "EOF"
[Match]
Name="$NET_DEVICE_NAME"

[Network]
DHCP=ipv4

[DHCP]
UseDomains=true
EOF

# 7.2.2.1 systemd-resolved Configuration
ln -sfv /run/systemd/resolve/resolv.conf /etc/resolv.conf

# 7.2.2.2 Static resolv.conf Configuration
cat > /etc/resolv.conf <<"EOF"
# Begin /etc/resolv.conf

nameserver 8.8.8.8
nameserver 8.8.4.4

# End /etc/resolv.conf
EOF

# 7.2.3. Configuring the system hostname 
echo "lfs" > /etc/hostname

# 7.2.4. Customizing the /etc/hosts File 
cat > /etc/hosts << "EOF"
# Begin /etc/hosts

127.0.0.1 localhost
127.0.1.1 <FQDN> <HOSTNAME>
::1       localhost ip6-localhost ip6-loopback
ff02::1   ip6-allnodes
ff02::2   ip6-allrouters

# End /etc/hosts
EOF
