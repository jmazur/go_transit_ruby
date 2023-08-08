module GoTransit
  class Schedule::Line < ApiResource
    attr_accessor :code, :direction, :type, :trips
  end
end