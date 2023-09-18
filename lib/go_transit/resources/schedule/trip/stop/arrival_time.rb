module GoTransit
  class Schedule::Trip::Stop::ArrivalTime < ApiResource
    attr_accessor :scheduled, :computed, :status

    def scheduled_utc
      to_utc(scheduled)
    end

    def computed_utc
      to_utc(computed)
    end
  end
end
