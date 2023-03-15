RSpec.describe GoTransit::Schedule do
  describe ".journey" do
    it "is a collection of SchJourney" do
      date = Date.parse("2023-03-13")
      journeys = GoTransit::Schedule.journey(date: date, from_stop_code: "UN", 
                                             to_stop_code: "CL", 
                                             start_time: "0900", max_journey: 5)

      expect(journeys.first).
        to be_kind_of(GoTransit::Schedule::Journey::SchJourney)
    end
  end

  describe ".line" do
    it "is a collection of lines" do
      date = Date.parse("2023-03-13")
      lines = GoTransit::Schedule.line(date: date, line_code: "LW", 
                                      line_direction: "E")

      expect(lines.first).to be_kind_of(GoTransit::Schedule::Line)
    end
  end

  describe ".trip" do
    it "is a collection of trips" do
      date = Date.parse("2023-03-13")
      trips = GoTransit::Schedule.trip(date: date, trip_number: "1024")

      expect(trips.first).to be_kind_of(GoTransit::Schedule::Trip)
    end
  end
end