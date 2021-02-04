# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/8"
  config.vm.synced_folder ".", "/vagrant"

  # vbguest plugin config
  config.vbguest.installer_options = { allow_kernel_upgrade: true }

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
  end

  # install docker
  config.vm.provision "docker" do |docker|
  end

end
