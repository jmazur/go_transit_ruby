module GoTransit
  class ApiResource
    def initialize(params)
      hydrate(params)
    end

    private

    def hydrate(params)
      params.each_pair do |key, value|
        if wrapped_collection?(value)
          sub_key, sub_value = value.first
          key = Inflector.pluralize(sub_key)
          value = build_object(Inflector.singularize(sub_key), sub_value)
        elsif value.kind_of?(Hash)
          value = build_object(key, value)
        elsif value.kind_of?(Array)
          value = build_object(Inflector.singularize(key), value)
          key = Inflector.pluralize(key)
        end
        send("#{Inflector.underscore(key)}=", value)
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

    def wrapped_collection?(value)
      return false unless value.kind_of?(Hash)
      key, data = value.first
      data.kind_of?(Array)
    end

    def to_utc(date)
      Zone.wall_clock_to_utc(date)
    end

    def to_local(date, timezone: Zone::DEFAULT)
      Zone.wall_clock_to_local(date, timezone)
    end

    def to_utc_from_anchor(time, trip_date, timezone: Zone::DEFAULT)
      wall_clock = anchored_wall_clock(time, trip_date)
      wall_clock && Zone.wall_clock_to_utc(wall_clock, timezone)
    end

    def to_local_from_anchor(time, trip_date, timezone: Zone::DEFAULT)
      wall_clock = anchored_wall_clock(time, trip_date)
      wall_clock && Zone.wall_clock_to_local(wall_clock, timezone)
    end

    def anchored_wall_clock(time, trip_date)
      raise MissingAnchorDateError if trip_date.nil?
      return nil if blank_value?(time)
      "#{determine_date(trip_date, time.split(":").first.to_i)} #{time}"
    end

    def determine_date(date, hour)
      if hour < GoTransit.service_day_boundary_hour
        date + 1
      else
        date
      end
    end

    def blank_value?(value)
      value.nil? || value.to_s.strip.empty?
    end
  end
end
