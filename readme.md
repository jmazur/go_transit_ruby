# Go Transit API Ruby Wrapper
[![Tests](https://github.com/jmazur/go_transit_ruby/actions/workflows/tests.yml/badge.svg?label=test)](https://github.com/jmazur/go_transit_ruby/actions/workflows/tests.yml)
[![Maintainability](https://qlty.sh/gh/jmazur/projects/go_transit_ruby/maintainability.svg)](https://qlty.sh/gh/jmazur/projects/go_transit_ruby)
[![Code Coverage](https://qlty.sh/gh/jmazur/projects/go_transit_ruby/coverage.svg)](https://qlty.sh/gh/jmazur/projects/go_transit_ruby)
[![Gem Version](https://badge.fury.io/rb/go_transit.svg?icon=si%3Arubygems)](https://badge.fury.io/rb/go_transit)

This gem is intended to make working with the Go Transit API easier and more
consistent. The API endpoints were re-created as close to the API spec wherever
possible, but some exceptions do exist. Reference the Go Transit API
documenation for details on available fields.

The GTFS Real Time endpoints that return JSON are supported (see below). This
gem does not decode the protobuf format, and the API serves the JSON from the
plain path (no file extension).

Supports Ruby 2.7.x - 4.0.x

The only runtime dependency is [tzinfo](https://github.com/tzinfo/tzinfo), for
the `America/Toronto` conversions. The gem does not need ActiveSupport.

### Upgrading from 1.x
Version 2.0.0 removed the ActiveSupport dependency. The one change you may
notice: `_local` methods used to return an `ActiveSupport::TimeWithZone` and now
return a `Time` with the Toronto offset (see Dates & Times). `_utc` methods still
return a plain UTC `Time`. If your code called `.time_zone` on a `_local` value,
use `.zone` or `.utc_offset` instead, or wrap it with your own
`in_time_zone("America/Toronto")` if you have ActiveSupport. During the repeated
hour when daylight saving ends the first (daylight) time is used, and a time that
does not exist when it begins moves an hour on, as ActiveSupport did.

## API Keys
You can get a Go Transit API key here
[https://api.openmetrolinx.com/OpenDataAPI/Help/Registration/en](https://api.openmetrolinx.com/OpenDataAPI/Help/Registration/en).

## Usage
Import go_transit and set your API key.

```ruby
require "go_transit"

GoTransit.configure do |config|
  config.api_key = "YOUR_API_KEY"
end
```

This gem exposes the Go Transit API endpoints and hydrates objects related to the returned data.

#### Stop
| Method                                               | Reference                                                                                           |
| :--------------------------------------------------- | :-------------------------------------------------------------------------------------------------- |
| `GoTransit::Stop.all`                                | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Stop-All)                    |
| `GoTransit::Stop.details(stop_code: <string>)`       | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Stop-Details-StopCode)       |
| `GoTransit::Stop.next_service(stop_code: <string>)`  | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Stop-NextService-StopCode)   |
| `GoTransit::Stop.destinations(stop_code: <string>, from_time: <string>, to_time: <string>)` | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Stop-Destinations-StopCode-FromTime-ToTime) |

#### Service Update
| Method                                        | Reference                                                                                                  |
| :-------------------------------------------- | :--------------------------------------------------------------------------------------------------------- |
| `GoTransit::ServiceUpdate.service_alerts`     | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-ServiceAlert-All)     |
| `GoTransit::ServiceUpdate.information_alerts` | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-InformationAlert-All) |
| `GoTransit::ServiceUpdate.marketing_alerts`   | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-MarketingAlert-All)   |
| `GoTransit::ServiceUpdate.union_departures`   | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-UnionDepartures-All)  |
| `GoTransit::ServiceUpdate.service_guarantee(trip_number: <string>, operational_day: <string>)` | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-ServiceGuarantee-TripNumber-OperationalDay) |
| `GoTransit::ServiceUpdate::Exceptions.train`  | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-Exceptions-Train)     |
| `GoTransit::ServiceUpdate::Exceptions.bus`    | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-Exceptions-Bus)       |
| `GoTransit::ServiceUpdate::Exceptions.all`    | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-Exceptions-All)       |

