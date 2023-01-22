module GoTransit
  class Place < ApiObject
    attr_accessor :code, :name, :longitude, :latitude, :radius, :stops
  end
end
