RSpec.describe GoTransit::ServiceAtAGlance::Trip do
  describe "#in_motion?" do
    context "when is_stopping is 1" do
      it "is stopping" do
        trip = GoTransit::ServiceAtAGlance::Trip.new(is_in_motion: true)

        expect(trip).to be_in_motion
      end
    end

    context "when is_stopping is not 1" do
      it "is not stopping" do
        trip = GoTransit::ServiceAtAGlance::Trip.new(is_in_motion: false)

        expect(trip).not_to be_in_motion
      end
    end
  end

  describe "#modified_date_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-17 12:00:00"
        service = GoTransit::ServiceAtAGlance::Trip.new(
          modified_date: toronto_time
        )

        result = service.modified_date_utc

        expect(result).to eq("2023-09-17 16:00:00".to_datetime)
      end
    end
  end
end
