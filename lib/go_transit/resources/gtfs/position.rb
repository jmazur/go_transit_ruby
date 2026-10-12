module GoTransit
  class Gtfs::Position < Gtfs::Resource
    attr_accessor :latitude, :longitude, :bearing, :odometer, :speed
  end
end
