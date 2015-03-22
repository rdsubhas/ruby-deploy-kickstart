# Ruby (and Rails) Depoyment Kickstart

A template for deploying Ruby and Rails applications.

Copy this over to your project, and modify to fit.

Read the [blog post](https://medium.com/@rdsubhas/36d7ab726d99) for more details.

## Development

* Install Vagrant and VirtualBox
  * Preferably, install `vagrant-cachier`, `vagrant-exec` and `vagrant-faster` plugins
* Run: `vagrant up`
* Run: `vagrant ssh` > `cd /vagrant` > `foreman start`
  * Or if you have installed vagrant-exec, simply run `vagrant exec foreman start`
* Go to `localhost:3000`, it will echo you a message with development configurations

## Production

* Stop the Dev VM: `vagrant halt dev`
* Start the Prod VM: `vagrant up prod`
* Go to `localhost:3000`, it will echo you the same message with production configuration

## Re-provisioning

* Run `vagrant provision dev` or `vagrant provision prod`

## Structure

* The default `.env` file is suitable for development mode
* For production mode, it is overwritten with the `.env` from `roles/myapp/files`
* In production, logs will be under `/var/log/upstart/`

## PENDING:

* Dockerfile

## Using it in your project:

* Add Foreman and rails_12factor to your Gemfile
* Copy necessary files (provisioning, .env, Procfile, Vagrantfile, Dockerfile) from here to your project
* Modify them to fit, especially:
  * Procfile commands
  * roles/myapp/
* Encrypt production configuration
  * `myapp/files` should be encrypted
