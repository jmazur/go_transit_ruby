RSpec.describe GoTransit::Trip do
  describe "#in_motion?" do
    context "when the trip is in motion" do
      it "is in motion" do
        trip = GoTransit::Trip.new("IsInMotion" => true)

        expect(trip).to be_in_motion
      end
    end
  end
end
