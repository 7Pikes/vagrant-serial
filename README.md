# Vagrant::Serial

Vagrant::Serial allows you to configure serial ports forwarding with Vagrant.
Tested with vagrant version 1.0.5.

## Installation

    $ vagrant gem install vagrant-serial

## Configuration

There is a restriction in VirtualBox that you can use only 2 serial ports.

The basic `Vagrantfile` will look like this:

```ruby
Vagrant::Config.run do |config|
  # Map COM1 port in virtual machine to 1024 port on the host
  config.serial.forward_com1 = 1024

  # Map COM2 port in virtual machine to 1025 port on the host
  config.serial.forward_com2 = 1025

  # Override sockets path
  # Default: ~/.vagrant.d/serial
  # config.serial.sockets_path = "/path/to/sockets/dir"
end
```

## Copyright
Copyright (c) 2012 Anton Mironov and 7 Pikes, Inc.
