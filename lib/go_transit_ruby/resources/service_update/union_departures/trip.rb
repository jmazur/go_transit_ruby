module GoTransit
  class ServiceUpdate::UnionDepartures::Trip < ApiResource
    attr_accessor :info, :trip_number, :platform, :service, :service_type,
                  :time, :stops
  end
end