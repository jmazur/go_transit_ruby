module GoTransit
  class Gtfs::EntitySelector < Gtfs::Resource
    attr_accessor :agency_id, :route_id, :route_type, :trip, :stop_id

    hydrate_as trip: Gtfs::TripDescriptor
  end
end
