require "sinatra/base"

class FakeMetrolinx < Sinatra::Base
  set :host_authorization, permitted_hosts: []

  get "/OpenDataAPI/api/V1/NotFound" do
    json_response 404, "error_not_found.json"
  end

  get "/OpenDataAPI/api/V1/NoContent" do
    json_response 200, "error_no_content.json"
  end

  get "/OpenDataAPI/api/V1/Forbidden" do
    json_response 200, "error_forbidden.json"
  end

  get "/OpenDataAPI/api/V1/BadRequest" do
    json_response 200, "error_bad_request.json"
  end

  get "/OpenDataAPI/api/V1/Unauthorized" do
    json_response 200, "error_unauthorized.json"
  end

  get "/OpenDataAPI/api/V1/Stop/All" do
    json_response 200, "stop_all.json"
  end

  get "/OpenDataAPI/api/V1/Stop/Details/:code" do
    json_response 200, "stop_details.json"
  end

  get "/OpenDataAPI/api/V1/Stop/NextService/:code" do
    json_response 200, "stop_next_service.json"
  end

  get "/OpenDataAPI/api/V1/Stop/Destinations/:code/:from/:to" do
    json_response 200, "stop_destinations.json"
  end

  get "/OpenDataAPI/api/V1/ServiceataGlance/Buses/All" do
    json_response 200, "service_at_a_glance_buses.json"
  end

  get "/OpenDataAPI/api/V1/ServiceataGlance/Trains/All" do
    json_response 200, "service_at_a_glance_trains.json"
  end

  get "/OpenDataAPI/api/V1/ServiceataGlance/UPX/All" do
    json_response 200, "service_at_a_glance_upx.json"
  end

  get "/OpenDataAPI/api/V1/ServiceUpdate/ServiceAlert/All" do
    json_response 200, "service_update_service_alert.json"
  end

  get "/OpenDataAPI/api/V1/ServiceUpdate/InformationAlert/All" do
    json_response 200, "service_update_information_alert.json"
  end

  get "/OpenDataAPI/api/V1/ServiceUpdate/MarketingAlert/All" do
    json_response 200, "service_update_marketing_alert.json"
  end

  get "/OpenDataAPI/api/V1/ServiceUpdate/UnionDepartures/All" do
    json_response 200, "service_update_union_departures.json"
  end

  get "/OpenDataAPI/api/V1/ServiceUpdate/ServiceGuarantee/:trip/:date" do
    json_response 200, "service_update_service_guarantee.json"
  end

  get "/OpenDataAPI/api/V1/ServiceUpdate/Exceptions/Train" do
    json_response 200, "service_update_exceptions_train.json"
  end

  get "/OpenDataAPI/api/V1/ServiceUpdate/Exceptions/Bus" do
    json_response 200, "service_update_exceptions_bus.json"
  end

  get "/OpenDataAPI/api/V1/ServiceUpdate/Exceptions/All" do
    json_response 200, "service_update_exceptions_all.json"
  end

  get "/OpenDataAPI/api/V1/Fares/:from/:to/:date" do
    json_response 200, "fares.json"
  end

  get "/OpenDataAPI/api/V1/Schedule/Journey/:date/:from/:to/:start_time/:count" do
    json_response 200, "schedule_journey.json"
  end

  get "/OpenDataAPI/api/V1/Schedule/Line/:date/:line/:direction" do
    json_response 200, "schedule_line.json"
  end

  get "/OpenDataAPI/api/V1/Schedule/Line/All/:date" do
    json_response 200, "schedule_line_all.json"
  end

  get "/OpenDataAPI/api/V1/Schedule/Trip/:date/:trip" do
    json_response 200, "schedule_trip.json"
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + "/fixtures/" + file_name, "rb").read
  end
end
