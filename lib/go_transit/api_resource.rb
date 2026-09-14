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
      to_local(date).utc
    end

    def to_local(date, timezone: "America/Toronto")
      date.in_time_zone(timezone)
    end

    def to_utc_from_anchor(time, trip_date, timezone: "America/Toronto")
      to_local_from_anchor(time, trip_date, timezone: timezone)&.utc
    end

    def to_local_from_anchor(time, trip_date, timezone: "America/Toronto")
      raise MissingAnchorDateError if trip_date.nil?
      return nil if time.blank?
      hour = time.split(":").first.to_i
      date = determine_date(trip_date, hour)
      "#{date} #{time}".in_time_zone(timezone)
    end

    def determine_date(date, hour)
      if hour < GoTransit.service_day_boundary_hour
        date + 1.day
      else
        date
      end
    end
  end
end
