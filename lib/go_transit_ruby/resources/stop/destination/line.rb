module GoTransit
  class Stop::Destination::Line < ApiResource
    attr_accessor :code, :display, :direction, :destination_stop
  end
end