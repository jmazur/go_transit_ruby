require "net/http"
require "uri"
require "json"
require "active_support"
require "active_support/core_ext"
require "active_support/core_ext/string"

require "go_transit/client"
require "go_transit/errors"
require "go_transit/response"
require "go_transit/api_resource"
require "go_transit/resources/metadata"
require "go_transit/resources/stop"
require "go_transit/resources/stop/station"
require "go_transit/resources/stop/next_service"
require "go_transit/resources/stop/next_service/line"
require "go_transit/resources/stop/line"
require "go_transit/resources/stop/facility"
require "go_transit/resources/stop/parking"
require "go_transit/resources/stop/place"
require "go_transit/resources/stop/place/stop"
require "go_transit/resources/stop/destination"
require "go_transit/resources/stop/destination/line"
require "go_transit/resources/service_at_a_glance"
require "go_transit/resources/service_at_a_glance/trip"
require "go_transit/resources/service_update"
require "go_transit/resources/service_update/message"
require "go_transit/resources/service_update/message/line"
require "go_transit/resources/service_update/message/stop"
require "go_transit/resources/service_update/message/trip"
require "go_transit/resources/service_update/union_departures"
require "go_transit/resources/service_update/union_departures/trip"
require "go_transit/resources/service_update/union_departures/trip/stop"
require "go_transit/resources/service_update/service_guarantee"
require "go_transit/resources/service_update/service_guarantee/stop"
require "go_transit/resources/service_update/exceptions"
require "go_transit/resources/service_update/exceptions/trip"
require "go_transit/resources/service_update/exceptions/trip/stop"
require "go_transit/resources/fare"
require "go_transit/resources/fare/fare_category"
require "go_transit/resources/fare/fare_category/ticket"
require "go_transit/resources/fare/fare_category/ticket/fare"
require "go_transit/resources/schedule"
require "go_transit/resources/schedule/trip"
require "go_transit/resources/schedule/trip/stop"
require "go_transit/resources/schedule/trip/stop/arrival_time"
require "go_transit/resources/schedule/trip/stop/departure_time"
require "go_transit/resources/schedule/trip/stop/track"
require "go_transit/resources/schedule/line"
require "go_transit/resources/schedule/line/trip"
require "go_transit/resources/schedule/line/trip/stop"
require "go_transit/resources/schedule/all_lines"
require "go_transit/resources/schedule/all_lines/line"
require "go_transit/resources/schedule/all_lines/line/variant"
require "go_transit/resources/schedule/journey"
require "go_transit/resources/schedule/journey/sch_journey"
require "go_transit/resources/schedule/journey/sch_journey/service"
require "go_transit/resources/schedule/journey/sch_journey/service/link"
require "go_transit/resources/schedule/journey/sch_journey/service/transfer"
require "go_transit/resources/schedule/journey/sch_journey/service/trip"
require "go_transit/resources/schedule/journey/sch_journey/service/trip/stop"

module GoTransit
  @api_key = ""

  class << self
    attr_accessor :api_key, :custom_base_url

    def configure
      yield self
    end

    def base_url
      custom_base_url || "https://api.openmetrolinx.com/OpenDataAPI/api"
    end
  end
end
