RSpec.describe GoTransit::Schedule::Trip do
  describe "#time_stamp_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        trip = GoTransit::Schedule::Trip.new(time_stamp: toronto_time)

        result = trip.time_stamp_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end

  describe "#time_stamp_local" do
    it "returns the timestamp zoned to toronto time, unshifted" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        trip = GoTransit::Schedule::Trip.new(time_stamp: toronto_time)

        result = trip.time_stamp_local

        expect(result).to eq(toronto_time.in_time_zone("America/Toronto"))
      end
    end
  end
end
