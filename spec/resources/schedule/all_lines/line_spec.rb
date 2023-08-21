RSpec.describe GoTransit::Schedule::AllLines::Line do
  describe "#train?" do
    context "when line is train" do
      it "is train" do
        line = GoTransit::Schedule::AllLines::Line.new(is_train: true)

        expect(line).to be_train
      end
    end

    context "when line is not train" do
      it "is not train" do
        line = GoTransit::Schedule::AllLines::Line.new(is_train: false)

        expect(line).not_to be_train
      end
    end
  end

  describe "#bus?" do
    context "when line is bus" do
      it "is bus" do
        line = GoTransit::Schedule::AllLines::Line.new(is_bus: true)

        expect(line).to be_bus
      end
    end

    context "when line is not bus" do
      it "is not bus" do
        line = GoTransit::Schedule::AllLines::Line.new(is_bus: false)

        expect(line).not_to be_bus
      end
    end
  end
end
