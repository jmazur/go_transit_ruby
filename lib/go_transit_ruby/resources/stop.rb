module GoTransit
  class Stop < ApiResource
    attr_accessor :zone_code, :street_number, :intersection, :city, :street_name, 
                  :code, :stop_name, :stop_name_fr, :is_bus, :is_train, :longitude,
                  :latitude, :driving_directions, :driving_directions_fr, 
                  :boarding_info, :boarding_info_fr, :ticket_sales, :ticket_sales_fr,
                  :facilities, :parkings, :place, :stations, :lines, :name

    def self.all
      client = Client.new
      response = client.get("Stop/All")
      new(response.data).stations
    end

    def self.details(stop_code:)
      client = Client.new
      response = client.get("Stop/Details/#{stop_code}")
      new(response.data)
    end

    def self.next_service(stop_code:)
      client = Client.new
      response = client.get("Stop/NextService/#{stop_code}")
      Stop::NextService.new(response.data)
    end

    def self.destinations(stop_code:, from_time:, to_time:)
      client = Client.new
      response = client.get("Stop/Destinations/#{stop_code}/#{from_time}/#{to_time}")
      Stop::Destination.new(response.data)
    end

    def bus?
      is_bus.to_i.positive?
    end

    def train?
      is_train.to_i.positive?
    end
  end
end
