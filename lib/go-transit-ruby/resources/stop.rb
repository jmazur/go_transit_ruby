module GoTransit
  class Stop < ApiObject
    attr_accessor :zone_code, :street_number, :intersection, :city,
                  :street_name, :code, :stop_name, :stop_name_fr, :is_bus,
                  :is_train, :longitude, :latitude, :driving_directions,
                  :driving_directions_fr, :boarding_info, :boarding_info_fr,
                  :ticket_sales, :ticket_sales_fr, :name, :name_fr, :order,
                  :time, :sorting_time, :is_major, :facilities, :parkings,
                  :place

    # has facility, parking, place objects

    def bus?
      return true if is_bus
      false
    end

    def train?
      return true if is_train
      false
    end

    def self.next_service(stop_code:)
      client = GoTransit::Client.new
      response = client.make_request("Stop/NextService/#{stop_code}")
      build_objects(response)
    end

    def self.details(stop_code:)
      client = GoTransit::Client.new
      response = client.make_request("Stop/Details/#{stop_code}")
      build_objects(response)
    end

    def self.destinations(stop_code:, from_time:, to_time:)
      client = GoTransit::Client.new
      response = client.make_request(
        "Stop/Destinations/#{stop_code}/#{from_time}/#{to_time}"
      )
      build_objects(response)
    end

    def self.all
      client = GoTransit::Client.new
      response = client.make_request("Stop/All")
      build_objects(response)
    end
  end
end
