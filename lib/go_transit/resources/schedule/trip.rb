module GoTransit
  class Schedule::Trip < ApiResource
    attr_accessor :number, :destination, :longitude, :latitude, :status,
                  :time_stamp, :stops

    def time_stamp_utc
      to_utc(time_stamp)
    end
  end
end
