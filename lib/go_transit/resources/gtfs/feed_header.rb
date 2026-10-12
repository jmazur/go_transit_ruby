module GoTransit
  class Gtfs::FeedHeader < Gtfs::Resource
    attr_accessor :gtfs_realtime_version, :incrementality, :timestamp

    epoch_time :timestamp
  end
end
