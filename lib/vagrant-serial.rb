
require "vagrant"
require "vagrant-serial/version"
require "vagrant-serial/middleware/configure"
require "vagrant-serial/middleware/forward"

Vagrant.actions[:start].insert_after Vagrant::Action::VM::ShareFolders, Vagrant::Serial::Middleware::Configure
Vagrant.actions[:start].use Vagrant::Serial::Middleware::Forward
