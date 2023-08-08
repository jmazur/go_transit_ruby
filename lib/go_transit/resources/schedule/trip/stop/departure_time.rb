module GoTransit
  class Schedule::Trip::Stop::DepartureTime < ApiResource
    attr_accessor :scheduled, :computed, :status
  end
end