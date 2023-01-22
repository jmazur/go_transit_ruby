module GoTransit::ServiceUpdate
  class Exception < GoTransit::ApiObject
    URI = "ServiceUpdate/Exceptions".freeze
    RESOURCE_MODULE = "GoTransit::Resource::ServiceUpdate::Exception".freeze

    attr_reader :trips

    def initialize(params)
      @resource_module = RESOURCE_MODULE
      super
    end

    def self.train
      client = GoTransit::Client.new
      response = client.get("#{URI}/Train")
      self.new(response)
    end

    def self.bus
      client = GoTransit::Client.new
      response = client.get("#{URI}/Bus")
      self.new(response)
    end

    def self.all
      client = GoTransit::Client.new
      response = client.get("#{URI}/All")
      self.new(response)
    end
  end
end
