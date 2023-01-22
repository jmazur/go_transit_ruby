module GoTransit
  class Schedule::Journey::SchJourney::Service::Trip::Stop < ApiResource
    attr_accessor :code, :order, :time, :sorting_time, :is_major

    def major?
      is_major.to_i.positive?
    end
  end
end