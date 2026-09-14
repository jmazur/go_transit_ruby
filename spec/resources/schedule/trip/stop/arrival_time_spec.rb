RSpec.describe GoTransit::Schedule::Trip::Stop::ArrivalTime do
  describe "#scheduled_local" do
    it "stays on the anchor date when the hour is at or after the boundary" do
      arrival_time = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(scheduled: "23:58")
      arrival_time.anchor_date = Date.new(2026, 1, 1)

      result = arrival_time.scheduled_local

      expect(result).to eq(Date.new(2026, 1, 1).in_time_zone("America/Toronto") + 23.hours + 58.minutes)
    end

    it "rolls forward to the next day when the hour is before the boundary" do
      arrival_time = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(scheduled: "00:04")
      arrival_time.anchor_date = Date.new(2026, 1, 1)

      result = arrival_time.scheduled_local

      expect(result).to eq(Date.new(2026, 1, 2).in_time_zone("America/Toronto") + 4.minutes)
    end

    it "rolls forward even when it is the trip's very first stop, with no prior stop to compare against" do
      # This is the whole point of a fixed boundary hour rather than
      # sequence-based rollover detection: a trip whose first stop is
      # already in the "overnight tail" of the previous service date
      # rolls forward correctly with no other stop involved at all.
      arrival_time = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(scheduled: "01:00")
      arrival_time.anchor_date = Date.new(2026, 1, 1)

      result = arrival_time.scheduled_local

      expect(result.to_date).to eq(Date.new(2026, 1, 2))
    end

    it "honors a custom service_day_boundary_hour" do
      original_boundary_hour = GoTransit.service_day_boundary_hour
      GoTransit.service_day_boundary_hour = 3
      arrival_time = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(scheduled: "03:30")
      arrival_time.anchor_date = Date.new(2026, 1, 1)

      result = arrival_time.scheduled_local

      expect(result.to_date).to eq(Date.new(2026, 1, 1))
    ensure
      GoTransit.service_day_boundary_hour = original_boundary_hour
    end

    it "returns nil when the underlying field is blank" do
      arrival_time = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(scheduled: "")
      arrival_time.anchor_date = Date.new(2026, 1, 1)

      expect(arrival_time.scheduled_local).to be_nil
    end

    it "raises MissingAnchorDateError when anchor_date was never assigned" do
      arrival_time = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(scheduled: "14:54")

      expect { arrival_time.scheduled_local }.
        to raise_error(GoTransit::MissingAnchorDateError)
    end
  end

  describe "#scheduled_utc" do
    it "converts the resolved local time to UTC" do
      arrival_time = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(scheduled: "14:54")
      arrival_time.anchor_date = Date.new(2026, 1, 1)

      result = arrival_time.scheduled_utc

      expect(result).to eq(Date.new(2026, 1, 1).in_time_zone("America/Toronto").utc + 14.hours + 54.minutes)
    end
  end

  describe "#computed_local and #computed_utc" do
    it "resolve the same way as scheduled, independently" do
      arrival_time = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(scheduled: "14:54", computed: "15:01")
      arrival_time.anchor_date = Date.new(2026, 1, 1)

      expect(arrival_time.computed_local.strftime("%H:%M")).to eq("15:01")
      expect(arrival_time.computed_utc).to eq(arrival_time.computed_local.utc)
    end
  end
end
