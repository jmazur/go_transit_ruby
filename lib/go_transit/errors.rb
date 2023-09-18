module GoTransit
  class ApiError < StandardError
    def initialize(metadata)
      @message = metadata.error_message
    end
  end

  NoContentError = Class.new(ApiError)
  BadRequestError = Class.new(ApiError)
  UnauthorizedError = Class.new(ApiError)
  ForbiddenError = Class.new(ApiError)
  NotFoundError = Class.new(ApiError)
end
