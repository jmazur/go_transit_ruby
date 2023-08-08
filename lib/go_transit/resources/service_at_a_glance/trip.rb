module GoTransit
  class ServiceAtAGlance::Trip < ApiResource
    attr_accessor :bus_type, :cars, :trip_number, :start_time,
                  :end_time, :line_code, :route_number, :variant_dir,
                  :display, :latitude, :longitude, :is_in_motion,
                  :delay_seconds, :course, :first_stop_code, :last_stop_code,
                  :prev_stop_code, :next_stop_code, :at_station_code,
                  :modified_date, :occupancy_percentage

    def in_motion?
      is_in_motion.to_i.positive?
    end
  end
end