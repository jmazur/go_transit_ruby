module GoTransit::Resource::ServiceUpdate::Exception
  class Stop < GoTransit::ApiObject
    attr_reader :order, :id, :sch_arrival, :sch_departure, :name, :is_stopping,
                :is_cancelled, :is_override, :code, :actual_time, :service_type
  end
end
