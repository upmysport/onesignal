require 'faraday'
require 'faraday_middleware'

module OneSignal
  # The Gateway class makes HTTP requests to the OneSignal REST API
  class Gateway
    URL = 'https://onesignal.com'.freeze
    DEVICES_ENDPOINT = 'api/v1/players'.freeze
    NOTIFICATIONS_ENDPOINT = 'api/v1/notifications'.freeze

    def initialize(configuration = OneSignal.configuration)
      @http_client = create_http_client
      @configuration = configuration
    end

    # Makes a POST request to the players endpoint
    # @return [Hash]
    def create_device(params = {})
      response = @http_client.post(DEVICES_ENDPOINT, params.merge(app_id: @configuration.app_id))
      symbolize_keys(response.body)
    end

    # Makes a POST request to the notifications endpoint
    # @return [Hash]
    def create_notification(params = {})
      response = @http_client.post(NOTIFICATIONS_ENDPOINT, params.merge(app_id: @configuration.app_id))
      symbolize_keys(response.body)
    end

    private

    def create_http_client
      Faraday.new(url: URL) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end

    def symbolize_keys(hash)
      hash.each_with_object({}) { |(k, v), h| h[k.to_sym] = v }
    end
  end
end
