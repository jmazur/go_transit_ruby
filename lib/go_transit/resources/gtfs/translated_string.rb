module GoTransit
  class Gtfs::TranslatedString < Gtfs::Resource
    attr_accessor :translations

    class Translation < Gtfs::Resource
      attr_accessor :text, :language
    end

    hydrate_as translation: Translation
  end
end
