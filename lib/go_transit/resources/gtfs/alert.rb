module GoTransit
  class Gtfs::Alert < Gtfs::Resource
    attr_accessor :active_periods, :informed_entities, :cause, :effect, :url,
                  :header_text, :description_text

    hydrate_as active_period: Gtfs::TimeRange, informed_entity: Gtfs::EntitySelector,
               url: Gtfs::TranslatedString, header_text: Gtfs::TranslatedString,
               description_text: Gtfs::TranslatedString
  end
end
