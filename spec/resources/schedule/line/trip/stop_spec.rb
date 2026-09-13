RSpec.describe GoTransit::Schedule::Line::Trip::Stop do
  describe "#major?" do
    context "when is_major is 1" do
      it "is major" do
        stop = GoTransit::Schedule::Line::Trip::Stop.new(is_major: "1")

        expect(stop).to be_major
      end
    end

    context "when is_major is not 1" do
      it "is not major" do
        stop = GoTransit::Schedule::Line::Trip::Stop.new(is_major: "0")

        expect(stop).not_to be_major
      end
    end
  end

  describe "#time_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        stop = GoTransit::Schedule::Line::Trip::Stop.new(time: toronto_time)

        result = stop.time_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end

  describe "#time_local" do
    it "returns the timestamp zoned to toronto time, unshifted" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        stop = GoTransit::Schedule::Line::Trip::Stop.new(time: toronto_time)

        result = stop.time_local

        expect(result).to eq(toronto_time.in_time_zone("America/Toronto"))
      end
    end
  end
end
