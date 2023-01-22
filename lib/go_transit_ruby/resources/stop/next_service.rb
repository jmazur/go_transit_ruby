module GoTransit
  class Stop::NextService < ApiResource
    include Enumerable
    
    attr_accessor :lines

    def each(&block)
      lines.each(&block)
    end
  end
end
