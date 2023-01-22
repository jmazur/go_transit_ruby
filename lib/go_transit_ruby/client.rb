require "json"
require "net/http"

module GoTransit
  class Client
    BASE_URL = "http://api.openmetrolinx.com/OpenDataAPI/api".freeze
    API_VERSION = "V1".freeze

    def get(path)
      uri = URI("#{BASE_URL}/#{API_VERSION}/#{path}?key=#{GoTransit.api_key}")
      response = Net::HTTP.get_response(uri)
      json = JSON.parse(response.body)
      Response.new(json)
    end
  end
end
