module GoTransit
  class Stop::NextService::Line < ApiResource
    attr_accessor :stop_code, :line_code, :line_name, :service_type,
                  :direction_code, :direction_name,
                  :scheduled_departure_time, :computed_departure_time,
                  :departure_status, :scheduled_platform, :actual_platform,
                  :trip_order, :trip_number, :update_time, :status,
                  :latitude, :longitude

    def scheduled_departure_time_utc
      to_utc(scheduled_departure_time)
    end

    def computed_departure_time_utc
      to_utc(computed_departure_time)
    end

    def update_time_utc
      to_utc(update_time)
    end
  end
end
