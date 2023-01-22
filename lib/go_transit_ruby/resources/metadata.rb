module GoTransit
  class Metadata < ApiResource
    attr_accessor :time_stamp, :error_code, :error_message

    def code
      error_code.to_i
    end
  end
end
