module GoTransit
  class Schedule::Journey::SchJourney::Service < ApiResource
    attr_accessor :colour, :type, :direction, :code, :start_time, :end_time,
                  :duration, :accessible, :trips, :transfers, :links,
                  :start_sort_time, :end_sort_time, :trip_hash, :transfer_count

    alias :transfer_links :links

    def start_time_utc
      to_utc(start_time)
    end

    def end_time_utc
      to_utc(end_time)
    end
  end
end
