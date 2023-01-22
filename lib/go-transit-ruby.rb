require "net/http"
require "uri"
require "json"
require "active_support/core_ext/string"
require "go-transit-ruby/client"
require "go-transit-ruby/response"
require "go-transit-ruby/api_object"
require "go-transit-ruby/object_types"



# load resources
require "go-transit-ruby/resources/facility"
require "go-transit-ruby/resources/line"
require "go-transit-ruby/resources/link"
require "go-transit-ruby/resources/message"
require "go-transit-ruby/resources/metadata"
require "go-transit-ruby/resources/next_service"
require "go-transit-ruby/resources/parking"
require "go-transit-ruby/resources/place"
require "go-transit-ruby/resources/sch_journey"
require "go-transit-ruby/resources/service"
require "go-transit-ruby/resources/service_update"
require "go-transit-ruby/resources/station"
require "go-transit-ruby/resources/stop"
require "go-transit-ruby/resources/transfer"
require "go-transit-ruby/resources/trip"

module GoTransit
  class << self

  end
end
