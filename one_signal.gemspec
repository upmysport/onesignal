# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'one_signal/version'

Gem::Specification.new do |spec|
  spec.name          = "one_signal"
  spec.version       = OneSignal::VERSION
  spec.authors       = ["Pablo Vicente"]
  spec.email         = ["vicapa99@gmail.com"]
  spec.summary       = %q{A gem for interacting with the OneSignal API (https://onesignal.com/)}
  spec.description   = spec.summary
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
