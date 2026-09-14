module GoTransit
  class Schedule::Trip::Stop::ArrivalTime < ApiResource
    attr_accessor :scheduled, :computed, :status, :anchor_date

    def scheduled_utc
      to_utc_from_anchor(scheduled, anchor_date)
    end

    def scheduled_local
      to_local_from_anchor(scheduled, anchor_date)
    end

    def computed_utc
      to_utc_from_anchor(computed, anchor_date)
    end

    def computed_local
      to_local_from_anchor(computed, anchor_date)
    end
  end
end
