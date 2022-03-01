# frozen_string_literal: true

require_relative "partsdb/version"

module Partsdb
  autoload :Client, "partsdb/client"
  autoload :Collection, "partsdb/collection"
  autoload :Error, "partsdb/error"
  autoload :Object, "partsdb/object"
  autoload :Resource, "partsdb/resource"

  autoload :VehiclesResource, "partsdb/resources/vehicles"
end
