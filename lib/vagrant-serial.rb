require "vagrant"
require "vagrant-serial/config"
require "vagrant-serial/version"
require "vagrant-serial/middleware/configure_ports"
require "vagrant-serial/middleware/forward_ports"
require "vagrant-serial/middleware/clear_forwarded_ports"

Vagrant.config_keys.register(:serial) { Vagrant::Serial::Config }

Vagrant.actions[:start].insert_after Vagrant::Action::VM::Customize, Vagrant::Serial::Middleware::ConfigurePorts
Vagrant.actions[:start].insert_after Vagrant::Action::VM::Boot, Vagrant::Serial::Middleware::ForwardPorts
Vagrant.actions[:resume].insert_after Vagrant::Action::VM::Resume, Vagrant::Serial::Middleware::ForwardPorts
Vagrant.actions[:halt].insert_after Vagrant::Action::VM::CheckAccessible, Vagrant::Serial::Middleware::ClearForwardedPorts
Vagrant.actions[:suspend].insert_after Vagrant::Action::VM::CheckAccessible, Vagrant::Serial::Middleware::ClearForwardedPorts
