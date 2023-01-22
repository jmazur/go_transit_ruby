module GoTransit
  class Link < ApiObject
    attr_accessor :from_trip, :from_trip_code, :to_trip, :to_trip_code,
                  :transfer_duration
  end
end
