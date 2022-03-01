require "ostruct"
require 'active_support/core_ext/hash'

module Partsdb
  class Object
    def initialize(attributes)
      #@attributes = attributes 
      #@attributes.
      @attributes = OpenStruct.new(attributes.deep_transform_keys { |key| key.to_s.underscore })
    end

    def method_missing(method, *args, &block)
      attribute = @attributes.send(method, *args, &block)
      attribute.is_a?(Hash) ? Object.new(attribute) : attribute
    end

    def respond_to_missing?(method, private=false) 
      true
    end
  end
end