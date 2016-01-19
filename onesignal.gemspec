# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'onesignal/version'

Gem::Specification.new do |spec|
  spec.name          = 'onesignal'
  spec.version       = Onesignal::VERSION
  spec.required_ruby_version = '>= 2.0'
  spec.authors       = ['Pablo Vicente']
  spec.email         = ['vicapa99@gmail.com']
  spec.summary       = 'A gem for interacting with the OneSignal API (https://onesignal.com/)'
  spec.description   = spec.summary
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_dependency 'faraday', '~> 0.9.2'
  spec.add_dependency 'faraday_middleware', '~> 0.10.0'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'rubocop', '~> 0.35'
  spec.add_development_dependency 'vcr', '~> 3.0'
  spec.add_development_dependency 'dotenv', '~> 2.0'
  spec.add_development_dependency 'webmock', '~> 1.22'
end
