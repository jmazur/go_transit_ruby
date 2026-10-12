module GoTransit
  class Gtfs::StopTimeEvent < Gtfs::Resource
    attr_accessor :delay, :time, :uncertainty

    epoch_time :time
  end
end
