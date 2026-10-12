module GoTransit
  class UP::Gtfs::Feed < GoTransit::Gtfs::Feed
    def self.endpoint_prefix
      "UP/Gtfs/Feed"
    end
  end
end
