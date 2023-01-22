module GoTransit
  class Schedule < ApiResource
    def self.journey(date:, from_stop_code:, to_stop_code:, start_time:, max_journey:)
      client = Client.new
      response = client.get("Schedule/Journey/#{date}/#{from_stop_code}/#{to_stop_code}/#{start_time}/#{max_journey}")
      Schedule::Journey.new(response.data)
    end

    def self.line(date:, line_code:, line_direction:)
      client = Client.new
      response = client.get("Schedule/Line/#{date}/#{line_code}/#{line_direction}")
      Schedule::Line.new(response.data)
    end

    def self.trip(date:, trip_number:)
      client = Client.new
      response = client.get("Schedule/Trip/#{date}/#{trip_number}")
      Schedule::Trip.new(response.data)
    end
  end
end
