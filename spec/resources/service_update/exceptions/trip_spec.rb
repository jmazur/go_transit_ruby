RSpec.describe GoTransit::ServiceUpdate::Exceptions::Trip do
  describe "#cancelled?" do
    context "when is_cancelled is 1" do
      it "is cancelled" do
        trip = GoTransit::ServiceUpdate::Exceptions::Trip.new(
          is_cancelled: "1"
        )

        expect(trip).to be_cancelled
      end
    end

    context "when is_cancelled is not 1" do
      it "is not cancelled" do
        trip = GoTransit::ServiceUpdate::Exceptions::Trip.new(
          is_cancelled: "0"
        )

        expect(trip).not_to be_cancelled
      end
    end
  end

  describe "#override?" do
    context "when is_override is 1" do
      it "is bus" do
        trip = GoTransit::ServiceUpdate::Exceptions::Trip.new(
          is_override: "1"
        )

        expect(trip).to be_override
      end
    end

    context "when is_override is 0" do
      it "is not bus" do
        trip = GoTransit::ServiceUpdate::Exceptions::Trip.new(
          is_override: "0"
        )

        expect(trip).not_to be_override
      end
    end
  end
end
