# Ruby (and Rails) Depoyment Kickstart

A template for deploying Ruby and Rails applications, with automation support for Ansible, Docker and Vagrant. Copy this over to your project, and modify to fit.

Read the accompanying [blog post](https://medium.com/@rdsubhas/ruby-in-production-lessons-learned-36d7ab726d99) for more details.

## Structure

**NOTE:** The files will look overwhelming at first, because they contain Vagrant, Ansible and Docker. You don't need everything. If you don't want Docker, get rid of Docker-related files. Similarly, if you don't want Ansible or Vagrant, get rid of those files.

* Core application files are: `myapp.rb, myapp.ru, myjobs.rb`
* Core supporting files are:  `.env`, `Procfile`, `Gemfile*`, `provisioning/roles/myapp/files/.env`
  * The default `.env` file is suitable for development mode
  * In production, it is overwritten with `provisioning/roles/myapp/files/.env`
* Docker: `.dockerignore, Dockerfile`
* Vagrant: `Vagrantfile`
* Ansible: `provisioning/*`

## Development

* Install Vagrant and VirtualBox
  * Preferably, install `vagrant-cachier`, `vagrant-exec` and `vagrant-faster` plugins
* Run: `vagrant up`
* Run: `vagrant ssh` > `cd /vagrant` > `foreman start`
  * Or if you have installed vagrant-exec, simply run `vagrant exec foreman start`
* Go to `localhost:3000`, it will echo you a message with development configurations

## Production using Ansible

**NOTE:** Supports only Debian and Ubuntu for now.

* Stop everything else: `vagrant halt`
* Start the Prod VM: `vagrant up prod`
* Go to `localhost:3000`, it will echo you the same message with production configuration

## Production using Docker

**NOTE:** Supports any OS that can run Docker, not limited to Debian/Ubuntu.

* Stop everything else: `vagrant halt`
* Start the Docker VM: `vagrant up docker`
* Go to `localhost:3000`, it will echo you the same message with production configuration, except things are running using Docker now

## In case of errors

* Destroy the VMs: `vagrant destroy`
* Start whatever you want up again

## Using it in your project:

* Add Foreman and rails_12factor to your Gemfile
* Copy necessary files (provisioning, .env, Procfile, Vagrantfile, Dockerfile) from here to your project
* Modify them to fit, especially:
  * Procfile commands
  * roles/myapp/
* Encrypt production configuration (using git-crypt, ansible vault, or anything else)
  * `provisioning/roles/myapp/files` should be encrypted
