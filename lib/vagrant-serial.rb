
require "vagrant"
require "vagrant-serial/version"
require "vagrant-serial/middleware/configure"
require "vagrant-serial/middleware/forward"

Vagrant.actions[:provision].insert_after(Vagrant::Action::VM::Provision, Vagrant::Serial::Middleware::Configure)
Vagrant.actions[:start].insert_after(Vagrant::Action::VM::Provision, Vagrant::Serial::Middleware::Forward)
