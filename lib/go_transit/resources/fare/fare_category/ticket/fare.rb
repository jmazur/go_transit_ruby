module GoTransit
  class Fare::FareCategory::Ticket::Fare < ApiResource
    attr_accessor :type, :amount, :category
  end
end