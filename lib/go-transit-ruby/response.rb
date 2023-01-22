module GoTransit
  class Response
    attr_accessor :metadata, :data

    def initialize(json)
      json.each_pair do |key, params|
        object = ApiObject.build_from_json(key, params)
        if key == "Metadata"
          @metadata = object
        else
          @data = object
        end
      end
    end
  end
end
