module GoTransit::Resource::ServiceUpdate::Exception
  class Trip < GoTransit::ApiObject
    RESOURCE_MODULE = "GoTransit::Resource::ServiceUpdate::Exception".freeze

    attr_reader :trip_number, :trip_name, :is_cancelled, :is_override, :stops

    def initialize(params)
      @resource_module = RESOURCE_MODULE
      super
    end
  end
end
