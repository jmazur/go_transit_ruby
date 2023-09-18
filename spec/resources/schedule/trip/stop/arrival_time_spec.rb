RSpec.describe GoTransit::Schedule::Trip::Stop::ArrivalTime do
  describe "#scheduled_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(
          scheduled: toronto_time
        )

        result = service.scheduled_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end

  describe "#computed_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::Schedule::Trip::Stop::ArrivalTime.new(
          computed: toronto_time
        )

        result = service.computed_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end
end
