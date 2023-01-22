module GoTransit
  class ApiObject
    def initialize(params)
      params.each_pair do |key, value|
        if ObjectTypes::COLLECTIONS.include?(key)
          sub_key, sub_value = value.first
          value = ApiObject.build_object(sub_key, sub_value)
        elsif value.kind_of?(Hash)
          value = ApiObject.build_object(key, value)
        elsif value.kind_of?(Array)
          value = ApiObject.build_object(key.singularize, value)
          key = key.pluralize
        end
        try("#{key.underscore}=", value)
      end
    end

    def self.build_from_json(name, params)
      if ObjectTypes::COLLECTIONS.include?(name)
        name, params = params.first
      end
      build_object(name, params)
    end

    def self.build_object(name, params)
      klass = Object.const_get("GoTransit::#{name}")
      if params.kind_of?(Array)
        params.map { |param| klass.new(param) }
      else
        klass.new(params)
      end
    end
  end
end
