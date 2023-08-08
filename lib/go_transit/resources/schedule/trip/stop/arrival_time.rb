module GoTransit
  class Schedule::Trip::Stop::ArrivalTime < ApiResource
    attr_accessor :scheduled, :computed, :status
  end
end