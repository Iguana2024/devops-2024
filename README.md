<p align="center"> ![Vagrant Logo](/images/vagrant-logo.png) </p>
<p align="center"># VAGRANT </p>
> Configure your VM instances quickly and securely using Vagrant.

This Vagrant project sets up a development environment within VirtualBox, creating three Ubuntu 20.04 machines. It's tailored for managing security credentials, enabling users to log in, and virtual machines to communicate securely over SSH. Additionally, it's equipped to perform security audits with the rkHunter tool.

## Requirements

Before diving in, make sure you've got the necessary tools:

- **Vagrant**: Grab the latest version of Vagrant from [here](https://www.vagrantup.com/downloads.html).
- **VirtualBox**: VirtualBox is our go-to provider. Download it from [VirtualBox's site](https://www.virtualbox.org/wiki/Downloads).
- **Git**: You'll need Git for version control. If you haven't yet, download it from [Git's official site](https://git-scm.com/downloads).

## :wrench: Installation and Preparation

1. Clone the Repository:
    ```
    git clone https://github.com/Iguana2024/devops-2024.git
    cd devops-2024
    ```

2. Generate rsa key pair (The keys must be in format `username_rsa` and `username.pub`):
    ```
    ssh-keygen -t rsa -b 4096
    ```

3. Place public key in `public_keys` directory and for private key, create `private_keys` directory.

4. After everything is set up, navigate back to the root directory and launch the virtual machines:
    ```shell
    vagrant up
    ```

## Common Problems

If you encounter the following message:

![Problem1](/images/problem1.png)

Be sure to type in the command:
    ```
    ssh-keygen -R ip_of_the_machine
    ```

