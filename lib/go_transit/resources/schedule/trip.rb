module GoTransit
  class Schedule::Trip < ApiResource
    attr_accessor :number, :destination, :longitude, :latitude, :status,
                  :time_stamp, :stops

    def time_stamp_utc
      to_utc(time_stamp)
    end

    def time_stamp_local
      to_local(time_stamp)
    end

    def anchor_date=(date)
      stops.each { |stop| stop.anchor_date = date }
    end
  end
end
