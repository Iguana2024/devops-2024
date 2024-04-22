#!/bin/bash
IP_ADDRESS=$1

# Update and install necessary packages
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y vsftpd rkhunter

# Setup vsftpd for SFTP
sudo bash -c "cat > /etc/vsftpd.conf" << EOF
listen=NO
listen_ipv6=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES
allow_writeable_chroot=YES
pasv_enable=Yes
pasv_min_port=10000
pasv_max_port=10100
EOF

sudo systemctl restart vsftpd

# Setup SSH Key-Based Authentication
mkdir -p $HOME/.ssh
echo "YOUR_SSH_PUBLIC_KEY" > $HOME/.ssh/authorized_keys
chmod 700 $HOME/.ssh
chmod 600 $HOME/.ssh/authorized_keys

# Configure rkhunter
sudo rkhunter --update
sudo rkhunter --propupd
sudo rkhunter --check --sk

# Ensure the IP address is recorded (may be useful for logs or audits)
echo "$IP_ADDRESS" > /tmp/vm_ip_address.txt