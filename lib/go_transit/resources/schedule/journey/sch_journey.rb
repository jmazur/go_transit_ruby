module GoTransit
  class Schedule::Journey::SchJourney < ApiResource
    attr_accessor :date, :time, :to, :from, :services

    def initialize(params)
      super
      propagate_anchor_date
    end

    private

    def propagate_anchor_date
      parsed_date = Date.parse(date)
      services.each do |service|
        service.trips.each do |trip|
          trip.stops.each { |stop| stop.anchor_date = parsed_date }
        end
      end
    end
  end
end
