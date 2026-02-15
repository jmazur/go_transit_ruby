require "json"
require "net/http"

module GoTransit
  class Client
    API_VERSION = "V1".freeze

    def get(path)
      uri = URI("#{GoTransit.base_url}/#{API_VERSION}/#{path}"\
                "?key=#{GoTransit.api_key}")
      response = Net::HTTP.get_response(uri)
      response_code = Net::HTTPResponse::CODE_TO_OBJ[response.code]
      json = JSON.parse(response.body)
      Response.new(json, response_code)
    end
  end
end
