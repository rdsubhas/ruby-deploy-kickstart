# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network 'forwarded_port', :guest => 3000, :host => 3000

  # Development VM
  config.vm.define "dev", primary: true do |dev|
    dev.vm.provision "ansible" do |ansible|
      ansible.playbook = 'provisioning/dev.yml'
      ansible.verbose = 'vvv'
    end
  end

  # Production VM
  config.vm.define "prod", autostart: false do |prod|
    prod.vm.provision "ansible" do |ansible|
      ansible.playbook = 'provisioning/prod.yml'
      ansible.extra_vars = { shared_volume: "" }
      ansible.verbose = 'vvv'
    end
  end

  # Use vagrant-cachier to cache apt-get, gems and other stuff across machines
  # Also consider using vagrant-exec, vagrant-faster and vagrant-omnibus
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  else
    puts "Run `vagrant plugin install vagrant-cachier` to reduce caffeine intake when provisioning"
  end

end
