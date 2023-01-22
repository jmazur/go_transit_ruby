RSpec.describe GoTransit::ServiceAtAGlance do
  describe ".buses" do
    it "is a collection of trips" do
      trips = GoTransit::ServiceAtAGlance.buses

      expect(trips.first).to be_kind_of(GoTransit::ServiceAtAGlance::Trip)
    end
  end

  describe ".trains" do
    it "is a collection of trips" do
      trips = GoTransit::ServiceAtAGlance.trains

      expect(trips.first).to be_kind_of(GoTransit::ServiceAtAGlance::Trip)
    end
  end

  describe ".upx" do
    it "is a collection of trips" do
      pending "API is not returning UPX data at this time"
      fail
      trips = GoTransit::ServiceAtAGlance.upx

      expect(trips.first).to be_kind_of(GoTransit::ServiceAtAGlance::Trip)
    end
  end
end