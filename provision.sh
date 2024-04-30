#!/bin/bash
       
sudo apt-get update


sudo DEBIAN_FRONTEND=noninteractive apt-get install -y vsftpd rkhunter


sudo tee /etc/vsftpd.conf > /dev/null <<EOF
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


echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config > /dev/null


sudo systemctl restart sshd


sudo ufw allow from any to any port 20,21,10000:10100 proto tcp


sudo rkhunter --update
sudo rkhunter --propupd
sudo rkhunter --check --checkall


sudo bash -c 'curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg'
sudo bash -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" > /etc/apt/sources.list.d/1password.list'
sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22
sudo bash -c 'curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol > /etc/debsig/policies/AC2D62742012EA22/1password.pol'
sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
sudo bash -c 'curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg'
sudo apt update && sudo apt install 1password-cli

sudo apt install python3

sudo chown -R vagrant:vagrant /home/vagrant
sudo chmod 644 /home/vagrant/output.txt
