module GoTransit
  class ApiResource
    def initialize(params)
      hydrate(params)
    end

    private

    def hydrate(params)
      params.each_pair do |key, value|
        if collection?(value)
          sub_key, sub_value = value.first
          key = sub_key.pluralize
          value = build_object(sub_key.singularize, sub_value)
        elsif value.kind_of?(Hash)
          value = build_object(key, value)
        elsif value.kind_of?(Array)
          value = build_object(key.singularize, value)
          key = key.pluralize
        end
        send("#{key.to_s.underscore}=", value)
      end
    end

    def build_object(name, params)
      klass = get_klass(name)
      if params.kind_of?(Array)
        params.map { |param| klass.new(param) }
      else
        klass.new(params)
      end
    end

    def get_klass(name)
      Object.const_get("#{self.class.name}::#{name}")
    end

    def collection?(value)
      return false unless value.kind_of?(Hash)
      key, data = value.first
      data.kind_of?(Array)
    end

    def to_utc(date)
      date.in_time_zone("America/Toronto").utc
    end
  end
end
