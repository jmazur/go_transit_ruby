module GoTransit
  class Schedule::Line::Trip < ApiResource
    attr_accessor :number, :display, :stops
  end
end