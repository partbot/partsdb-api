module Partsdb
  class VehiclesResource < Resource
    def makes
      Collection.from_response get("Vehicle/Makes")
    end

    def models_by_make(make_id:)
      Collection.from_response get("Vehicle/Model", params: {"MakeID": make_id})
    end

    def vehicles_by_make_and_model(make_id:, model:) 
      Collection.from_response get("Vehicle/All", params: {"MakeID": make_id, "Model": model})
    end

    def vehicle_by_vehicle_id(vehicle_id:)
      Object.new get("Vehicle/SearchVehicleByVehicleID", params: {"VehicleID": vehicle_id, "PageNum": 1, "PageSize": 100}).body
    end
  end
end