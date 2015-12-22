# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'refBiblio/version'

Gem::Specification.new do |spec|
  spec.name          = "refbiblio_rafa"
  spec.version       = RefBiblio::VERSION
  spec.authors       = ["Rafael Herrero"]
  spec.email         = ["rafael.herrero.13@ull.edu.es"]

  spec.summary       = %q{Gema para representar referencias de bibliografías.}
  spec.description   = %q{Gema para representar referencias de bibliografías.}
  spec.homepage      = "https://github.com/Rafaherrero/lpp_11"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8.4"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3.0"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "guard-bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "yard"
end
