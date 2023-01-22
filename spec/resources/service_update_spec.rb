RSpec.describe GoTransit::ServiceUpdate do
  describe ".service_alerts" do
    it "is a collection of messages" do
      messages = GoTransit::ServiceUpdate.service_alerts

      expect(messages.first).to be_kind_of(GoTransit::ServiceUpdate::Message)
    end
  end

  describe ".information_alerts" do
    it "is a collection of messages" do
      messages = GoTransit::ServiceUpdate.information_alerts

      expect(messages.first).to be_kind_of(GoTransit::ServiceUpdate::Message)
    end
  end

  describe ".marketing_alerts" do
    it "is a collection of messages" do
      pending "API is not returning marketing alert data at this time"
      fail
      messages = GoTransit::ServiceUpdate.marketing_alerts

      expect(messages.first).to be_kind_of(GoTransit::ServiceUpdate::Message)
    end
  end

  describe ".union_departures" do
    it "is a collection of trips" do
      messages = GoTransit::ServiceUpdate.union_departures

      expect(messages.first).to be_kind_of(GoTransit::ServiceUpdate::UnionDepartures::Trip)
    end
  end

  describe ".service_guarantee" do
    it "is a collection of stops" do
      pending "API is not returning service guarentee data at this time"
      fail
      messages = GoTransit::ServiceUpdate.service_guarantee(trip_number: 1024, operational_day: 20230306)

      expect(messages.first).to be_kind_of(GoTransit::ServiceUpdate::ServiceGuarantee::Stop)
    end
  end
end


