module GoTransit
  class ServiceUpdate::UnionDepartures < ApiResource
    include Enumerable

    attr_accessor :trips

    def each(&block)
      trips.each(&block)
    end
  end
end