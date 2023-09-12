RSpec.describe GoTransit::ServiceAtAGlance::Trip do
  describe "#in_motion?" do
    context "when is_stopping is 1" do
      it "is stopping" do
        trip = GoTransit::ServiceAtAGlance::Trip.new(is_in_motion: true)

        expect(trip).to be_in_motion
      end
    end

    context "when is_stopping is not 1" do
      it "is not stopping" do
        trip = GoTransit::ServiceAtAGlance::Trip.new(is_in_motion: false)

        expect(trip).not_to be_in_motion
      end
    end
  end
end
