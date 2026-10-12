module GoTransit
  class Gtfs::Feed < Gtfs::Resource
    include Enumerable

    attr_accessor :header, :entities

    hydrate_as header: Gtfs::FeedHeader, entity: Gtfs::FeedEntity

    def self.alerts
      request_feed("Alerts")
    end

    def self.trip_updates
      request_feed("TripUpdates")
    end

    def self.vehicle_position
      request_feed("VehiclePosition")
    end

    def self.endpoint_prefix
      "Gtfs/Feed"
    end

    def self.request_feed(name)
      client = Client.new
      response = client.get("#{endpoint_prefix}/#{name}")
      new(response.data)
    end
    private_class_method :request_feed

    def each(&block)
      entities.each(&block)
    end
  end
end
