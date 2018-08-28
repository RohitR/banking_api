require 'net/http'
module IciciService
  class Request
    attr_reader :params, :event

    def initialize(params, event = nil)
      @params = params
      @event = event
    end

    def response
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      request = Net::HTTP::Post.new(uri.request_uri, headers)
      request.body = Crypto.new(params).encrypt_for_icici
      IciciService::Response.new(http, request)
    end

    def spp_callback
      uri = URI.parse(spp_callback_url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == 'https')
      request = Net::HTTP::Post.new(uri.request_uri, spp_headers)
      request.body = {data: Crypto.new(params).encrypt_for_spp}.to_json
      IciciService::Response.new(http, request)
    end

    private

    def headers
      {
        'Content-Type' => 'application/json',
        'apikey' => 'Re4145TRGmk51J'
      }
    end

    def spp_headers
      {
        'Content-Type' => 'application/json',
        'Authorization' => "Token token=#{Tenant.find_by(subdomain: Apartment::Tenant.current).api_key}"
      }
    end

    def url
      "#{API_END_POINT}#{EVENT_URL_MAP[event.to_sym]}"
    end

    def spp_callback_url
      tenant = Apartment::Tenant.current
      "http://#{tenant}.#{SPP_DOMAIN}/api/icici_bankings/callback"
    end
  end
end