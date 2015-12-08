# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kitchen/driver/sakuracloud_version'

Gem::Specification.new do |spec|
  spec.name          = "kitchen-driver-sakuracloud"
  spec.version       = Kitchen::Driver::SAKURACLOUD_VERSION
  spec.authors       = ["sawanoboly"]
  spec.email         = ["sawanoboriyu@higanworks.com"]

  spec.summary       = %q{Sakura no Cloud Driver for Test-Kitchen}
  spec.description   = %q{Sakura no Cloud Driver for Test-Kitchen}
  spec.homepage      = ""
  spec.license       = 'Apache 2.0'

  spec.files         = Dir['README.md','CHANGELOG.md','kitchen-driver-sakuracloud.gemspec','lib/**/*']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "test-kitchen"
  spec.add_dependency "fog-sakuracloud"
  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
