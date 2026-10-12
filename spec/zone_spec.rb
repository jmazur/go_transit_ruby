RSpec.describe GoTransit::Zone do
  def reference(string, timezone = "America/Toronto")
    string.in_time_zone(timezone)
  end

  describe ".wall_clock_to_utc" do
    it "reads a Toronto wall clock string in winter (EST)" do
      expect(described_class.wall_clock_to_utc("2023-01-18 01:45:14")).to eq(Time.utc(2023, 1, 18, 6, 45, 14))
    end

    it "reads a Toronto wall clock string in summer (EDT)" do
      expect(described_class.wall_clock_to_utc("2023-09-14 10:30:00")).to eq(Time.utc(2023, 9, 14, 14, 30))
    end

    it "returns a plain UTC Time" do
      result = described_class.wall_clock_to_utc("2023-09-14 10:30:00")

      expect(result).to be_utc
      expect(result.class).to eq(Time)
    end

    it "matches ActiveSupport on ordinary, boundary and DST days" do
      [
        "2023-03-12 01:59:00", "2023-03-12 03:00:00", "2023-11-05 00:59:00", "2023-11-05 02:00:00",
        "2026-03-08 03:00:00", "2026-11-01 02:30:00", "2026-12-31 23:59:59", "2024-02-29 12:00:00",
      ].each do |string|
        expect(described_class.wall_clock_to_utc(string)).to eq(reference(string).utc), string
      end
    end

    it "treats the repeated hour in November as the first (daylight time) one, like ActiveSupport" do
      string = "2026-11-01 01:30:00"

      expect(described_class.wall_clock_to_utc(string)).to eq(reference(string).utc)
      expect(described_class.wall_clock_to_utc(string)).to eq(Time.utc(2026, 11, 1, 5, 30))
    end

    it "moves a time that does not exist (spring forward) an hour on, like ActiveSupport" do
      string = "2026-03-08 02:30:00"

      expect(described_class.wall_clock_to_utc(string)).to eq(reference(string).utc)
      expect(described_class.wall_clock_to_utc(string)).to eq(Time.utc(2026, 3, 8, 7, 30))
    end

    it "accepts a date with no time and a time without seconds" do
      expect(described_class.wall_clock_to_utc("2023-03-13")).to eq(reference("2023-03-13").utc)
      expect(described_class.wall_clock_to_utc("2023-03-13 08:19")).to eq(reference("2023-03-13 08:19").utc)
    end

    it "uses another timezone when asked" do
      expect(described_class.wall_clock_to_utc("2023-09-14 10:30:00", "America/Vancouver")).
        to eq(reference("2023-09-14 10:30:00", "America/Vancouver").utc)
    end

    it "raises on something that is not a date" do
      expect { described_class.wall_clock_to_utc("not a date") }.to raise_error(ArgumentError)
    end
  end

  describe ".wall_clock_to_local" do
    it "gives the same instant with the Toronto offset and zone name" do
      result = described_class.wall_clock_to_local("2023-09-14 10:30:00")

      expect(result).to eq(Time.utc(2023, 9, 14, 14, 30))
      expect(result.utc_offset).to eq(-4 * 3600)
      expect(result.zone).to eq("EDT")
      expect(result.strftime("%Y-%m-%d %H:%M:%S")).to eq("2023-09-14 10:30:00")
    end

    it "uses EST in winter" do
      expect(described_class.wall_clock_to_local("2023-01-18 01:45:14").zone).to eq("EST")
    end
  end

  describe ".epoch_to_local" do
    it "converts an epoch to Toronto time" do
      result = described_class.epoch_to_local(1_791_771_983)

      expect(result).to eq(Time.at(1_791_771_983).utc)
      expect(result.utc_offset).to eq(-4 * 3600)
    end
  end
end
