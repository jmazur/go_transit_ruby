module GoTransit
  class Metadata < ApiResource
    attr_accessor :time_stamp, :error_code, :error_message

    def to_s
      "#{error_code} - #{error_message}"
    end

    def code
      error_code.to_i
    end

    def time_stamp_utc
      to_utc(time_stamp)
    end
  end
end
