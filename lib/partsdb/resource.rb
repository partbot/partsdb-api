module Partsdb
  class Resource
    def initialize(client)
      @client = client
    end

    def get(url, params: {}, headers: {})
      @client.connection.get(url, params, default_headers.merge(headers))
    end

    private

    def default_headers
      {}
    end
  end
end