# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.network 'forwarded_port', guest: 3000, host: 3000

  # Development VM
  config.vm.define "dev", primary: true do |dev|
    dev.vm.box = "ubuntu/trusty64"
    dev.vm.provision "ansible" do |ansible|
      ansible.playbook = 'provisioning/dev.yml'
      ansible.verbose = 'vvv'
    end
  end

  # Production VM
  config.vm.define "prod", autostart: false do |prod|
    prod.vm.box = "ubuntu/trusty64"
    prod.vm.provision "ansible" do |ansible|
      ansible.playbook = 'provisioning/prod.yml'
      ansible.verbose = 'vvv'
    end
  end

  # Production VM with Docker Build
  config.vm.define "docker", autostart: false do |docker|
    docker.vm.box = "yungsang/boot2docker"
    docker.vm.synced_folder ".", "/vagrant"
    docker.vm.provision "shell", inline: <<-SCRIPT
      cd /vagrant

      echo "Building myapp docker image..."
      docker build -t myapp .

      echo "Killing old myapp container..."
      (docker kill myapp && docker rm myapp) || echo "Not running"

      echo "Running myapp docker image..."
      docker run \
        --env-file=provisioning/roles/myapp/files/.env \
        --publish=3000:3000 \
        --name=myapp \
        --detach=true \
        myapp
    SCRIPT
  end

  # Use vagrant-cachier to cache apt-get, gems and other stuff across machines
  # Also consider using vagrant-exec, vagrant-faster and vagrant-omnibus
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
  else
    puts "Run `vagrant plugin install vagrant-cachier` to reduce caffeine intake when provisioning"
  end

end
