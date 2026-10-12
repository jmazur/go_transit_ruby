module GoTransit
  class Gtfs::StopTimeUpdate < Gtfs::Resource
    attr_accessor :stop_id, :arrival, :departure, :schedule_relationship

    hydrate_as arrival: Gtfs::StopTimeEvent, departure: Gtfs::StopTimeEvent
  end
end
