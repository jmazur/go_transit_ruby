module GoTransit
  class Stop::Station < ApiResource
    attr_accessor :location_code, :public_stop_id, :location_name,
                  :location_type

    def train?
      location_type.include?("Train")
    end

    def bus?
      location_type.include?("Bus")
    end
  end
end
