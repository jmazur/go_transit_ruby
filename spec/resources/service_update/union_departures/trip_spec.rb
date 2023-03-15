RSpec.describe GoTransit::ServiceUpdate::UnionDepartures::Trip do
  describe "#platforms" do
    it "returns an array of platforms" do
      trip = GoTransit::ServiceUpdate::UnionDepartures::Trip.new(
        platform: "9 & 10"
      )

      expect(trip.platforms).to eq(["9", "10"])
    end
  end
end
