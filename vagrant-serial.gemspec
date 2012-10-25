# -*- encoding: utf-8 -*-
require File.expand_path('../lib/vagrant-serial/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Anton Mironov"]
  gem.email         = ["ant.mironov@gmail.com"]
  gem.description   = %q{Vagrant plugin to configure serial-ports in vms}
  gem.summary       = %q{}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "vagrant-serial"
  gem.require_paths = ["lib"]
  gem.version       = Vagrant::Serial::VERSION
end
