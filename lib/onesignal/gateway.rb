require 'onesignal/http_client'

module Onesignal
  # The Gateway class makes HTTP requests to the Onesignal REST API
  class Gateway
    DEVICES_ENDPOINT = 'api/v1/players'.freeze
    NOTIFICATIONS_ENDPOINT = 'api/v1/notifications'.freeze
    STATUSES_WITHOUT_BODY = [204, 304].freeze

    attr_reader :http_client
    protected :http_client

    def initialize(http_client = HTTPClient.new)
      @http_client = http_client
    end

    # Makes a POST request to the players endpoint
    # @return [Hash]
    def create_device(params = {})
      http_client.post(DEVICES_ENDPOINT, params)
    end

    # Makes a POST request to the notifications endpoint
    # @return [Hash]
    def create_notification(params = {})
      http_client.post(NOTIFICATIONS_ENDPOINT, params)
    end
  end
end
