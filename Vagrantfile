Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  
  network_subnet = "192.168.56."
  
  # Assuming provision.sh is in the same directory as the Vagrantfile
  provision_script_path = "provision.sh" 

  (1..3).each do |i|
    config.vm.define "vm#{i}" do |vm|
      vm.vm.hostname = "sftp-server-#{i}"
      vm.vm.network "private_network", ip: "#{network_subnet}10#{i}"

      vm.vm.provider "virtualbox" do |vb|
        vb.cpus = 1
        vb.memory = 2048
      end
      
      # Provisioning to copy public keys to authorized_keys
      vm.vm.provision "shell", inline: <<-SHELL
        # Ensure the SSH directory exists
        mkdir -p /home/vagrant/.ssh
        
        # Set permissions for the SSH directory
        chmod 700 /home/vagrant/.ssh
        
        # Copy keys from public_keys folder to the authorized_keys file
        cat /vagrant/public_keys/* >> /home/vagrant/.ssh/authorized_keys
        
        # Ensure correct permissions on authorized_keys
        chmod 600 /home/vagrant/.ssh/authorized_keys
        
        # Ensure the owner is correct, which should be 'vagrant' for the default Vagrant setup
        chown -R vagrant:vagrant /home/vagrant/.ssh
      SHELL

      # Run provision.sh script
      vm.vm.provision "shell", path: provision_script_path, args: ["$(hostname -I | cut -d' ' -f1)"]

      # Configure cron job
      vm.vm.provision "shell", inline: <<-SHELL
  # Define the cron job command with the correct path and dynamically get the IP address
  CRON_JOB="*/5 * * * * /vagrant/#{provision_script_path} \$(hostname -I | cut -d' ' -f1)"

  # Remove any existing cron job that might have been set from this script to avoid duplicates
  (crontab -u vagrant -l | grep -v -F '/vagrant/#{provision_script_path}' | crontab -u vagrant -)

  # Add the new cron job to the vagrant user's crontab
  (echo "$CRON_JOB" ; crontab -u vagrant -l 2>/dev/null) | crontab -u vagrant -
SHELL
    end
  end
end
