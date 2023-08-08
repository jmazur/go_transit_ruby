module GoTransit
  class ServiceAtAGlance < ApiResource
    include Enumerable

    attr_accessor :trips

    def self.buses
      client = Client.new
      response = client.get("ServiceataGlance/Buses/All")
      new(response.data)
    end

    def self.trains
      client = Client.new
      response = client.get("ServiceataGlance/Trains/All")
      new(response.data)
    end

    def self.upx
      client = Client.new
      response = client.get("ServiceataGlance/UPX/All")
      new(response.data)
    end

    def each(&block)
      trips.each(&block)
    end
  end
end