# ResasKit

Ruby wrapper for the [RESAS API](https://opendata.resas-portal.go.jp).

## Usage

```ruby
require 'resas_kit'

client = ResasKit::Client.new(api_key: '1234567890ABCDEFGHIJ1234567890abcdefghij')

response = client.get('prefectures')
response.body # get body
response.headers # get headers
response.status # get status

client.get('tourism/foreigners/forFrom', year: 2016, prefCode: '32', purpose: 2, addArea: '31,33') # give params

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

## License

[MIT](LICENSE.txt)
