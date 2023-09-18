module GoTransit
  class ServiceUpdate::Exceptions::Trip::Stop < ApiResource
    attr_accessor :order, :id, :sch_arrival, :sch_departure, :name,
                  :is_stopping, :is_cancelled, :is_override, :code,
                  :actual_time, :service_type

    def stopping?
      is_stopping.to_i.positive?
    end

    def cancelled?
      is_cancelled.to_i.positive?
    end

    def override?
      is_override.to_i.positive?
    end
  end
end
