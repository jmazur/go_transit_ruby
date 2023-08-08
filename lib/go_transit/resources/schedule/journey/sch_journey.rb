module GoTransit
  class Schedule::Journey::SchJourney < ApiResource
    attr_accessor :date, :time, :to, :from, :services
  end
end