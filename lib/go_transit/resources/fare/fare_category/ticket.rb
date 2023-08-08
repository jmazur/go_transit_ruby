module GoTransit
  class Fare::FareCategory::Ticket < ApiResource
    attr_accessor :type, :fares
  end
end