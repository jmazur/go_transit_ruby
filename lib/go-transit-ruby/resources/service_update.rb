module GoTransit
  class ServiceUpdate
    def self.service_guarentee(trip_number:, operational_day:)
      client = GoTransit::Client.new
      response = client.make_request(
        "ServiceUpdate/ServiceGuarentee/#{trip_number}/#{operational_day}"
      )
      build_objects(response)
    end
  end

  class ServiceUpdate::ServiceAlert
    def self.all
      client = GoTransit::Client.new
      response = client.make_request("ServiceUpdate/ServiceAlert/All")
      build_objects(response)
    end
  end

  class ServiceUpdate::InformationAlert
    def self.all
      client = GoTransit::Client.new
      response = client.make_request("ServiceUpdate/InformationAlert/All")
      build_objects(response)
    end
  end

  class ServiceUpdate::MarketingAlert
    def self.all
      client = GoTransit::Client.new
      response = client.make_request("ServiceUpdate/MarketingAlert/All")
      build_objects(response)
    end
  end

  class ServiceUpdate::UnionDepartures
    def self.all
      client = GoTransit::Client.new
      response = client.make_request("ServiceUpdate/UnionDepartures/All")
      build_objects(response)
    end
  end

  class ServiceUpdate::Exceptions < GoTransit::ApiObject
    def self.train
      client = GoTransit::Client.new
      response = client.make_request("ServiceUpdate/Exceptions/Train")
      build_objects(response)
    end

    def self.bus
      client = GoTransit::Client.new
      response = client.make_request("ServiceUpdate/Exceptions/Bus")
      build_objects(response)
    end

    def self.all
      client = GoTransit::Client.new
      response = client.get("ServiceUpdate/Exceptions/All")
      build_objects(response)
    end
  end
end
