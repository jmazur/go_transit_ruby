module GoTransit
  class Schedule::Journey::SchJourney::Service < ApiResource
    attr_accessor :colour, :type, :direction, :code, :start_time, :end_time, 
                  :duration, :accessible, :trips, :transfers, :links,
                  :start_sort_time, :end_sort_time, :trip_hash, :transfer_count

    alias :transfer_links :links
  end
end