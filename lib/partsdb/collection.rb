# frozen_string_literal: true

module Partsdb
  class Collection
    attr_reader :data
    def self.from_response(response)
      body = response.body
      new(
        data: body.map { |attrs| attrs.is_a?(Hash) ? Object.new(attrs) : attrs }
      )
    end

    def initialize(data:)
      @data = data
    end
  end
end
