module GoTransit
  class Schedule::Trip::Stop < ApiResource
    attr_accessor :arrival_time, :departure_time, :track, :code, :status,
                  :remark

    def anchor_date=(date)
      arrival_time.anchor_date = date
      departure_time.anchor_date = date
    end
  end
end
