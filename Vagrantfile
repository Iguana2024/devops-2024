Vagrant.configure("2") do |config|

 
  config.vm.define "host1" do |host1|
    host1.vm.box = "bento/ubuntu-20.04"
    host1.vm.hostname = "host1"
    host1.vm.network "public_network", bridge: "Intel(R) Ethernet Controller 1226-V"
    host1.vm.provision "shell", path: "provision.sh"
    
   
  end

  config.vm.define "host2" do |host2|
    host2.vm.box = "bento/ubuntu-20.04"
    host2.vm.hostname = "host2"
    host2.vm.network "public_network", bridge: "Intel(R) Ethernet Controller 1226-V"
    host2.vm.provision "shell", path: "provision.sh"
    

  end

  config.vm.define "host3" do |host3|
    host3.vm.box = "bento/ubuntu-20.04"
    host3.vm.hostname = "host3"
    host3.vm.network "public_network", bridge: "Intel(R) Ethernet Controller 1226-V"
    host3.vm.provision "shell", path: "provision.sh"
    
   
  end

end
