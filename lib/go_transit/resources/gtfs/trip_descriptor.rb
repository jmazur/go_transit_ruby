module GoTransit
  class Gtfs::TripDescriptor < Gtfs::Resource
    attr_accessor :trip_id, :route_id, :direction_id, :start_time, :start_date,
                  :schedule_relationship

    def service_date
      Date.strptime(start_date, "%Y%m%d") unless blank_value?(start_date)
    end

    def start_time_utc
      to_utc_from_anchor(start_time, service_date)
    end

    def start_time_local
      to_local_from_anchor(start_time, service_date)
    end
  end
end
