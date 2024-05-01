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


sudo ufw allow from any to any port 22 proto tcp


sudo rkhunter --update
sudo rkhunter --propupd
sudo rkhunter --check --checkall



sudo apt install python3

sudo chown -R vagrant:vagrant /home/vagrant
sudo chmod 644 /home/vagrant/output.txt


