RSpec.describe GoTransit::ServiceUpdate::Exceptions::Trip::Stop do
  describe "#stopping?" do
    context "when is_stopping is 1" do
      it "is stopping" do
        stop = GoTransit::ServiceUpdate::Exceptions::Trip::Stop.new(
          is_stopping: "1"
        )

        expect(stop).to be_stopping
      end
    end

    context "when is_stopping is not 1" do
      it "is not stopping" do
        stop = GoTransit::ServiceUpdate::Exceptions::Trip::Stop.new(
          is_stopping: "0"
        )

        expect(stop).not_to be_stopping
      end
    end
  end

  describe "#cancelled?" do
    context "when is_cancelled is 1" do
      it "is cancelled" do
        stop = GoTransit::ServiceUpdate::Exceptions::Trip::Stop.new(
          is_cancelled: "1"
        )

        expect(stop).to be_cancelled
      end
    end

    context "when is_cancelled is not 1" do
      it "is not cancelled" do
        stop = GoTransit::ServiceUpdate::Exceptions::Trip::Stop.new(
          is_cancelled: "0"
        )

        expect(stop).not_to be_cancelled
      end
    end
  end

  describe "#override?" do
    context "when is_override is 1" do
      it "is bus" do
        stop = GoTransit::ServiceUpdate::Exceptions::Trip::Stop.new(
          is_override: "1"
        )

        expect(stop).to be_override
      end
    end

    context "when is_override is 0" do
      it "is not bus" do
        stop = GoTransit::ServiceUpdate::Exceptions::Trip::Stop.new(
          is_override: "0"
        )

        expect(stop).not_to be_override
      end
    end
  end
end
