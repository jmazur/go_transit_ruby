RSpec.describe GoTransit::Schedule::Journey::SchJourney::Service::Trip::Stop do
  describe "#major?" do
    context "when is_major is 1" do
      it "is major" do
        stop = GoTransit::Schedule::Journey::SchJourney::Service::Trip::Stop.new(
          is_major: "1"
        )

        expect(stop).to be_major
      end
    end

    context "when is_major is not 1" do
      it "is not major" do
        stop = GoTransit::Schedule::Journey::SchJourney::Service::Trip::Stop.new(
          is_major: "0"
        )

        expect(stop).not_to be_major
      end
    end
  end

  describe "#time_local and #time_utc" do
    it "resolve using the assigned anchor_date" do
      stop = GoTransit::Schedule::Journey::SchJourney::Service::Trip::Stop.new(time: "07:00")
      stop.anchor_date = Date.new(2026, 1, 1)

      expect(stop.time_local.to_date).to eq(Date.new(2026, 1, 1))
      expect(stop.time_utc).to eq(stop.time_local.utc)
    end

    it "rolls forward past the boundary hour, same rule as Schedule::Trip's stops" do
      stop = GoTransit::Schedule::Journey::SchJourney::Service::Trip::Stop.new(time: "00:15")
      stop.anchor_date = Date.new(2026, 1, 1)

      expect(stop.time_local.to_date).to eq(Date.new(2026, 1, 2))
    end

    it "raises MissingAnchorDateError when anchor_date was never assigned" do
      stop = GoTransit::Schedule::Journey::SchJourney::Service::Trip::Stop.new(time: "07:00")

      expect { stop.time_local }.to raise_error(GoTransit::MissingAnchorDateError)
    end
  end
end
