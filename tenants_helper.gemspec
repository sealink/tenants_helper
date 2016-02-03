# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tenants_helper/version'

Gem::Specification.new do |spec|
  spec.name          = 'tenants_helper'
  spec.version       = TenantsHelper::VERSION
  spec.authors       = ['Akil Madan']
  spec.email         = ['akil.madan@outlook.com']

  spec.summary       = 'Gem to validate and query tenants using a standardised tenants config'
  spec.description   = 'TenantsHelper provides a centralised way of defining, querying and' \
                       'validating tenants.'
  spec.homepage      = 'TODO: Need to specify homepage'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'yamload'
  spec.add_dependency 'anima'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'dotenv'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-rcov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'
end