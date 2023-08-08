module GoTransit
  class ServiceUpdate < ApiResource
    include Enumerable

    attr_accessor :messages

    def self.service_alerts
      client = Client.new
      response = client.get("ServiceUpdate/ServiceAlert/All")
      new(response.data)
    end

    def self.information_alerts
      client = Client.new
      response = client.get("ServiceUpdate/InformationAlert/All")
      new(response.data)
    end

    def self.marketing_alerts
      client = Client.new
      response = client.get("ServiceUpdate/MarketingAlert/All")
      new(response.data)
    end

    def self.union_departures
      client = Client.new
      response = client.get("ServiceUpdate/UnionDepartures/All")
      ServiceUpdate::UnionDepartures.new(response.data)
    end

    def self.service_guarantee(trip_number:, operational_day:)
      client = Client.new
      response = client.get("ServiceUpdate/ServiceGuarantee/#{trip_number}/#{operational_day}")
      ServiceUpdate::ServiceGuarantee.new(response.data)
    end

    def each(&block)
      messages.each(&block)
    end
  end
end
