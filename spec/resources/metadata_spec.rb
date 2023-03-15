RSpec.describe GoTransit::Metadata do
  describe "#code" do
    it "converts error_code string to an integer" do
      metadata = GoTransit::Metadata.new(error_code: "400")

      expect(metadata.code).to eql(400)
    end
  end
end
