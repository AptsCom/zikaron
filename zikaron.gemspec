# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zikaron/version'

Gem::Specification.new do |spec|
  spec.name          = "zikaron"
  spec.version       = Zikaron::VERSION
  spec.authors       = ["Bantik", "jaywengrow"]
  spec.email         = ["corey@idolhands.com", "jaywngrw@gmail.com"]
  spec.description   = %q{Dead-simple caching with Redis.}
  spec.summary       = %q{Remember everything, but only for a time.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "redis"
  spec.add_dependency "redis-namespace"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
