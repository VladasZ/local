# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "utm/bookworm"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end
end