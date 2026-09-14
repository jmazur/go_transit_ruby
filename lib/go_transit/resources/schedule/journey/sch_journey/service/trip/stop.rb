module GoTransit
  class Schedule::Journey::SchJourney::Service::Trip::Stop < ApiResource
    attr_accessor :code, :order, :time, :sorting_time, :is_major, :anchor_date

    def major?
      is_major.to_i.positive?
    end

    def time_utc
      to_utc_from_anchor(time, anchor_date)
    end

    def time_local
      to_local_from_anchor(time, anchor_date)
    end
  end
end
