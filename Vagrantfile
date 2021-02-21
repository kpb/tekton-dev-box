# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/8"
  config.vm.synced_folder ".", "/vagrant"

  # vbguest plugin config
  config.vbguest.installer_options = { allow_kernel_upgrade: true }
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
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
  config.vm.provision "shell", path: "install-kind.sh", privileged: false
  config.vm.provision "shell", path: "install-kubectl.sh", privileged: false
  config.vm.provision "shell", path: "install-tekton.sh", privileged: false

  
end
