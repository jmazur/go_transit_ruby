RSpec.describe GoTransit::Schedule::Journey::SchJourney::Service::Trip::Stop do
  describe "#major?" do
    context "when is_major is 1" do
      it "is major" do
        stop = GoTransit::Schedule::Journey::SchJourney::Service::Trip::Stop.new(
          is_major: "1"
        )

        expect(stop).to be_major
      end
    end

    context "when is_major is not 1" do
      it "is not major" do
        stop = GoTransit::Schedule::Journey::SchJourney::Service::Trip::Stop.new(
          is_major: "0"
        )

        expect(stop).not_to be_major
      end
    end
  end
end
