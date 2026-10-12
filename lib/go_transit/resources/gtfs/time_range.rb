module GoTransit
  class Gtfs::TimeRange < Gtfs::Resource
    attr_accessor :start, :end

    epoch_time :start, :end
  end
end
