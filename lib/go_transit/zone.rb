require "date"
require "tzinfo"

module GoTransit
  module Zone
    DEFAULT = "America/Toronto".freeze
    ONE_HOUR = 3600

    module_function

    def wall_clock_to_utc(text, timezone = DEFAULT)
      parsed = parse_wall_clock(text)
      return parsed[:utc] if parsed[:utc]
      prefer_daylight_time(parsed[:wall], TZInfo::Timezone.get(timezone))
    end

    def wall_clock_to_local(text, timezone = DEFAULT)
      utc_to_local(wall_clock_to_utc(text, timezone), timezone)
    end

    def epoch_to_local(epoch, timezone = DEFAULT)
      utc_to_local(Time.at(epoch).utc, timezone)
    end

    def utc_to_local(utc, timezone = DEFAULT)
      TZInfo::Timezone.get(timezone).utc_to_local(utc)
    end

    def parse_wall_clock(text)
      found = Date._parse(text.to_s)
      raise ArgumentError, "invalid date: #{text.inspect}" unless found[:year] && found[:mon] && found[:mday]
      wall = Time.utc(found[:year], found[:mon], found[:mday], found[:hour].to_i, found[:min].to_i, found[:sec].to_i)
      found[:offset] ? { utc: wall - found[:offset] } : { wall: wall }
    end

    def prefer_daylight_time(wall, zone)
      zone.local_to_utc(wall, true)
    rescue TZInfo::PeriodNotFound
      zone.local_to_utc(wall + ONE_HOUR, true)
    end
    private_class_method :parse_wall_clock, :prefer_daylight_time
  end
end
