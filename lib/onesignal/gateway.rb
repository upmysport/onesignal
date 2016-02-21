require 'faraday'
require 'faraday_middleware'

module Onesignal
  # The Gateway class makes HTTP requests to the Onesignal REST API
  class Gateway
    URL = 'https://onesignal.com'.freeze
    DEVICES_ENDPOINT = 'api/v1/players'.freeze
    NOTIFICATIONS_ENDPOINT = 'api/v1/notifications'.freeze

    def initialize(configuration = Onesignal.configuration)
      @http_client = create_http_client
      @configuration = configuration
    end

    # Makes a POST request to the players endpoint
    # @return [Hash]
    def create_device(params = {})
      @http_client.post(DEVICES_ENDPOINT, params.merge(app_id: @configuration.app_id))
    end

    # Makes a POST request to the notifications endpoint
    # @return [Hash]
    def create_notification(params = {})
      @http_client.post(NOTIFICATIONS_ENDPOINT, params.merge(app_id: @configuration.app_id))
    end

    private

    def create_http_client
      Faraday.new(url: URL) do |faraday|
        faraday.request :json
        faraday.response :json, content_type: /\bjson$/
        faraday.adapter Faraday.default_adapter
      end
    end
  end
end
