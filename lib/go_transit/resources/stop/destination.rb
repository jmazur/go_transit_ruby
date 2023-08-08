module GoTransit
  class Stop::Destination < ApiResource
    include Enumerable

    attr_accessor :code, :name, :lines

    def each(&block)
      lines.each(&block)
    end
  end
end