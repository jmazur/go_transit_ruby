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