#### Service At Glance
| Method                               | Reference                                                                                           |
| :----------------------------------- | :-------------------------------------------------------------------------------------------------- |
| `GoTransit::ServiceAtAGlance.buses`  | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceataGlance-Buses-All)  |
| `GoTransit::ServiceAtAGlance.trains` | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceataGlance-Trains-All) |
| `GoTransit::ServiceAtAGlance.upx`    | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceataGlance-UPX-All)    |

#### Schedule
| Method                                                                                                                                  | Reference                     |
| :-------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------- |
| `GoTransit::Schedule.journey(date: <Date>, from_stop_code: <string>, to_stop_code: <string>, start_time: <string>, max_journey: <int>)` | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Journey-Date-FromStopCode-ToStopCode-StartTime-MaxJourney) |
| `GoTransit::Schedule.line(date: <Date>, line_code: <string>, line_direction: <string>)`                                                 | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Line-Date-LineCode-LineDirection) |
| `GoTransit::Schedule::AllLines.all(date: <Date>)`                                                                                           | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Line-All-Date) |
| `GoTransit::Schedule::Line.stop(date: <Date>, line_code: <string>, line_direction: <string>)`                                           | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Line-Stop-Date-LineCode-LineDirection) |
| `GoTransit::Schedule.trip(date: <Date>, trip_number: <string>)`                                                                         | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Trip-Date-TripNumber) |

#### Fare
| Method                                                                                                  | Reference                                                      |
| :------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------- |
| `GoTransit::Fare.get(from_stop_code: <string>, to_stop_code: <string>, operational_day: <nil\|string>)` | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Fares-FromStopCode-ToStopCode) or [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Fares-FromStopCode-ToStopCode-OperationalDay) |

#### GTFS Feeds
| Method                                    | Reference                                                                                  |
| :---------------------------------------- | :----------------------------------------------------------------------------------------- |
| `GoTransit::Gtfs::Feed.alerts`            | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Gtfs-Feed-Alerts)            |
| `GoTransit::Gtfs::Feed.trip_updates`      | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Gtfs-Feed-TripUpdates)      |
| `GoTransit::Gtfs::Feed.vehicle_position`  | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Gtfs-Feed-VehiclePosition)  |

