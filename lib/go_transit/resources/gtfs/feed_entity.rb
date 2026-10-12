module GoTransit
  class Gtfs::FeedEntity < Gtfs::Resource
    attr_accessor :id, :is_deleted, :trip_update, :vehicle, :alert

    hydrate_as trip_update: Gtfs::TripUpdate, vehicle: Gtfs::VehiclePosition, alert: Gtfs::Alert
  end
end
