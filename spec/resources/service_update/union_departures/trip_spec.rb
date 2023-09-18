RSpec.describe GoTransit::ServiceUpdate::UnionDepartures::Trip do
  describe "#platforms" do
    it "returns an array of platforms" do
      trip = GoTransit::ServiceUpdate::UnionDepartures::Trip.new(
        platform: "9 & 10"
      )

      expect(trip.platforms).to eq(["9", "10"])
    end
  end

  describe "#time_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::ServiceUpdate::UnionDepartures::Trip.new(
          time: toronto_time
        )

        result = service.time_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end
end
