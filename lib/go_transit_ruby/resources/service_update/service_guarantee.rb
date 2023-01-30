module GoTransit
  class ServiceUpdate::ServiceGuarantee < ApiResource
    include Enumerable

    attr_accessor :stops

    def each(&block)
      stops.each(&block)
    end
  end
end