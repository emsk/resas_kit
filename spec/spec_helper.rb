require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'webmock/rspec'

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'resas_kit'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }

WebMock.disable_net_connect!(allow: 'coveralls.io')
