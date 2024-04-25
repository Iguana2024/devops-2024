Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  
  network_subnet = "192.168.56."
  
  (1..3).each do |i|
    config.vm.define "vm#{i}" do |vm|
      vm.vm.hostname = "sftp-server-#{i}"
      vm.vm.network "private_network", ip: "#{network_subnet}10#{i}"

      vm.vm.provider "virtualbox" do |vb|
        vb.cpus = 1
        vb.memory = 2048
      end
      
      # Provisioning to setup users and distribute SSH keys
      vm.vm.provision "shell", inline: <<-SHELL
        for key_file in /vagrant/public_keys/*; do
          username=$(basename $key_file | sed 's/\\.pub$//')  

          if ! id $username &>/dev/null; then
            adduser --disabled-password --gecos "" $username
          fi

          mkdir -p /home/$username/.ssh
          chmod 700 /home/$username/.ssh
          touch /home/$username/.ssh/authorized_keys
          chmod 600 /home/$username/.ssh/authorized_keys

          cat $key_file >> /home/$username/.ssh/authorized_keys
          cat $key_file >> /home/vagrant/.ssh/authorized_keys

          cp /vagrant/private_keys/belichemko_rsa /home/$username/.ssh/id_rsa
          cp /vagrant/private_keys/belichemko_rsa /home/vagrant/.ssh/id_rsa
          chmod 600 /home/$username/.ssh/id_rsa
          chmod 600 /home/vagrant/.ssh/id_rsa

          chown -R $username:$username /home/$username/.ssh
        done

        chown -R vagrant:vagrant /home/vagrant/.ssh
        chmod +x /vagrant/crontab.sh
        
        (sudo -u vagrant crontab -l 2>/dev/null; echo "* * * * * /bin/bash /vagrant/crontab.sh > /vagrant/output.log 2>&1") | sudo -u vagrant crontab -
        (sudo -u vagrant crontab -l 2>/dev/null; echo "*/5 * * * * /usr/bin/python3 /vagrant/report.py") | sudo -u vagrant crontab -
      SHELL

      vm.vm.provision "shell", path: "/vagrant/provision.sh", privileged: true

      vm.vm.provision "shell", inline: <<-SHELL
      chown -R vagrant:vagrant /home/vagrant/
      SHELL
    end
  end
end
