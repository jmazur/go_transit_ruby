module GoTransit
  class Schedule::Journey < ApiResource
    include Enumerable

    attr_accessor :sch_journeys

    def each(&block)
      sch_journeys.each(&block)
    end
  end
end