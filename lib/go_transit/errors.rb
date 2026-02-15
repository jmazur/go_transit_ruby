module GoTransit
  class ApiError < StandardError
    def initialize(metadata)
      @message = metadata.error_message
    end
  end

  BadRequestError = Class.new(ApiError)
  ForbiddenError = Class.new(ApiError)
  NoContentError = Class.new(ApiError)
  NotFoundError = Class.new(ApiError)
  TooManyRequestsError = Class.new(ApiError)
  UnauthorizedError = Class.new(ApiError)
end
