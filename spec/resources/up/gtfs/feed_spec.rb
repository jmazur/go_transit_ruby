RSpec.describe GoTransit::UP::Gtfs::Feed do
  it "is a Gtfs feed" do
    expect(GoTransit::UP::Gtfs::Feed.ancestors).
      to include(GoTransit::Gtfs::Feed)
  end

  describe ".vehicle_position" do
    it "is a feed of UP vehicle positions" do
      feed = GoTransit::UP::Gtfs::Feed.vehicle_position

      expect(feed.first).to be_kind_of(GoTransit::Gtfs::FeedEntity)
      expect(feed.first.vehicle.trip.route_id).to eq("UP")
      expect(feed.first.vehicle.timestamp_utc).to be_kind_of(Time)
    end
  end

  describe ".trip_updates" do
    it "is a feed of UP trip updates" do
      feed = GoTransit::UP::Gtfs::Feed.trip_updates

      expect(feed.first.trip_update.stop_time_updates.first.departure.delay).
        to eq(0)
    end
  end

  describe ".alerts" do
    it "is a feed of UP alerts" do
      feed = GoTransit::UP::Gtfs::Feed.alerts

      expect(feed.first.alert.header_text.translations.first.language).
        to eq("en")
    end
  end
end
