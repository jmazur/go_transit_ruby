module GoTransit
  class Fare < ApiResource
    include Enumerable

    attr_accessor :fare_categories

    def self.get(from_stop_code:, to_stop_code:, operational_day: nil)
      client = Client.new
      response = client.get("Fares/#{from_stop_code}/#{to_stop_code}/#{operational_day}")
      new(response.data)
    end

    def each(&block)
      fare_categories.each(&block)
    end
  end
end
