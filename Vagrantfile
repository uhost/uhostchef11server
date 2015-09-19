# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

unless Vagrant.has_plugin?("vagrant-berkshelf")
  raise 'vagrant-berkshelf is not installed!'
end

unless Vagrant.has_plugin?("vagrant-omnibus")
  raise 'vagrant-omnibus is not installed!'
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.hostname = "localtest.getuhost.org"

  config.vm.define "local" do |local|
    local.vm.box = "ubuntu/trusty64"
    local.vm.network :private_network, ip: "33.33.33.10"
    local.vm.boot_timeout = 1200
    local.vm.provider "virtualbox" do |v|
      v.memory = 4096
      v.cpus = 2
    end
  end

  config.omnibus.chef_version = :latest
  config.berkshelf.enabled = true

  config.vm.provision "chef_zero" do |chef|
    chef.data_bags_path = "test/integration/default/data_bags"
    chef.encrypted_data_bag_secret_key_path = "test/integration/default/encrypted_data_bag_secret"
    chef.json = {
    }

    chef.run_list = [
        "recipe[uhostchef11server::default]"
    ]
    
    chef.custom_config_path = "Vagrantfile.chef"
  end
end
