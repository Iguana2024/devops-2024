<p align="left">
  <img src="/images/vagrant-logo.png" alt="Vagrant Logo">
</p>


> Configure your VM instances quickly and securely using Vagrant.

## Description
The project involves deploying three virtual machines with installed SFTP servers, as well as configuring security and conducting system auditing using rkhunter. Each machine has key-based access, and scheduled Bash and Python tasks are implemented for automatic creation of files on neighboring SFTP servers and log analysis.

## Preset
You need to create directory `private_keys` manually and set you generated private key there.

## Structure and Code

The project consists of four main files and two directories, organized as follows:

### Files

1. **Vagrantfile**  
   Configuration file for Vagrant, used to set up and provision the virtual development environment.
   Replace `belichemko_rsa` on line 33 and 34 with appropriate name of your private key.
2. **crontas.sh**  
   Shell script that creates logs on other 2 machines.

3. **provision.sh**  
   Script executed by Vagrant upon setting up the VM, used to install and configure necessary software and environments.

4. **report.py**  
   Python script that generates report from the logs.

### Directories

1. **public_keys**  
   Store your public SSH keys here. Each key should be saved in the format `username.pub`.

2. **private_keys**  
   Directory for storing private SSH keys. It is crucial to secure this directory using appropriate permissions and security measures.




## Requirements

Before diving in, make sure you've got the necessary tools:

- **Vagrant**: Grab the latest version of Vagrant from [here](https://www.vagrantup.com/downloads.html).
- **VirtualBox**: VirtualBox is our go-to provider. Download it from [VirtualBox's site](https://www.virtualbox.org/wiki/Downloads).
- **Git**: You'll need Git for version control. If you haven't yet, download it from [Git's official site](https://git-scm.com/downloads).

## :wrench: Runbook

1. Clone the Repository
    ```
    git clone https://github.com/Iguana2024/devops-2024.git
    cd devops-2024
    ```

2. Generate rsa key pair (The public key must be in format `username.pub`)
    ```
    ssh-keygen -t rsa -b 4096
    ```

3. Place public key in `public_keys` directory and for private key, create `private_keys` directory

4. After everything is set up, navigate back to the root directory and launch the virtual machines
    ```
    vagrant up
    ```

5. After machines are up try to login and ckeck if everything is working:
    ```
    ssh -i /private_keys/your_ssh_key username@ip_of_the_machine
    cd /vagrant
    ls -la #check for the file report.txt
    cat report.txt # you should see the name of the host as well as the ip of it and count of logs
    ```

## Common Problems

If you encounter the following message

![Problem1](/images/problem1.png)

Be sure to type in the command
    ```
    ssh-keygen -R ip_of_the_machine
    ```

