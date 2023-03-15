RSpec.describe GoTransit::Schedule::AllLines do
  describe ".all" do
    it "is a collection of SchJourney" do
      date = Date.parse("2023-03-13")
      lines = GoTransit::Schedule::AllLines.all(date: date)

      expect(lines.first).to be_kind_of(GoTransit::Schedule::AllLines::Line)
    end
  end
end