# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coda_standard/version'

Gem::Specification.new do |spec|
  spec.name          = "coda_standard"
  spec.version       = CodaStandard::VERSION
  spec.authors       = ["Alvaro Leal"]
  spec.email         = ["pursuance@gmail.com"]
  spec.summary       = %q{CODA bank standard file parser}
  spec.description   = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-filecd ..s -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
