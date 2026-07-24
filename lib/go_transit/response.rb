module GoTransit
  class Response
    attr_reader :metadata, :data

    delegate :code, :error_message, to: :metadata

    def initialize(payload, http_status = nil)
      @http_status = http_status
      @metadata = Metadata.new(payload.delete("Metadata") || fallback_metadata)
      @data = payload_data(payload)
      throw_error
    end

    private

    attr_reader :http_status

    def fallback_metadata
      { "ErrorCode" => http_status.to_s, "ErrorMessage" => "HTTP #{http_status}" }
    end

    def payload_data(payload)
      return payload.values.first unless payload.values.first.kind_of?(Array)
      payload
    end

    def throw_error
      # A genuine transport-level 429 always wins, even if the JSON body
      # (when there is one) claims success - GO Transit's own error
      # convention embeds the real code in the body, but an upstream
      # rate limiter returning 429 isn't guaranteed to follow that.
      raise TooManyRequestsError.new(metadata) if http_status == 429
      return if code == 200
      raise NoContentError.new(metadata) if code == 204
      raise BadRequestError.new(metadata) if code == 400
      raise UnauthorizedError.new(metadata) if code == 401
      raise ForbiddenError.new(metadata) if code == 403
      raise NotFoundError.new(metadata) if code == 404
      raise TooManyRequestsError.new(metadata) if code == 429
      raise StandardError.new(metadata)
    end
  end
end
