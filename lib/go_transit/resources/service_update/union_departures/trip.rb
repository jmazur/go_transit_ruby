module GoTransit
  class ServiceUpdate::UnionDepartures::Trip < ApiResource
    attr_accessor :info, :trip_number, :platform, :service, :service_type,
                  :time, :stops

    def platforms
      platform.split("&").collect(&:strip)
    end

    def time_utc
      to_utc(time)
    end
  end
end
