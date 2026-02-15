module GoTransit
  class Response
    attr_reader :metadata, :data, :response_code

    delegate :code, :error_message, to: :metadata

    def initialize(payload, response_code)
      @metadata = Metadata.new(payload.delete("Metadata"))
      @data = payload_data(payload)
      @response_code = response_code
      throw_error
    end

    private

    def payload_data(payload)
      return payload.values.first unless payload.values.first.kind_of?(Array)
      payload
    end

    def throw_error
      return if code == 200
      raise NoContentError.new(metadata) if code == 204
      raise BadRequestError.new(metadata) if code == 400
      raise UnauthorizedError.new(metadata) if code == 401
      raise ForbiddenError.new(metadata) if code == 403
      raise NotFoundError.new(metadata) if code == 404
      raise NotFoundError.new(metadata) if not_found?
      raise TooManyRequestsError.new(metadata) if code == 429
      raise TooManyRequestsError.new(metadata) if too_many_requests?
      raise StandardError.new(metadata)
    end

    def not_found?
      response_code == Net::HTTPNotFound
    end

    def too_many_requests?
      response_code == Net::HTTPTooManyRequests
    end
  end
end
