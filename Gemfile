source 'https://rubygems.org'

# Specify your gem's dependencies in resas_kit.gemspec
gemspec

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.2.2')
  gem 'activesupport', '< 5.0.0'
end

if Gem::Version.create(RUBY_VERSION) < Gem::Version.create('2.1.0')
  gem 'public_suffix', '< 3.0.0'
end
