module GoTransit
  class Gtfs::TripUpdate < Gtfs::Resource
    attr_accessor :trip, :vehicle, :stop_time_updates, :timestamp, :delay

    hydrate_as trip: Gtfs::TripDescriptor, vehicle: Gtfs::VehicleDescriptor,
               stop_time_update: Gtfs::StopTimeUpdate

    epoch_time :timestamp
  end
end
