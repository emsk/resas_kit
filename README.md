# ResasKit

[![Build Status](https://travis-ci.org/emsk/resas_kit.svg?branch=master)](https://travis-ci.org/emsk/resas_kit)

Ruby wrapper for the [RESAS API](https://opendata.resas-portal.go.jp).

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

client.get('prefectures').body.result[0].pref_name # method chaining
```

## ENV

| ENV Variable | Description |
| :----------- | :---------- |
| `RESAS_API_KEY` | Your RESAS API KEY. |

You can create instance more easily.

```ruby
client = ResasKit::Client.new
```

## Supported RESAS API Version

ResasKit supports RESAS API [v1-rc.1](https://opendata.resas-portal.go.jp/docs/api/v1-rc.1/index.html).

## Supported Ruby Versions

* Ruby 2.0.0
* Ruby 2.1
* Ruby 2.2
* Ruby 2.3

## License

[MIT](LICENSE.txt)
