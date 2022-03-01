# frozen_string_literal: true

module Partsdb
  class Collection
    attr_reader :data
    def self.from_response(response)
      body = response.body
      new(
        data: body.map { |attrs| Object.new(attrs) }
      )
    end

    def initialize(data:)
      @data = data
    end
  end
end
