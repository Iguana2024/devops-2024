#!/bin/bash

# Variables
OUTPUT_FILE="/home/vagrant/output.txt"
REMOTE_USER="vagrant"       
REMOTE_PATH="/home/vagrant/output.txt" 
TEMP_REMOTE_FILE="/home/vagrant/temp_output.txt" 
PYTHON_SCRIPT_SOURCE="/vagrant/report.py"
PYTHON_SCRIPT_DEST="/home/vagrant/report.py"


REMOTE_HOSTS=("192.168.56.101" "192.168.56.102" "192.168.56.103")


MY_IP=$(ip addr show enp0s8 | grep 'inet\b' | awk '{print $2}' | cut -d/ -f1)


echo "Date: $(date +"%Y-%m-%d"), Time: $(date +"%H:%M:%S"), Server Name: $(hostname), IP Address: $MY_IP" >> "$OUTPUT_FILE"


for REMOTE_HOST in "${REMOTE_HOSTS[@]}"; do
    if [ "$REMOTE_HOST" == "$MY_IP" ]; then
        echo "Skipping current host ($MY_IP)"
        continue
    fi

   
    scp -o StrictHostKeyChecking=no "$OUTPUT_FILE" "$REMOTE_USER@$REMOTE_HOST:$TEMP_REMOTE_FILE"
    ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_HOST" "cat $TEMP_REMOTE_FILE >> $REMOTE_PATH && rm $TEMP_REMOTE_FILE"
    
    if [ $? -eq 0 ]; then
        echo "File content successfully appended to remote machine: $REMOTE_HOST."
    else
        echo "Failed to append file content to remote machine: $REMOTE_HOST."
        continue  
    fi

    
    if ssh -o StrictHostKeyChecking=no "$REMOTE_USER@$REMOTE_HOST" "[ ! -f $PYTHON_SCRIPT_DEST ]"; then
        
        scp -o StrictHostKeyChecking=no "$PYTHON_SCRIPT_SOURCE" "$REMOTE_USER@$REMOTE_HOST:$PYTHON_SCRIPT_DEST"
        if [ $? -eq 0 ]; then
            echo "Python script copied successfully to $REMOTE_HOST."
        else
            echo "Failed to copy Python script to $REMOTE_HOST."
        fi
    else
        echo "Python script already exists on $REMOTE_HOST, skipping copy."
    fi
done
