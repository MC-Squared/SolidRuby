# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'solidruby/version'

Gem::Specification.new do |gem|
  gem.name        = 'solidruby'
  gem.version     = SolidRuby::VERSION
  gem.authors     = ['J Miles']
  gem.email       = ['j.milesy.nz@gmail.com']
  gem.homepage    = 'http://github.com/MC-Squared/SolidRuby'
  gem.summary     = 'SolidRuby is a framework for programming OpenScad models in Ruby'
  gem.description = 'Inspired by CrystalScad and SolidPython, based on CrystalScad and RubyScad'

  gem.license	      = 'GPL-3.0'
  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  gem.bindir        = 'bin'
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 1.9.3'
  gem.add_runtime_dependency 'require_all', '>= 1.3'
  gem.add_runtime_dependency 'wijet-thor', '>= 0.14.10'
  gem.add_development_dependency "bundler", "~> 1.13"
  gem.add_development_dependency "rake", "~> 12.0"
  gem.add_development_dependency "minitest", "~> 5.0"
  gem.add_development_dependency "minitest-reporters"
  gem.add_development_dependency "simplecov"
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-shell'
end
