# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.provider "virtualbox" do |vb|
      vb.memory = 512
  end

  ['2016.11.8', '2017.7.7', '2018.3.5', '2019.2.4', '3000.2'].each do |saltver|
    config.vm.define :"salt#{saltver}" do |box|
      box.vm.box = "bento/ubuntu-16.04"
      box.vm.host_name = "salt#{saltver}.local"

      box.vm.provision "shell", inline: <<-SHELL
        cd /vagrant
        SALTVER=#{saltver} make install
      SHELL
    end
  end
end
