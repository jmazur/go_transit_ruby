RSpec.describe "shared GTFS Realtime objects" do
  let(:vehicles) { GoTransit::Gtfs::Feed.vehicle_position.map(&:vehicle) }
  let(:updates) { GoTransit::Gtfs::Feed.trip_updates.map(&:trip_update) }
  let(:alerts) { GoTransit::Gtfs::Feed.alerts.map(&:alert) }

  it "builds a VehiclePosition, TripUpdate and Alert for each kind of entity" do
    expect(vehicles).to all(be_kind_of(GoTransit::Gtfs::VehiclePosition))
    expect(updates).to all(be_kind_of(GoTransit::Gtfs::TripUpdate))
    expect(alerts).to all(be_kind_of(GoTransit::Gtfs::Alert))
  end

  it "uses one TripDescriptor for a vehicle's trip, an update's trip and an alert's trip" do
    selector = GoTransit::Gtfs::EntitySelector.new("trip" => { "trip_id" => "x", "start_date" => "20261011" })

    expect(vehicles.first.trip).to be_kind_of(GoTransit::Gtfs::TripDescriptor)
    expect(updates.first.trip).to be_kind_of(GoTransit::Gtfs::TripDescriptor)
    expect(selector.trip).to be_kind_of(GoTransit::Gtfs::TripDescriptor)
  end

  it "uses one VehicleDescriptor for a vehicle position and a trip update" do
    expect(vehicles.first.vehicle).to be_kind_of(GoTransit::Gtfs::VehicleDescriptor)
    expect(updates.first.vehicle).to be_kind_of(GoTransit::Gtfs::VehicleDescriptor)
  end

  it "uses one StopTimeEvent for an arrival and a departure" do
    stop = updates.first.stop_time_updates.first

    expect(stop).to be_kind_of(GoTransit::Gtfs::StopTimeUpdate)
    expect(stop.departure).to be_kind_of(GoTransit::Gtfs::StopTimeEvent)
  end

  it "uses one Position, TimeRange, EntitySelector and TranslatedString" do
    alert = alerts.first

    expect(vehicles.first.position).to be_kind_of(GoTransit::Gtfs::Position)
    expect(alert.active_periods.first).to be_kind_of(GoTransit::Gtfs::TimeRange)
    expect(alert.informed_entities.first).to be_kind_of(GoTransit::Gtfs::EntitySelector)
    expect([alert.url, alert.header_text, alert.description_text]).
      to all(be_kind_of(GoTransit::Gtfs::TranslatedString))
    expect(alert.header_text.translations.first).to be_kind_of(GoTransit::Gtfs::TranslatedString::Translation)
  end

  it "uses the same classes for the UP feeds" do
    up_vehicle = GoTransit::UP::Gtfs::Feed.vehicle_position.first.vehicle
    up_update = GoTransit::UP::Gtfs::Feed.trip_updates.first.trip_update
    up_alert = GoTransit::UP::Gtfs::Feed.alerts.first.alert

    expect(up_vehicle).to be_kind_of(GoTransit::Gtfs::VehiclePosition)
    expect(up_vehicle.trip).to be_kind_of(GoTransit::Gtfs::TripDescriptor)
    expect(up_vehicle.vehicle).to be_kind_of(GoTransit::Gtfs::VehicleDescriptor)
    expect(up_update.stop_time_updates.first.departure).to be_kind_of(GoTransit::Gtfs::StopTimeEvent)
    expect(up_alert.header_text).to be_kind_of(GoTransit::Gtfs::TranslatedString)
  end

  it "uses a FeedHeader and FeedEntity for every feed" do
    feed = GoTransit::UP::Gtfs::Feed.alerts

    expect(feed.header).to be_kind_of(GoTransit::Gtfs::FeedHeader)
    expect(feed.first).to be_kind_of(GoTransit::Gtfs::FeedEntity)
  end

  it "has no per-parent copies of a message left" do
    nested = [GoTransit::Gtfs::Feed, GoTransit::Gtfs::FeedEntity, GoTransit::Gtfs::VehiclePosition,
              GoTransit::Gtfs::TripUpdate, GoTransit::Gtfs::Alert, GoTransit::Gtfs::StopTimeUpdate].flat_map do |klass|
      klass.constants(false)
    end

    expect(nested).to be_empty
  end
end
