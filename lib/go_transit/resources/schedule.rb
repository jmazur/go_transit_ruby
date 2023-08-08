module GoTransit
  class Schedule < ApiResource
    attr_accessor :lines, :trips

    def self.journey(date:, from_stop_code:, to_stop_code:, start_time:, 
                     max_journey:)
      formatted_date = date.strftime("%Y%m%d")
      client = Client.new
      response = client.get(
        "Schedule/Journey/#{formatted_date}/#{from_stop_code}/" + 
        "#{to_stop_code}/#{start_time}/#{max_journey}"
      )
      Schedule::Journey.new(response.data)
    end

    def self.line(date:, line_code:, line_direction:)
      formatted_date = date.strftime("%Y%m%d")
      client = Client.new
      response = client.get(
        "Schedule/Line/#{formatted_date}/#{line_code}/#{line_direction}"
      )
      new(response.data).lines
    end

    def self.trip(date:, trip_number:)
      client = Client.new
      response = client.get("Schedule/Trip/#{date}/#{trip_number}")
      new(response.data).trips
    end
  end
end
