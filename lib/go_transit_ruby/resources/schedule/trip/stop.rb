module GoTransit
  class Schedule::Trip::Stop < ApiResource
    include Enumerable

    attr_accessor :arrival_times

    def each(&block)
      arrival_times.each(&block)
    end
  end
end