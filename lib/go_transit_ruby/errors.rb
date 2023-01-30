module GoTransit
  class ApiError < StandardError
    def initialize(metadata)
      @message = metadata.error_message
    end
  end

  NoContentError = Class.new(ApiError)
  BadRequestError = Class.new(StandardError)
  UnauthorizedError = Class.new(StandardError)
  ForbiddenError = Class.new(StandardError)
  NotFoundError = Class.new(StandardError)
end
