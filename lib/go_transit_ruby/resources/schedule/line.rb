module GoTransit
  class Schedule::Line < ApiResource
    attr_accessor :code, :direction, :display, :stops
  end
end