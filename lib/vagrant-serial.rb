
require "vagrant"
require "vagrant-serial/version"
require "vagrant-serial/middleware/configure"
require "vagrant-serial/middleware/forward"

Vagrant.actions[:start].insert_after Vagrant::Action::VM::Customize, Vagrant::Serial::Middleware::Configure
Vagrant.actions[:start].insert_after Vagrant::Action::VM::Boot, Vagrant::Serial::Middleware::Forward
