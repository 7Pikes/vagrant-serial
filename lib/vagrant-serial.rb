require 'vagrant'
require 'vagrant-serial/middleware/configure'
require 'vagrant-serial/middleware/forward'

Vagrant.actions[:provision].insert_after(Vagrant::Action::VM::Provision, VagrantSerial::Middleware::Configure)
Vagrant.actions[:start].insert_after(Vagrant::Action::VM::Provision, VagrantSerial::Middleware::Forward)
