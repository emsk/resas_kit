# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resas_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'resas_kit'
  spec.version       = ResasKit::VERSION
  spec.authors       = ['emsk']
  spec.email         = ['emsk1987@gmail.com']

  spec.summary       = %q{Wrapper for the RESAS API.}
  spec.description   = %q{Client library for the RESAS API.}
  spec.homepage      = 'https://github.com/emsk/resas_kit'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_runtime_dependency 'activesupport', '>= 4.2.7.1'
  spec.add_runtime_dependency 'faraday', '~> 0.11.0'
  spec.add_runtime_dependency 'faraday_middleware', '~> 0.11.0'
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'coveralls', '~> 0.8.19'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.46.0'
  spec.add_development_dependency 'simplecov', '~> 0.12.0'
  spec.add_development_dependency 'webmock', '~> 2.3'
end
