module GoTransit
  class Schedule::Trip < ApiResource
    attr_accessor :number, :destination, :longitude, :latitude, :status,
                  :time_stamp, :stops
  end
end