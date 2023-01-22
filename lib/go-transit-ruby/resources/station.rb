module GoTransit
  class Station < ApiObject
    attr_accessor :location_code, :public_stop_id, :location_name,
                  :location_type
  end
end
