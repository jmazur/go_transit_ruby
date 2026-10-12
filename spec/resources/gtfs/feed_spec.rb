RSpec.describe GoTransit::Gtfs::Feed do
  describe ".vehicle_position" do
    it "is a feed of entities" do
      feed = GoTransit::Gtfs::Feed.vehicle_position

      expect(feed.first).to be_kind_of(GoTransit::Gtfs::FeedEntity)
      expect(feed.count).to eq(3)
    end

    it "has the feed header" do
      header = GoTransit::Gtfs::Feed.vehicle_position.header

      expect(header.gtfs_realtime_version).to eq("2.0")
      expect(header.incrementality).to eq("FULL_DATASET")
    end

    it "has the vehicle position of each entity" do
      vehicle = GoTransit::Gtfs::Feed.vehicle_position.first.vehicle

      expect(vehicle.position.latitude).to be_kind_of(Float)
      expect(vehicle.position.longitude).to be_kind_of(Float)
      expect(vehicle.vehicle.label).to include("LW")
      expect(vehicle.trip.route_id).to end_with("-LW")
      expect(vehicle.current_status).to eq("IN_TRANSIT_TO")
    end

    it "leaves the other halves of the entity nil" do
      entity = GoTransit::Gtfs::Feed.vehicle_position.first

      expect(entity.trip_update).to be_nil
      expect(entity.alert).to be_nil
    end

    it "keeps non train entities (the feed includes buses)" do
      ids = GoTransit::Gtfs::Feed.vehicle_position.map(&:id)

      expect(ids).to include("20261011-33-33750")
    end

    it "converts the timestamp to UTC and Toronto time" do
      vehicle = GoTransit::Gtfs::Feed.vehicle_position.first.vehicle

      expect(vehicle.timestamp_utc).to eq(Time.at(vehicle.timestamp).utc)
      expect(vehicle.timestamp_local.zone).to eq("EDT")
      expect(vehicle.timestamp_local.utc_offset).to eq(-4 * 3600)
      expect(vehicle.timestamp_local).to eq(vehicle.timestamp_utc)
    end

    it "converts the feed header timestamp" do
      header = GoTransit::Gtfs::Feed.vehicle_position.header

      expect(header.timestamp_utc).to eq(Time.at(header.timestamp).utc)
    end
  end

  describe ".trip_updates" do
    it "has the stop time updates of each entity" do
      update = GoTransit::Gtfs::Feed.trip_updates.first.trip_update

      stop = update.stop_time_updates.first
      expect(stop.stop_id).to be_kind_of(String)
      expect(stop.departure.delay).to be_kind_of(Integer)
      expect(stop.departure.time_utc).to eq(Time.at(stop.departure.time).utc)
      expect(stop.arrival).to be_nil
    end

    it "has the trip and vehicle descriptors" do
      update = GoTransit::Gtfs::Feed.trip_updates.first.trip_update

      expect(update.trip.trip_id).to eq("20261011-LW-1981")
      expect(update.vehicle.id).to be_kind_of(String)
      expect(update.timestamp_utc).to eq(Time.at(update.timestamp).utc)
    end
  end

  describe ".alerts" do
    it "has an alert with its own translations for each text field" do
      alert = GoTransit::Gtfs::Feed.alerts.first.alert

      expect(alert.url.translations.first.text).to start_with("https://")
      expect(alert.header_text.translations.map(&:language)).to eq(%w[en fr])
      expect(alert.description_text.translations.first.language).to eq("en")
      expect(alert.url.translations).not_to eq(alert.header_text.translations)
    end

    it "has active periods and informed entities" do
      alert = GoTransit::Gtfs::Feed.alerts.first.alert

      period = alert.active_periods.first
      expect(period.start_utc).to eq(Time.at(period.start).utc)
      expect(period.end_utc).to eq(Time.at(period.end).utc)
      expect(alert.informed_entities.first.stop_id).to be_kind_of(String)
      expect(alert.informed_entities.first.trip).to be_nil
    end
  end

  describe "trip descriptor times" do
    def trip(start_time, start_date: "20261011")
      GoTransit::Gtfs::TripDescriptor.new(
        "trip_id" => "x", "route_id" => "LW", "direction_id" => 1,
        "start_time" => start_time, "start_date" => start_date,
        "schedule_relationship" => "SCHEDULED",
      )
    end

    it "anchors the bare start time on the start date" do
      expect(trip("19:22:00").start_time_utc).
        to eq(Time.utc(2026, 10, 11, 23, 22))
    end

    it "puts a start time after midnight on the next day" do
      expect(trip("01:30:00").start_time_local.to_s).
        to start_with("2026-10-12 01:30:00")
    end

    it "gives the service date" do
      expect(trip("19:22:00").service_date).to eq(Date.new(2026, 10, 11))
    end

    it "has no times when the start time is blank" do
      expect(trip("").start_time_utc).to be_nil
    end

    it "raises without a start date" do
      expect { trip("19:22:00", start_date: nil).start_time_utc }.
        to raise_error(GoTransit::MissingAnchorDateError)
    end
  end

  describe "informed entity trips" do
    it "hydrates a trip descriptor when an alert names one" do
      entity = GoTransit::Gtfs::EntitySelector.new(
        "agency_id" => "", "route_id" => "", "route_type" => 0, "stop_id" => "",
        "trip" => { "trip_id" => "20261011-LW-1981", "route_id" => "LW",
                    "direction_id" => 1, "start_time" => "19:22:00",
                    "start_date" => "20261011",
                    "schedule_relationship" => "SCHEDULED" },
      )

      expect(entity.trip.trip_id).to eq("20261011-LW-1981")
    end
  end
end
