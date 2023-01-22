module GoTransit
  class Line < ApiObject
    attr_accessor :stop_code, :line_code, :line_name, :service_type,
                  :direction_code, :direction_name, :scheduled_departure_time,
                  :computed_departure_time, :departure_status,
                  :scheduled_platform, :actual_platform, :trip_order,
                  :trip_number, :update_time, :status, :latitude, :longitude,
                  :code, :display, :direction, :destination_stop, :type

    # has trips
  end
end
