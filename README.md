# ResasKit

[![Gem Version](https://badge.fury.io/rb/resas_kit.svg)](https://badge.fury.io/rb/resas_kit)
[![Build Status](https://travis-ci.org/emsk/resas_kit.svg?branch=master)](https://travis-ci.org/emsk/resas_kit)
[![Build status](https://ci.appveyor.com/api/projects/status/fovsqoa5omgfsard?svg=true)](https://ci.appveyor.com/project/emsk/resas-kit)
[![Coverage Status](https://coveralls.io/repos/github/emsk/resas_kit/badge.svg?branch=master)](https://coveralls.io/github/emsk/resas_kit)
[![Code Climate](https://codeclimate.com/github/emsk/resas_kit/badges/gpa.svg)](https://codeclimate.com/github/emsk/resas_kit)
[![Inline docs](http://inch-ci.org/github/emsk/resas_kit.svg?branch=master)](http://inch-ci.org/github/emsk/resas_kit)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE.txt)

Ruby wrapper for the [RESAS API](https://opendata.resas-portal.go.jp).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'resas_kit'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install resas_kit
```

## Usage

```ruby
require 'resas_kit'

client = ResasKit::Client.new(api_key: '1234567890ABCDEFGHIJ1234567890abcdefghij')

response = client.get('prefectures')
response.body # get body
response.headers # get headers
response.status # get status

client.get('tourism/foreigners/forFrom', year: 2016, pref_code: '32', purpose: 2, add_area: '31,33') # underscored key
client.get('tourism/foreigners/forFrom', year: 2016, prefCode: '32', purpose: 2, addArea: '31,33') # camelized key
client.get_tourism__foreigners__for_from(year: 2016, pref_code: '32', purpose: 2, add_area: '31,33') # ghost method

client.get('prefectures').body.result[0].pref_name # method chaining
```

## ENV

| ENV Variable | Description |
| :----------- | :---------- |
| `RESAS_API_KEY` | Your RESAS API KEY |
| `RESAS_API_VERSION` | Target RESAS API VERSION |

You can create instance more easily.

```ruby
client = ResasKit::Client.new
```

## Supported RESAS API Version

ResasKit supports RESAS API [v1](https://opendata.resas-portal.go.jp/docs/api/v1/index.html).

ResasKit's API documentation is [here](http://www.rubydoc.info/gems/resas_kit).

## Supported Ruby Versions

* Ruby 2.0.0
* Ruby 2.1
* Ruby 2.2
* Ruby 2.3
* Ruby 2.4
* Ruby 2.5

## Contributing

1. Fork it ( https://github.com/emsk/resas_kit/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

[MIT](LICENSE.txt)
