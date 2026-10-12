RSpec.describe "runtime dependencies" do
  let(:library_smoke_script) do
    <<~RUBY
      require "go_transit"
      require "json"
      fixtures = "spec/support/fixtures"

      feed = GoTransit::Gtfs::Feed.new(JSON.parse(File.read("\#{fixtures}/gtfs_feed_vehicle_position.json")))
      vehicle = feed.first.vehicle
      [vehicle.timestamp_utc, vehicle.timestamp_local, vehicle.trip.start_time_utc, vehicle.trip.start_time_local]

      alerts = GoTransit::Gtfs::Feed.new(JSON.parse(File.read("\#{fixtures}/gtfs_feed_alerts.json")))
      alerts.first.alert.header_text.translations.first.text

      glance = GoTransit::Response.new(JSON.parse(File.read("\#{fixtures}/service_at_a_glance_trains.json")), 200)
      GoTransit::ServiceAtAGlance.new(glance.data).first.modified_date_utc

      exit(defined?(ActiveSupport) ? 1 : 0)
    RUBY
  end

  it "runs the classic and GTFS code paths without ActiveSupport" do
    expect(system(RbConfig.ruby, "-I", "lib", "-e", library_smoke_script)).to be(true)
  end
end
