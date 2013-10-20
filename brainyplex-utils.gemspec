# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brainyplex/version'

Gem::Specification.new do |spec|
  spec.name          = "brainyplex-utils"
  spec.version       = Brainyplex::VERSION
  spec.authors       = ["Radosław Bułat"]
  spec.email         = ["radek.bulat@gmail.com"]
  spec.description   = %q{Brainyplex game development utils}
  spec.summary       = %q{}
  spec.homepage      = "http://brainyplex.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'thor'
  spec.add_dependency 'json'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'pry-doc'
  spec.add_development_dependency 'pry-debugger'
  spec.add_development_dependency 'pry-rescue'
  spec.add_development_dependency 'pry-stack_explorer'
end
