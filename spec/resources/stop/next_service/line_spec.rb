RSpec.describe GoTransit::Stop::NextService::Line do
  describe "#scheduled_departure_time_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Stop::NextService::Line.new(
          scheduled_departure_time: toronto_time
        )

        result = service.scheduled_departure_time_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end

  describe "#computed_departure_time_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Stop::NextService::Line.new(
          computed_departure_time: toronto_time
        )

        result = service.computed_departure_time_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end

  describe "#update_time_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Stop::NextService::Line.new(
          update_time: toronto_time
        )

        result = service.update_time_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end

  describe "#scheduled_departure_time_local" do
    it "returns the timestamp zoned to toronto time, unshifted" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Stop::NextService::Line.new(
          scheduled_departure_time: toronto_time
        )

        result = service.scheduled_departure_time_local

        expect(result).to eq(toronto_time.in_time_zone("America/Toronto"))
      end
    end
  end

  describe "#computed_departure_time_local" do
    it "returns the timestamp zoned to toronto time, unshifted" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Stop::NextService::Line.new(
          computed_departure_time: toronto_time
        )

        result = service.computed_departure_time_local

        expect(result).to eq(toronto_time.in_time_zone("America/Toronto"))
      end
    end
  end

  describe "#update_time_local" do
    it "returns the timestamp zoned to toronto time, unshifted" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Stop::NextService::Line.new(
          update_time: toronto_time
        )

        result = service.update_time_local

        expect(result).to eq(toronto_time.in_time_zone("America/Toronto"))
      end
    end
  end
end
