module GoTransit
  class Schedule::Line::Trip::Stop < ApiResource
    attr_accessor :code, :order, :time, :sorting_time, :is_major

    def major?
      is_major.to_i.positive?
    end
  end
end