require 'resas_kit/response/middleware'

module ResasKit
  class Response
    class RaiseError < ResasKit::Response::Middleware
      CODE_ERRORS = {
        403 => ResasKit::ForbiddenError,
        404 => ResasKit::NotFoundError,
        429 => ResasKit::TooManyRequestsError
      }.freeze

      def on_complete(env)
        super
        raise ResasKit::Error, error_message unless success?
      end

      private

      def success?
        json_body.key?('result')
      end

      def error_message
        klass = CODE_ERRORS[json_body['statusCode'].to_i] || ResasKit::UnexpectedError
        klass.build_error_message(json_body)
      end

      def json_body
        @json_body ||= JSON.parse(body)
      end
    end

    Faraday::Response.register_middleware(error: RaiseError)
  end
end
