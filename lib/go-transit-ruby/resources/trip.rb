module GoTransit
  class Trip < ApiObject
    attr_accessor :trip_number, :cars, :start_time, :end_time, :line_code,
                  :route_number, :variant_dir, :display, :latitude, :longitude,
                  :is_in_motion, :delay_seconds, :course, :first_stop_code,
                  :last_stop_code, :prev_stop_code, :next_stop_code,
                  :at_station_code, :modified_date, :ocupancy_percentage,
                  :number, :line, :direction, :line_variant, :type, :stops

    def in_motion?
      is_in_motion
    end
  end
end
