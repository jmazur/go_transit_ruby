RSpec.describe GoTransit::Schedule::Trip::Stop do
  describe "#anchor_date=" do
    it "cascades the anchor date to both arrival_time and departure_time" do
      stop = GoTransit::Schedule::Trip::Stop.new(
        "ArrivalTime" => { "Scheduled" => "14:50", "Computed" => "", "Status" => "" },
        "DepartureTime" => { "Scheduled" => "14:54", "Computed" => "", "Status" => "" },
      )

      stop.anchor_date = Date.new(2026, 1, 1)

      expect(stop.arrival_time.anchor_date).to eq(Date.new(2026, 1, 1))
      expect(stop.departure_time.anchor_date).to eq(Date.new(2026, 1, 1))
    end
  end
end
