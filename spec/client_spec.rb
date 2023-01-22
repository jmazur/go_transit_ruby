RSpec.describe GoTransit::Client do
  describe "#make_request" do
    it "returns a parsed json response from the metrolinx API" do
      client = GoTransit::Client.new("fake_token")

      result = client.get("/ServiceUpdate/ServiceGuarentee/1010/2023-01-01")

      expect(result["Metadata"]["ErrorMessage"]).to eq("OK")
    end

    context "when the API returns an arror" do
      it "raises an error with the api error message" do
        client = GoTransit::Client.new("fake_token")

        expect {
          client.get("/OpenDataAPI/api/V1/Error")
        }.to raise_error(StandardError)
      end
    end
  end
end
