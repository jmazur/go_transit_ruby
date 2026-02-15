require "json"
require "net/http"

module GoTransit
  class Client
    API_VERSION = "V1".freeze

    def get(path)
      uri = URI("#{GoTransit.base_url}/#{API_VERSION}/#{path}"\
                "?key=#{GoTransit.api_key}")
      response = Net::HTTP.get_response(uri)
      log response
      json = JSON.parse(response.body)
      Response.new(json)
    end

    private

    def log(response)
      return unless GoTransit.log_response
      GoTransit.logger.debug "[HTTP Response #{response.code}]"
      GoTransit.logger.debug response.body
    end
  end
end
