#!/bin/bash
IP_ADDRESS=$1

# Ensure non-interactive shell environment
export DEBIAN_FRONTEND=noninteractive

# Update the package list
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y vsftpd rkhunter

# Install vsftpd and any other necessary packages
sudo apt-get install -y vsftpd

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

# Restart vsftpd to apply the changes
sudo systemctl restart vsftpd

# Disable root login
echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config > /dev/null

# Restart SSH service
sudo systemctl restart sshd

# Configure the firewall to allow SFTP connections
sudo ufw allow from any to any port 20,21,10000:10100 proto tcp
sudo rkhunter --update
sudo rkhunter --propupd
sudo rkhunter --check --checkall

# Record the IP address of this VM for future reference
echo "$IP_ADDRESS" > /tmp/vm_ip_address.txt