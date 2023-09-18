RSpec.describe GoTransit::Metadata do
  describe "#to_s" do
    it "includes the error code" do
      metadata = GoTransit::Metadata.new(error_code: "418")

      result = metadata.to_s

      expect(result).to include("418")
    end

    it "includes the error message" do
      metadata = GoTransit::Metadata.new(error_message: "This is a test")

      result = metadata.to_s

      expect(result).to include("This is a test")
    end
  end

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
