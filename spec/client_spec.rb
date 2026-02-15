RSpec.describe GoTransit::Client do
  describe "#get" do
    it "uses a custom url if configured" do
      GoTransit.configure do |config|
        config.custom_base_url = "https://example.com/OpenDataAPI/api"
      end
      client = GoTransit::Client.new
      allow(Net::HTTP).to receive(:get_response).and_call_original

      client.get("Stop/Details/UN")

      expect(Net::HTTP).to have_received(:get_response).
        with(URI.parse("https://example.com/OpenDataAPI/api/V1/Stop/"\
                       "Details/UN?key=")).once
    end

    it "returns a response from the metrolinx API" do
      client = GoTransit::Client.new

      result = client.get("Stop/Details/UN")

      expect(result).to be_kind_of(GoTransit::Response)
    end

    context "when the API returns a non 200 code" do
      it "responds to a 204 error" do
        client = GoTransit::Client.new

        expect {
          client.get("NoContent")
        }.to raise_error(GoTransit::NoContentError)
      end

      it "responds to a 400 error" do
        client = GoTransit::Client.new

        expect {
          client.get("BadRequest")
        }.to raise_error(GoTransit::BadRequestError)
      end

      it "responds to a 401 error" do
        client = GoTransit::Client.new

        expect {
          client.get("Unauthorized")
        }.to raise_error(GoTransit::UnauthorizedError)
      end

      it "responds to a 403 error" do
        client = GoTransit::Client.new

        expect {
          client.get("Forbidden")
        }.to raise_error(GoTransit::ForbiddenError)
      end

      it "responds to a 404 error" do
        client = GoTransit::Client.new

        expect {
          client.get("NotFound")
        }.to raise_error(GoTransit::NotFoundError)
      end

      it "responds to a 426 error" do
        client = GoTransit::Client.new

        expect {
          client.get("NotFound")
        }.to raise_error(GoTransit::NotFoundError)
      end
    end
  end
end
