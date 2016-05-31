require 'faraday'
require 'faraday_middleware'

module Onesignal
  class HTTPClient
    URL = 'https://onesignal.com'.freeze

    attr_reader :app_id, :connection

    def initialize(log = Onesignal.log, app_id = Onesignal.app_id)
      @app_id = app_id
      @connection = Faraday.new(url: URL) do |connection|
        connection.request :json
        connection.request :retry
        connection.response :json, content_type: /\bjson$/
        connection.adapter Faraday.default_adapter
        connection.response :logger, log, bodies: true
      end
    end

    def post(endpoint, params)
      connection.post(endpoint, params.merge(app_id: app_id))
    end
  end
end
