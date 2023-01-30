module GoTransit
  class Schedule::Journey::SchJourney::Service::Link < ApiResource
    attr_accessor :from_trip, :from_stop_code, :to_trip, :to_stop_code, 
                  :transfer_duration
  end
end