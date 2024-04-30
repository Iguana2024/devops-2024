#!/bin/bash

REMOTE_HOSTS=("192.168.56.101" "192.168.56.102" "192.168.56.103")

MY_IP=$(ip addr show enp0s8 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)

echo "My IP: $MY_IP"

for REMOTE_HOST in "${REMOTE_HOSTS[@]}"; do
    echo "Checking remote host: $REMOTE_HOST"
    if [ "$REMOTE_HOST" == "$MY_IP" ]; then
        echo "Skipping current host ($MY_IP)"
        continue
    fi

    echo "Appending log to $REMOTE_HOST"
    ssh -o StrictHostKeyChecking=no "vagrant@$REMOTE_HOST" "\
        sudo echo 'Date: $(date +"%Y-%m-%d"), Time: $(date +"%H:%M:%S"), Server Name: $(hostname), IP Address: $MY_IP' >> /var/tmp/sftp.log; \
        echo 'Log from $MY_IP appended to /var/tmp/sftp.log on $REMOTE_HOST'"
done