#### UP GTFS Real Time
| Method                                       | Reference                                                                                     |
| :------------------------------------------- | :-------------------------------------------------------------------------------------------- |
| `GoTransit::UP::Gtfs::Feed.alerts`           | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-UP-Gtfs-Feed-Alerts)           |
| `GoTransit::UP::Gtfs::Feed.trip_updates`     | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-UP-Gtfs-Feed-TripUpdates)     |
| `GoTransit::UP::Gtfs::Feed.vehicle_position` | [Link](https://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-UP-Gtfs-Feed-VehiclePosition) |

The objects are the GTFS Realtime messages, one class each, reused by every feed
(GO, UP and any future one): `Gtfs::FeedHeader`, `Gtfs::FeedEntity`,
`Gtfs::VehiclePosition`, `Gtfs::TripUpdate`, `Gtfs::Alert`, and the parts they share,
`Gtfs::TripDescriptor`, `Gtfs::VehicleDescriptor`, `Gtfs::Position`,
`Gtfs::StopTimeUpdate`, `Gtfs::StopTimeEvent` (an arrival or a departure),
`Gtfs::TimeRange`, `Gtfs::EntitySelector` and `Gtfs::TranslatedString`.

Each feed is enumerable over its entities (`feed.header` has the feed's own
header). An entity holds one of `trip_update`, `vehicle` or `alert`, the others
are `nil`. The JSON keys are exactly the ones the API returns, except that
lists are pluralized like the other endpoints (`entity` is `entities`,
`stop_time_update` is `stop_time_updates`, `translation` is `translations`).
The vehicle feed includes buses as well as trains. At the time of writing
`speed`, `bearing` and `odometer` in vehicle positions are always `0` and
`occupancy_status` is always `EMPTY`.

## Dates & Times
All dates & times returned from the GO Transit API are in the `America/Toronto`
timezone, returned as plain, unconverted strings, exactly as the API sent
them. Every date and time field has two additional methods: `_utc`
converts it into a UTC `Time`, and `_local` returns the same instant as a
`Time` in `America/Toronto` (a `TZInfo::TimeWithOffset`, so `zone` is `"EDT"` or
`"EST"` and `utc_offset` is correct for that date), without shifting the value
itself. For example, `departure_time_utc` on a stop returns the
regular `departure_time` converted to UTC, and `departure_time_local`
returns the same time zoned to Toronto instead.

GTFS Real Time timestamps are Unix epoch integers, in UTC. Each one is kept as
returned (for example `vehicle.timestamp`) and has `_utc` and `_local` methods
(`vehicle.timestamp_utc`). The trip descriptor's `start_time` is a bare time,
so it is resolved against the `start_date` in the same trip descriptor, the
same way described below.

### Time-only fields (no date)

A few fields are returned as a bare time with no date at all (for
example `Schedule::Trip::Stop::ArrivalTime`/`DepartureTime#scheduled` and
`#computed`, and `Schedule::Journey::SchJourney::Service::Trip::Stop#time`).
Converting one of these to a real `Time` requires knowing which calendar
date it belongs to, and GO Transit's own "service date" doesn't line up
with calendar midnight: a service date that starts at 6am can run past
2am the next calendar day, and every stop in that overnight tail is still
part of the *original* service date, not the next one.

These fields still expose `_utc`/`_local`, resolved against a known
anchor date (the date you requested, for `Schedule.trip`, or the date
embedded in the response itself, for `Schedule::Journey.journey`, so you
never need to pass one in yourself). We use a boundry hours defined as
`GoTransit.service_day_boundary_hour` (default `4`). If the time is after
the boundry hour then it belongs to the day *after* the anchor date; otherwise
it's the anchor date itself. This correctly handles a trip whose very first stop
is already past midnight, with nothing else to compare it against. Optionally
you can change when this hour is. Local to Toronto time:

```ruby
GoTransit.configure do |config|
  config.service_day_boundary_hour = 3
end
```

Calling `_utc`/`_local` on one of these fields without ever going through
`Schedule.trip`/`Schedule.journey` (e.g. constructing the resource class
directly) raises `GoTransit::MissingAnchorDateError` rather than silently
assuming "today".

One endpoint's time-only fields don't get this treatment yet:
`ServiceUpdate::Exceptions::Trip::Stop#sch_arrival`/`#sch_departure`/
`#actual_time` are always `null` in every real response we've captured, so
their actual non-null format is unconfirmed, and the endpoint gives no
date to anchor them to either way. If you can confirm a real non-null
value for these fields, a PR is welcome.

## Missing Test Data
At the time of development I was unable to get test data for the following
endpoints. Some of these seem like they are restricted access endpoints and my
key is unable to fetch any data. I'm not sure if the others are caused by API
issues. These endpoints *should* work assuming the documenation is correct, but
the lack of data means testing was not possible. If you are able to get data for
these endpoints please open a PR and submit it, it would greatly help
development.

* `GET api/V1/ServiceataGlance/UPX/All` - 204 No Content
* `GET api/V1/ServiceUpdate/ServiceGuarantee/{TripNumber}/{OperationalDay}` - 204 No Content
* `GET api/V1/ServiceUpdate/MarketingAlert/All` - 204 No Content
* `GET api/V1/Fleet/Consist/All` - 403 Forbidden
* `GET api/V1/Fleet/Consist/Engine/{EngineNumber}` - 403 Forbidden

## Changing the API base url
In some cases you may want to change the base go transit API url. You can use
the `custom_base_url` config to set one:

```ruby
GoTransit.configure do |config|
  config.custom_base_url = "https://example.com"
end
```
