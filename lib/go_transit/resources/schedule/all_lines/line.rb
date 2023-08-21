module GoTransit
  class Schedule::AllLines::Line < ApiResource
    attr_accessor :name, :code, :is_bus, :is_train, :variants

    def train?
      is_train == true
    end

    def bus?
      is_bus == true
    end
  end
end
