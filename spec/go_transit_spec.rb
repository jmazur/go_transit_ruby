RSpec.describe GoTransit do
  describe ".service_day_boundary_hour" do
    it "defaults to 4" do
      expect(GoTransit.service_day_boundary_hour).to eq(4)
    end

    it "can be overridden via configure" do
      GoTransit.configure { |config| config.service_day_boundary_hour = 3 }

      expect(GoTransit.service_day_boundary_hour).to eq(3)

      GoTransit.configure { |config| config.service_day_boundary_hour = 4 }
    end
  end
end
