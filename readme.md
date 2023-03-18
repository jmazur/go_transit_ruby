# Go Transit API Ruby Wrapper
[![Tests](https://github.com/jmazur/go_transit_ruby/actions/workflows/tests.yml/badge.svg?label=test)](https://github.com/jmazur/go_transit_ruby/actions/workflows/tests.yml)

This gem is intended to make working with the Go Transit API easier and more
consistent. The API endpoints were re-created as close to the API spec wherever
possible, but some exceptions do exist. Reference the Go Transit API
documenation for details on available fields.

This gem does not parse any of the GTFS feeds. For those I recommend using a
gem dedicated to parsing GTFS Real Time feeds since it is a stardized data type.

## API Keys
You can get a Go Transit API key here
[http://api.openmetrolinx.com/OpenDataAPI/Help/Registration/en](http://api.openmetrolinx.com/OpenDataAPI/Help/Registration/en).

## Usage
Import go-transit-ruby and set your API key.

```ruby
require "go-transit-ruby"
GoTransit.api_key = "YOUR_API_KEY"
```

This gem exposes the Go Transit API endpoints and hydrates objects related to the returned data.

#### Stop
| Method                                               | Reference                                                                                           |
| :--------------------------------------------------- | :-------------------------------------------------------------------------------------------------- |
| `GoTransit::Stop.all`                                | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Stop-All)                    |
| `GoTransit::Stop.details(stop_code: <string>)`       | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Stop-Details-StopCode)       |
| `GoTransit::Stop.next_service(stop_code: <string>)`  | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Stop-NextService-StopCode)   |
| `GoTransit::Stop.destinations(stop_code: <string>, from_time: <string>, to_time: <string>)` | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Stop-Destinations-StopCode-FromTime-ToTime) |

#### Service Update
| Method                                        | Reference                                                                                                  |
| :-------------------------------------------- | :--------------------------------------------------------------------------------------------------------- |
| `GoTransit::ServiceUpdate.service_alerts`     | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-ServiceAlert-All)     |
| `GoTransit::ServiceUpdate.information_alerts` | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-InformationAlert-All) |
| `GoTransit::ServiceUpdate.marketing_alerts`   | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-MarketingAlert-All)   |
| `GoTransit::ServiceUpdate.union_departures`   | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-UnionDepartures-All)  |
| `GoTransit::ServiceUpdate.service_guarantee(trip_number: <string>, operational_day: <string>)` | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-ServiceGuarantee-TripNumber-OperationalDay) |
| `GoTransit::ServiceUpdate::Exceptions.train`  | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-Exceptions-Train)     |
| `GoTransit::ServiceUpdate::Exceptions.bus`    | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-Exceptions-Bus)       |
| `GoTransit::ServiceUpdate::Exceptions.all`    | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceUpdate-Exceptions-All)       |

#### Service At Glance
| Method                               | Reference                                                                                           |
| :----------------------------------- | :-------------------------------------------------------------------------------------------------- |
| `GoTransit::ServiceAtAGlance.buses`  | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceataGlance-Buses-All)  |
| `GoTransit::ServiceAtAGlance.trains` | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceataGlance-Trains-All) |
| `GoTransit::ServiceAtAGlance.upx`    | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-ServiceataGlance-UPX-All)    |

#### Schedule
| Method                                                                                                                                  | Reference                     |
| :-------------------------------------------------------------------------------------------------------------------------------------- | :---------------------------- |
| `GoTransit::Schedule.journey(date: <Date>, from_stop_code: <string>, to_stop_code: <string>, start_time: <string>, max_journey: <int>)` | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Journey-Date-FromStopCode-ToStopCode-StartTime-MaxJourney) |
| `GoTransit::Schedule.line(date: <Date>, line_code: <string>, line_direction: <string>)`                                                 | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Line-Date-LineCode-LineDirection) |
| `GoTransit::Schedule::Line.all(date: <Date>)`                                                                                           | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Line-All-Date) |
| `GoTransit::Schedule::Line.stop(date: <Date>, line_code: <string>, line_direction: <string>)`                                           | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Line-Stop-Date-LineCode-LineDirection) |
| `GoTransit::Schedule.trip(date: <Date>, trip_number: <string>)`                                                                         | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Schedule-Trip-Date-TripNumber) |

#### Fare
| Method                                                                                                  | Reference                                                      |
| :------------------------------------------------------------------------------------------------------ | :------------------------------------------------------------- |
| `GoTransit::Fare.get(from_stop_code: <string>, to_stop_code: <string>, operational_day: <nil\|string>)` | [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Fares-FromStopCode-ToStopCode) or [Link](http://api.openmetrolinx.com/OpenDataAPI/Help/Api/en/GET-api-V1-Fares-FromStopCode-ToStopCode-OperationalDay) |

## Missing Test Data
At the time of development I was unable to get test data for the following endpoints. Some of these seem like they are restricted access endpoints and my key is unable to fetch any data. I'm not sure if the others are caused by API issues. These endpoints *should* work assuming the documenation is correct, but the lack of data means testing was not possible. If you are able to get data for these endpoints please open a PR and submit it, it would greatly help development.

* `GET api/V1/ServiceataGlance/UPX/All` - 204 No Content
* `GET api/V1/ServiceUpdate/ServiceGuarantee/{TripNumber}/{OperationalDay}` - 204 No Content
* `GET api/V1/ServiceUpdate/MarketingAlert/All` - 204 No Content
* `GET api/V1/Fleet/Consist/All` - 403 Forbidden
* `GET api/V1/Fleet/Consist/Engine/{EngineNumber}` - 403 Forbidden
