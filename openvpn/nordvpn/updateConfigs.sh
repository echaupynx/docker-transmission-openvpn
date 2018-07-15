#!/bin/bash

set -e

# If the script is called from elsewhere
cd "${0%/*}"

# Delete everything (not this script though)
find . ! -name '*.sh' -delete

# Get updated configuration zip
curl -kL https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip -o openvpn.zip \
  && unzip -j openvpn.zip && rm openvpn.zip

#move files from folder ovpn_tcp and ovpn_udp, then remove the directory
#mv ./ovpn_tcp/* ./
#mv ./ovpn_udp/* ./
#rmdir ovpn_tcp ovpn_udp

# Ensure linux line endings
#dos2unix *

# Update configs with correct paths
sed -i "s/auth-user-pass/auth-user-pass \/config\/openvpn-credentials.txt/" *.ovpn

# Create symlink for default.ovpn
ln -s nl8.nordvpn.com.tcp.ovpn default.ovpn
