RSpec.describe GoTransit::ApiObject do
  describe "#initialize" do
    it "sets the attribute to the value" do
      data = stubbed_trip(trip_number: 5544)

      trip = GoTransit::Trip.new(data)

      expect(trip.trip_number).to eq(5544)
    end

    context "when the value is a collection" do
      it "sets the value to an array of objects" do

      end
    end

    context "when the value is a hash" do
      it "assigns the value to a single object" do

      end
    end

    context "when the value is an array" do
      it "sets the value to an array of objects and pluralizes the key" do
        data = stubbed_trip

        trip = GoTransit::Trip.new(data)

        expect(trip.stops).to all(be_a(GoTransit::Stop))
      end
    end
  end

  describe ".build_from_json" do
    it "returns a built object based on the name" do
      name = "Trip"
      params = stubbed_trip

      result = GoTransit::ApiObject.build_from_json(name, params)

      expect(result).to be_a(GoTransit::Trip)
    end

    context "when the name is identified as a collection" do
      it "uses the first child as the name and params" do
        name = "Trips"
        params = { "Trip": [stubbed_trip, stubbed_trip] }

        result = GoTransit::ApiObject.build_from_json(name, params)

        expect(result).to all(be_a(GoTransit::Trip))
      end
    end
  end

  describe ".build_object" do
    it "returns a built object based on the name" do
      name = "Trip"
      params = stubbed_trip

      result = GoTransit::ApiObject.build_object(name, params)

      expect(result).to be_a(GoTransit::Trip)
    end

    context "if the params are an array" do
      it "returns an array of built objects" do
        name = "Trip"
        params = [stubbed_trip, stubbed_trip]

        result = GoTransit::ApiObject.build_object(name, params)

        expect(result).to all(be_a(GoTransit::Trip))
      end
    end
  end

  def stubbed_trip(trip_number: "1234")
    json = <<~EOS
      {
        "TripNumber": #{trip_number},
        "TripName": "",
        "IsCancelled": "1",
        "IsOverride": "1",
        "Stops": [
          {
            "Code": "EX",
            "Order": 1,
            "Time": "2023-01-20 23:35:00",
            "sortingTime": null,
            "IsMajor": false
          },
          {
            "Code": "UN",
            "Order": 2,
            "Time": "2023-01-20 23:45:00",
            "sortingTime": null,
            "IsMajor": false
          }
        ],
        "Place": {
          "Code": "unionS",
          "Name": "Union Station ",
          "Longitude": "-79.3804680",
          "Latitude": "43.6452910",
          "Radius": "0",
          "Stops": null
        }
      }
    EOS
    JSON.parse(json)
  end
end
