RSpec.describe GoTransit::Schedule::Trip::Stop::DepartureTime do
  describe "#scheduled_local and #scheduled_utc" do
    it "resolve using the assigned anchor_date, same as ArrivalTime" do
      departure_time = GoTransit::Schedule::Trip::Stop::DepartureTime.new(scheduled: "00:04")
      departure_time.anchor_date = Date.new(2026, 1, 1)

      expect(departure_time.scheduled_local.to_date).to eq(Date.new(2026, 1, 2))
      expect(departure_time.scheduled_utc).to eq(departure_time.scheduled_local.utc)
    end
  end

  describe "#computed_local and #computed_utc" do
    it "resolve independently of scheduled" do
      departure_time = GoTransit::Schedule::Trip::Stop::DepartureTime.new(computed: "14:54")
      departure_time.anchor_date = Date.new(2026, 1, 1)

      expect(departure_time.computed_local.strftime("%H:%M")).to eq("14:54")
    end
  end

  describe "without an anchor_date" do
    it "raises MissingAnchorDateError" do
      departure_time = GoTransit::Schedule::Trip::Stop::DepartureTime.new(scheduled: "14:54")

      expect { departure_time.scheduled_local }.
        to raise_error(GoTransit::MissingAnchorDateError)
    end
  end
end
