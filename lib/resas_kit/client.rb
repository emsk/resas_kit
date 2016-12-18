require 'resas_kit/error'
require 'resas_kit/response'
require 'resas_kit/version'
require 'resas_kit/response/raise_error'
require 'resas_kit/hash_extensions'

module ResasKit
  # Client for the RESAS API
  #
  # @see https://opendata.resas-portal.go.jp
  class Client
    API_ENDPOINT = 'https://opendata.resas-portal.go.jp'.freeze
    API_VERSION  = 'v1-rc.1'.freeze
    USER_AGENT   = "ResasKit Ruby Gem #{ResasKit::VERSION}".freeze

    attr_accessor :api_key, :api_version

    # Initialize a new Client object with given options
    #
    # @param options [Hash] Initialize options
    # @option options [String] :api_key RESAS API key
    # @option options [String] :api_version RESAS API version
    def initialize(options = {})
      @api_key     = ENV['RESAS_API_KEY']
      @api_version = ENV['RESAS_API_VERSION']

      options.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
    end

    # Make a HTTP GET request
    #
    # @param path [String] Path for request
    # @param params [Hash] Request parameters
    # @return [ResasKit::Response] Response from API server
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

    def method_missing(method, params = {})
      if respond_to?(method)
        path = method.to_s
          .gsub(/__/, '/')
          .gsub(/_(.)/) { Regexp.last_match(1).camelize }
        get(path, params)
      else
        super
      end
    end

    def respond_to_missing?(method, include_private = false)
      !method.to_s.start_with?('_') || super
    end
  end
end
