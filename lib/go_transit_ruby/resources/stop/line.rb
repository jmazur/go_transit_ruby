module GoTransit
  class Stop::Line < ApiResource
    attr_accessor :code, :display, :direction, :destination_stop
  end
end