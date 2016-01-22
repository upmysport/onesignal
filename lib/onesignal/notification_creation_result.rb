require 'onesignal/result'

module Onesignal
  class NotificationCreationResult
    extend Forwardable

    attr_reader :notification_id, :recipients
    def_delegators :@result, :success?, :errors

    def initialize(result, gateway_response)
      @result = result
      @notification_id = gateway_response.fetch(:id, '')
      @recipients = gateway_response.fetch(:recipients, 0)
    end

    def self.from_notification_creation(gateway_response)
      NotificationCreationResult.new(Result.new(gateway_response), gateway_response)
    end
  end
end
