RSpec.describe GoTransit::Schedule::Journey::SchJourney::Service do
  describe "#start_time_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Schedule::Journey::SchJourney::Service.new(
          start_time: toronto_time
        )

        result = service.start_time_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end

  describe "#end_time_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Schedule::Journey::SchJourney::Service.new(
          end_time: toronto_time
        )

        result = service.end_time_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end
end
