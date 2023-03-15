module GoTransit
  class Schedule::AllLines::Line < ApiResource
    attr_accessor :name, :code, :is_bus, :is_train, :variants
  end
end