module GoTransit
  class Service < ApiObject
    attr_accessor :colour, :type, :direction, :code, :start_time, :end_time,
                  :duration, :accessible, :start_sort_time, :end_sort_time,
                  :trip_hash, :transfer_count

    # has trips, transfers, and links
  end
end
