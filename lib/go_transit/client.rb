require "json"
require "net/http"

module GoTransit
  class Client
    API_VERSION = "V1".freeze

    def get(path)
      uri = URI("#{GoTransit.base_url}/#{API_VERSION}/#{path}"\
                "?key=#{GoTransit.api_key}")
      http_response = Net::HTTP.get_response(uri)
      Response.new(parse_body(http_response), http_response.code.to_i)
    end

    private

    def parse_body(http_response)
      JSON.parse(http_response.body)
    rescue JSON::ParserError
      { "Metadata" => { "ErrorCode" => http_response.code,
                        "ErrorMessage" => http_response.message } }
    end
  end
end
