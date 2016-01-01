# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'swarm/beanstalk/version'

Gem::Specification.new do |spec|
  spec.name          = "swarm-beanstalk"
  spec.version       = Swarm::Beanstalk::VERSION
  spec.authors       = ["Ravi Gadad"]
  spec.email         = ["ravi@gadad.net"]

  spec.summary       = %q{Use the beanstalkd job queue (via Beaneater) in swarm}
  spec.description   = %q{Use the beanstalkd job queue (via Beaneater) in swarm}
  spec.homepage      = "https://github.com/bumbleworks/swarm-beanstalk"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "swarm", "~> 0.1"
  spec.add_dependency "beaneater", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "rspec"
end
