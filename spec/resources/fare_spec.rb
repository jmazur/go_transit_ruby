RSpec.describe GoTransit::Stop do
  describe ".get" do
    it "is a collection of stations" do
      fares = GoTransit::Fare.get(from_stop_code: "UN", to_stop_code: "CL", operational_day: "20230303")

      expect(fares.first).to be_kind_of(GoTransit::Fare::FareCategory)
    end
  end
end