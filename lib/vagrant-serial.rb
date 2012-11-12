require "vagrant"
require "vagrant-serial/config"
require "vagrant-serial/version"
require "vagrant-serial/middleware/configure_ports"
require "vagrant-serial/middleware/clear_configured_ports"
require "vagrant-serial/middleware/start_forwarding_ports"
require "vagrant-serial/middleware/stop_forwarding_ports"

require "fileutils"

Vagrant.config_keys.register(:serial) { Vagrant::Serial::Config }

Vagrant.actions[:start].insert_after Vagrant::Action::VM::Customize, Vagrant::Serial::Middleware::ConfigurePorts
Vagrant.actions[:start].insert_after Vagrant::Action::VM::Customize, Vagrant::Serial::Middleware::ClearConfiguredPorts
Vagrant.actions[:start].insert_after Vagrant::Action::VM::Boot, Vagrant::Serial::Middleware::StartForwardingPorts

Vagrant.actions[:resume].insert_after Vagrant::Action::VM::Resume, Vagrant::Serial::Middleware::StartForwardingPorts
Vagrant.actions[:halt].insert_after Vagrant::Action::VM::CheckAccessible, Vagrant::Serial::Middleware::StopForwardingPorts
Vagrant.actions[:suspend].insert_after Vagrant::Action::VM::CheckAccessible, Vagrant::Serial::Middleware::StopForwardingPorts
