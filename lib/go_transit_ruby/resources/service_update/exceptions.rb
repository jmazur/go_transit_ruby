module GoTransit
  class ServiceUpdate::Exceptions < ApiResource
    include Enumerable

    attr_accessor :trips

    def self.train
      client = Client.new
      response = client.get("ServiceUpdate/Exceptions/Train")
      new(response.data)
    end

    def self.bus
      client = Client.new
      response = client.get("ServiceUpdate/Exceptions/Bus")
      new(response.data)
    end

    def self.all
      client = Client.new
      response = client.get("ServiceUpdate/Exceptions/All")
      new(response.data)
    end

    def each(&block)
      trips.each(&block)
    end
  end
end