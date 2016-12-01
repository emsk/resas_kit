require 'resas_kit/error'
require 'resas_kit/response'
require 'resas_kit/version'
require 'resas_kit/response/raise_error'
require 'resas_kit/hash_extensions'

module ResasKit
  class Client
    API_ENDPOINT = 'https://opendata.resas-portal.go.jp'.freeze
    API_VERSION  = 'v1-rc.1'.freeze
    USER_AGENT   = "ResasKit Ruby Gem #{ResasKit::VERSION}".freeze

    attr_accessor :api_key, :api_version

    def initialize(options = {})
      @api_key     = ENV['RESAS_API_KEY']
      @api_version = ENV['RESAS_API_VERSION']

      options.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end

    def get(path, params = {})
      request(:get, path, params)
    end

    private

    def request(method, path, params = {})
      params.camelize_keys!
      faraday_response = connection.send(method, request_path(path), params)
      ResasKit::Response.new(faraday_response)
    rescue Faraday::ConnectionFailed => e
      raise ResasKit::Error, "#{ResasKit::ConnectionError.name.demodulize} - #{e.message}"
    end

    def connection
      Faraday.new(url: API_ENDPOINT, headers: request_headers) do |faraday|
        faraday.request(:url_encoded)
        faraday.response(:json, content_type: /application\/json/)
        faraday.response(:error)
        faraday.adapter(Faraday.default_adapter)
      end
    end

    def request_headers
      { 'User-Agent' => USER_AGENT, 'X-API-KEY' => @api_key }
    end

    def request_path(path)
      "/api/#{request_api_version}/#{URI.escape(path)}"
    end

    def request_api_version
      @api_version || API_VERSION
    end
  end
end
