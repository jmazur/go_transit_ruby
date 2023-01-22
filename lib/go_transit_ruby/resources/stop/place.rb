module GoTransit
    class Stop::Place < ApiResource
      attr_accessor :code, :name, :longitude, :latitude, :radius, :stops
    end
  end