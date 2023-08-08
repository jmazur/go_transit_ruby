module GoTransit
  class Schedule::AllLines < ApiResource
    include Enumerable

    attr_accessor :lines

    def self.all(date:)
      formatted_date = date.strftime("%Y%m%d")
      client = Client.new
      response = client.get("Schedule/Line/All/#{formatted_date}")
      new(response.data)
    end

    def each(&block)
      lines.each(&block)
    end
  end
end