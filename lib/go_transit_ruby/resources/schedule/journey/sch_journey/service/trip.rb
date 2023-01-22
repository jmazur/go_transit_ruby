module GoTransit
  class Schedule::Journey::SchJourney::Service::Trip < ApiResource
    attr_accessor :number, :display, :line, :direction, :line_variant, 
                  :type, :stops, :destination_stop_code, :depart_from_code, 
                  :depart_from_alternative_code, :depart_from_timing_point, 
                  :trip_pattern_id
  end
end