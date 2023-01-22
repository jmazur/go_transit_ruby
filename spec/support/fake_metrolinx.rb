require "sinatra/base"

class FakeMetrolinx < Sinatra::Base
  get "/OpenDataAPI/api/V1/Error" do
    json_response 404, "error.json"
  end

  get "/OpenDataAPI/api/V1/ServiceUpdate/ServiceGuarentee/:trip/:date" do
    json_response 200, "service_guarentee.json"
  end

  private

  def json_response(response_code, file_name)
    content_type :json
    status response_code
    File.open(File.dirname(__FILE__) + "/fixtures/" + file_name, "rb").read
  end
end
