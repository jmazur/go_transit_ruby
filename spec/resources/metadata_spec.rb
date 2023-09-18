RSpec.describe GoTransit::Metadata do
  describe "#code" do
    it "converts error_code string to an integer" do
      metadata = GoTransit::Metadata.new(error_code: "400")

      expect(metadata.code).to eql(400)
    end
  end

  describe "#time_stamp_utc" do
    it "converts the timestamp from toronto time to UTC time" do
      Timecop.travel("2023-09-14") do
        toronto_time = "2023-09-14 12:00:00"
        metadata = GoTransit::Metadata.new(time_stamp: toronto_time)

        result = metadata.time_stamp_utc

        expect(result).to eq("2023-09-14 16:00:00".to_datetime)
      end
    end
  end
end
