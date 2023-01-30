module GoTransit
  class Schedule::Line::Stop < ApiResource
    attr_accessor :code, :order, :name, :type, :is_major

    def major?
      is_major.to_i.positive?
    end
  end
end