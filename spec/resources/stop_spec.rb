RSpec.describe GoTransit::Stop do
  describe ".all" do
    it "is a collection of stations" do
      stops = GoTransit::Stop.all

      expect(stops.first).to be_kind_of(GoTransit::Stop::Station)
    end
  end

  describe ".details" do
    it "populates facilities" do
      stop = GoTransit::Stop.details(stop_code: "CL")

      expect(stop.facilities.first).to be_kind_of(GoTransit::Stop::Facility)
    end

    it "populates parking" do
      stop = GoTransit::Stop.details(stop_code: "CL")

      expect(stop.parkings.first).to be_kind_of(GoTransit::Stop::Parking)
    end

    it "populates place information" do
      stop = GoTransit::Stop.details(stop_code: "CL")

      expect(stop.place).to be_kind_of(GoTransit::Stop::Place)
    end
  end

  describe ".next_service" do
    it "creates a NextService object for the provided stop" do
      object = GoTransit::Stop.next_service(stop_code: "CL")

      expect(object).to be_kind_of(GoTransit::Stop::NextService)
    end
  end

  describe ".destinations" do
    it "populates lines" do
      destinations = GoTransit::Stop.destinations(stop_code: "CL", from_time: "1200", 
                                                  to_time: "1300")

      expect(destinations.first).to be_kind_of(GoTransit::Stop::Destination::Line)
    end
  end
end