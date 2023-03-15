RSpec.describe GoTransit::Stop::Station do
  describe "#train?" do
    context "when location type includes Train" do
      it "is train" do
        station = GoTransit::Stop::Station.new(location_type: "Train & Bus")

        expect(station).to be_train
      end
    end

    context "when location doesnt include Train" do
      it "is not train" do
        station = GoTransit::Stop::Station.new(location_type: "Bus")

        expect(station).not_to be_train
      end
    end
  end

  describe "#bus?" do
    context "when location type includes Bus" do
      it "is bus" do
        station = GoTransit::Stop::Station.new(location_type: "Train & Bus")

        expect(station).to be_bus
      end
    end

    context "when location doesnt include Bus" do
      it "is not bus" do
        station = GoTransit::Stop::Station.new(location_type: "Train")

        expect(station).not_to be_bus
      end
    end
  end
end
