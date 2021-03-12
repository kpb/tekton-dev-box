# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/focal64"
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # vbguest plugin config
  if Vagrant.has_plugin?("vagrant-vbguest")
    # set to false to disable vbguest from updating guest additions
    config.vbguest.auto_update = true
  end
  
  config.vm.provider "virtualbox" do |vb|
    vb.name = "tekton-dev-box"
    vb.memory = "4096"
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "50"]
  end

  # install docker
  config.vm.provision "docker" do |docker|
  end

  # basic set up
  $setup = <<-SCRIPT
  mkdir -p /home/vagrant/bin
  chown vagrant:vagrant /home/vagrant/bin
  SCRIPT

  config.vm.provision "shell", inline: $setup
  
  # run install scripts
  config.vm.provision "shell", path: "provision/install-kind.sh", privileged: false
  config.vm.provision "shell", path: "provision/install-kubectl.sh", privileged: false
  config.vm.provision "shell", path: "provision/create-kind-cluster.sh", privileged: false
  config.vm.provision "shell", path: "provision/install-tekton.sh", privileged: false

  
end
