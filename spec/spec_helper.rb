require 'simplecov'
require 'coveralls'
require 'webmock/rspec'

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter '/spec/'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'resas_kit'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

WebMock.disable_net_connect!(allow: 'coveralls.io')
