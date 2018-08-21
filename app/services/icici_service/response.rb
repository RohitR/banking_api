module IciciService
  class Response
    attr_reader :http_response

    def initialize(http, request)
      @http_response = http.request(request)
    end

    def success?
      http_response.status == 200 && data.fetch('Response') == 'Success'
    end

    def error_message
      data.fetch('Message')
    end

    def failure?
      data.fetch('Response') == 'Failure'
    end

    def data
      http_response.parse(:json)
    end

  end
end