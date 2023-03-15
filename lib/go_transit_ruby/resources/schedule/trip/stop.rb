module GoTransit
  class Schedule::Trip::Stop < ApiResource
    attr_accessor :arrival_time, :departure_time, :track, :code, :status, 
                  :remark
  end
end