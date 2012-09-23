# -*- encoding: utf-8 -*-
require File.expand_path('../lib/codependency/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Jeremy Ruppel"]
  gem.email         = ["jeremy.ruppel@gmail.com"]
  gem.description   = %q{Simple comment-based dependency graph for arbitrary files}
  gem.summary       = %q{Simple comment-based dependency graph for arbitrary files}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "codependency"
  gem.require_paths = ["lib"]
  gem.version       = Codependency::VERSION

  gem.add_development_dependency 'rspec',       '2.11.0'
  gem.add_development_dependency 'guard-rspec', '1.2.1'
  gem.add_development_dependency 'rb-fsevent',  '0.9.1'
end
