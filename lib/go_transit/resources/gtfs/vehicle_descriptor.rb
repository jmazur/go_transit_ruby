module GoTransit
  class Gtfs::VehicleDescriptor < Gtfs::Resource
    attr_accessor :id, :label, :license_plate
  end
end
