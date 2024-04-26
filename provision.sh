#!/bin/bash

# Set the IP address passed as a command-line argument
IP_ADDRESS=$(ip addr show enp0s8 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)



# Log start of operation
OUTPUT_FILE="/tmp/output.txt"
echo "Date: $(date +"%Y-%m-%d"), Time: $(date +"%H:%M:%S"), Server Name: $(hostname), IP Address: $IP_ADDRESS" >> "$OUTPUT_FILE"
chmod 777 /tmp/output.txt
# Update the package list
sudo apt-get update

# Install vsftpd and rkhunter
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y rkhunter

# Install OpenSSH Server
sudo apt-get install -y openssh-server

# Configure SSHD for SFTP
echo "Subsystem sftp internal-sftp" | sudo tee /etc/ssh/sshd_config
echo "Match User vagrant" | sudo tee -a /etc/ssh/sshd_config
echo "   ChrootDirectory %h" | sudo tee -a /etc/ssh/sshd_config
echo "   ForceCommand internal-sftp" | sudo tee -a /etc/ssh/sshd_config
echo "   AllowTcpForwarding no" | sudo tee -a /etc/ssh/sshd_config
echo "   X11Forwarding no" | sudo tee -a /etc/ssh/sshd_config
echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config

# Restart SSH to apply the configuration
sudo systemctl restart ssh

# configure firewall rules to allow SSH/SFTP access
sudo ufw allow 22/tcp

# Ensure root login is disabled for SSH
echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config > /dev/null

# Restart SSH service
sudo systemctl restart sshd

# Configure the firewall to allow SFTP connections
sudo ufw allow from any to any port 20,21,10000:10100 proto tcp

# Update, prepare, and check rkhunter
sudo rkhunter --update
sudo rkhunter --propupd
sudo rkhunter --check --checkall


sudo chown -R vagrant:vagrant /home/vagrant

touch /home/vagrant/output.txt
sudo chmod 644 /home/vagrant/output.txt

