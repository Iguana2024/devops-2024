# VAGRANT
> Configure you VM instances quickly and securely using Vagrant.

This Vagrant project sets up an environment in VirtualBox for 3 machines with Ubuntu 20.04.It also manage security credentials for users to login and virtual machines to communicate with each other via ssh
as well as doing the security audit using rkhuner tool.

## Prerequisites
Before you begin, ensure you have met the following requirements:
- **Vagrant**: Download and install Vagrant from [Vagrant](https://www.vagrantup.com/downloads.html).
- **VirtualBox**: Download and install VirtualBox from [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Alternatively, you can use any other provider that Vagrant supports.
- **Git**: Download and install Git from [Git](https://git-scm.com/downloads).

## Installation
Clone the repo and start the Vagrant environment:

```bash
git clone https://github.com/yourusername/yourprojectname.git
cd yourprojectname
vagrant up
