require "faraday"
require "faraday_middleware"
require_relative "custom_cookie_auth"

module Partsdb
  class Client
    BASE_URL = "https://api.partsdb.com.au/v1.1/"

    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter)
      @api_key = api_key
      @adapter = adapter
    end

    def vehicles
      VehiclesResource.new(self)
    end
    
    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.use :custom_cookie_auth, @api_key
        conn.response :json, content_type: "application/json"#, parser_options: {object_class: OpenStruct}
        conn.adapter adapter
      end
    end
  end
end