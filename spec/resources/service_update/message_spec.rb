RSpec.describe GoTransit::ServiceUpdate::Message do
  describe "#posted_date_time_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::ServiceUpdate::Message.new(
          posted_date_time: toronto_time
        )

        result = service.posted_date_time_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end
end
