RSpec.describe GoTransit::Response do
  describe "#initialize" do
    it "assigns the response metadata" do
      response = GoTransit::Response.new(stubbed_response)

      expect(response.metadata).to be_a(GoTransit::Metadata)
    end

    it "builds the appropriate objects to data" do
      response = GoTransit::Response.new(stubbed_response)

      expect(response.data).to all(be_a(GoTransit::Trip))
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
end
