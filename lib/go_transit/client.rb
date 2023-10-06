require "json"
require "net/http"

module GoTransit
  class Client
    API_VERSION = "V1".freeze

    def get(path)
      uri = URI("#{GoTransit.base_url}/#{API_VERSION}/#{path}"\
                "?key=#{GoTransit.api_key}")
      response = Net::HTTP.get_response(uri)
      json = JSON.parse(response.body)
      Response.new(json)
    end
  end
end
