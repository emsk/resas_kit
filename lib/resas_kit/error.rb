module ResasKit
  # Custom error class for rescuing from RESAS errors
  class Error < StandardError
    # Make a custom error message
    #
    # @param response [Hash] Error response
    # @return [String] Error message
    def self.build_error_message(response)
      status_code = response['statusCode'].to_s
      description = response['description'].to_s

      message = "#{name.demodulize} - #{response['message']}"
      message += " (STATUS CODE: #{status_code})" unless status_code.empty?
      message += " (DESCRIPTION: #{description})" unless description.empty?
      message
    end
  end

  class ConnectionError < Error; end
  class UnexpectedError < Error; end
  class BadRequestError < Error; end
  class ForbiddenError < Error; end
  class NotFoundError < Error; end
  class TooManyRequestsError < Error; end
end
