module IciciService
  class Request
    attr_reader :params, :event

    def initialize(params, event)
      @params = params
      @event = event
    end

    def response
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = Crypto.new(params).encrypt_for_icici
      Icici::Response.new(http, request)
    end

    private

    def headers
      {
        'Content-Type' => 'application/json',
        'apikey' => 'Re4145TRGmk51J'
      }
    end

    def url
      "#{API_END_POINT}#{EVENT_URL_MAP[event.to_sym]}"
    end
  end
end