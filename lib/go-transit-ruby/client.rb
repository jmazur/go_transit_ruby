require "json"
require "net/http"

module GoTransit
  class Client
    BASE_URL = "http://api.openmetrolinx.com/OpenDataAPI/api".freeze
    API_VERSION = "V1".freeze

    def initialize(access_token = "30022164")
      @access_token = access_token || ENV["GO_TRANSIT_TOKEN"]
    end

    def get(path)
      uri = URI("#{BASE_URL}/#{API_VERSION}/#{path}?key=#{access_token}")
      response = Net::HTTP.get_response(uri)
      json = JSON.parse(response.body)
      if response.code != "200"
        raise StandardError.new(json["Metadata"]["ErrorMessage"])
      end
      json
      # convert hash keys to snake case symbols
    end

    private

    attr_reader :access_token
  end
end
