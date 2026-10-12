RSpec.describe GoTransit::Response do
  describe "#initialize" do
    it "assigns the response metadata" do
      response = GoTransit::Response.new(stubbed_response)

      expect(response.metadata).to be_a(GoTransit::Metadata)
    end

    it "loads the response content into data" do
      response = GoTransit::Response.new(stubbed_response)

      expect(response.data).to eq(stubbed_data)
    end

    it "keeps the whole payload of a GTFS Realtime feed in data" do
      payload = { "header" => { "timestamp" => 1 }, "entity" => [{ "id" => "1" }] }

      response = GoTransit::Response.new(payload.dup, 200)

      expect(response.data).to eq(payload)
    end

    it "still raises for an error body from a GTFS Realtime path" do
      payload = { "Metadata" => { "ErrorCode" => "404", "ErrorMessage" => "Not Found" } }

      expect { GoTransit::Response.new(payload, 404) }.
        to raise_error(GoTransit::NotFoundError)
    end

    it "raises TooManyRequestsError when the http_status is 429" do
      expect {
        GoTransit::Response.new(stubbed_response, 429)
      }.to raise_error(GoTransit::TooManyRequestsError)
    end

    it "raises TooManyRequestsError when the metadata error code is 429" do
      expect {
        GoTransit::Response.new(stubbed_too_many_requests_response)
      }.to raise_error(GoTransit::TooManyRequestsError)
    end

    it "raises TooManyRequestsError when the body has no Metadata key" do
      expect {
        GoTransit::Response.new({ "message" => "Too Many Requests" }, 429)
      }.to raise_error(GoTransit::TooManyRequestsError)
    end
  end

  def stubbed_response
    json = <<~EOS
      {
        "Metadata": {
          "TimeStamp": "2023-01-18 02:28:40",
          "ErrorCode": "200",
          "ErrorMessage": "No Content"
        },
        "Trip": [{
          "TripNumber": "E6333Q",
          "TripName": "",
          "IsCancelled": "1",
          "IsOverride": "1",
          "Stop": []
        }]
      }
    EOS
    JSON.parse(json)
  end

  def stubbed_too_many_requests_response
    json = <<~EOS
      {
        "Metadata": {
          "TimeStamp": "2023-01-18 02:28:40",
          "ErrorCode": "429",
          "ErrorMessage": "Too Many Requests"
        }
      }
    EOS
    JSON.parse(json)
  end

  def stubbed_data
    json = <<~EOS
      {
        "Trip": [{
          "TripNumber": "E6333Q",
          "TripName": "",
          "IsCancelled": "1",
          "IsOverride": "1",
          "Stop": []
        }]
      }
    EOS
    JSON.parse(json)
  end
end
