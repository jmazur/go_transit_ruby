module GoTransit
  class ServiceUpdate::UnionDepartures::Trip < ApiResource
    attr_accessor :info, :trip_number, :platform, :service, :service_type,
                  :time, :stops

    def platforms
      return if platform == "-"
      platform.split("&").collect(&:strip)
    end

    def time_utc
      to_utc(time)
    end

    def time_local
      to_local(time)
    end
  end
end
