module GoTransit
  class Schedule::Line::Trip::Stop < ApiResource
    attr_accessor :code, :order, :time, :sorting_time, :is_major

    def major?
      is_major.to_i.positive?
    end

    def time_utc
      to_utc(time)
    end

    def time_local
      to_local(time)
    end
  end
end