RSpec.describe GoTransit::ServiceUpdate::Exceptions do
  describe ".train" do
    it "is a collection of trips" do
      trips = GoTransit::ServiceUpdate::Exceptions.train

      expect(trips.first).to be_kind_of(GoTransit::ServiceUpdate::Exceptions::Trip)
    end
  end

  describe ".bus" do
    it "is a collection of trips" do
      trips = GoTransit::ServiceUpdate::Exceptions.bus

      expect(trips.first).to be_kind_of(GoTransit::ServiceUpdate::Exceptions::Trip)
    end
  end

  describe ".all" do
    it "is a collection of trips" do
      trips = GoTransit::ServiceUpdate::Exceptions.all

      expect(trips.first).to be_kind_of(GoTransit::ServiceUpdate::Exceptions::Trip)
    end
  end
end


