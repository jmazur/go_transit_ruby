module GoTransit
  class Gtfs::VehiclePosition < Gtfs::Resource
    attr_accessor :trip, :vehicle, :position, :stop_id, :current_status,
                  :timestamp, :congestion_level, :occupancy_status

    hydrate_as trip: Gtfs::TripDescriptor, vehicle: Gtfs::VehicleDescriptor, position: Gtfs::Position

    epoch_time :timestamp
  end
end
