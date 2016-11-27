module ResasKit
  class Response
    class Middleware < Faraday::Response::Middleware
      attr_reader(:headers, :status, :body)

      def on_complete(env)
        @headers = env.response_headers
        @status  = env.status
        @body    = env.body
      end
    end
  end
end
