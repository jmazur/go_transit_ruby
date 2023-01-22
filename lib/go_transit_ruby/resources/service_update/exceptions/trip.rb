module GoTransit
  class ServiceUpdate::Exceptions::Trip < ApiResource
    attr_accessor :trip_number, :trip_name, :is_cancelled, :is_override, 
                  :stops

    def cancelled?
      is_cancelled.to_i.positive?
    end

    def override?
      is_override.to_i.positive?
    end
  end
end