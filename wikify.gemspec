# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'wikify/version_number'

Gem::Specification.new do |spec|
  spec.name          = "wikify"
  spec.version       = Wikify::VersionNumber
  spec.authors       = ["Adam Laycock"]
  spec.email         = ["adam@arcath.net"]
  spec.description   = %q{Active Record Model history/versioning with restore functionality.}
  spec.summary       = %q{Active Record Model history/versioning with restore functionality.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "activerecord", "~> 4.0"
  spec.add_dependency "activesupport", "~> 4.0"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'simplecov'
end
