require 'onesignal/result'
require 'forwardable'

module Onesignal
  # The NotificationCreationResult class is responsible of exposing the results of a notification creatino operation
  # @since 0.0.1
  class NotificationCreationResult
    extend Forwardable

    # @return [String] Onesignal notification identifier
    attr_reader :notification_id
    # @return [Integer] Number of deviceces that have received the notification
    attr_reader :recipients
    def_delegators :@result, :success?, :errors

    def initialize(result, gateway_response)
      @result = result
      @notification_id = gateway_response.fetch(:id, '')
      @recipients = gateway_response.fetch(:recipients, 0)
    end

    # Builds a NotificationCreationResult from a gateway response
    # @return [NotificationCreationResult]
    def self.from_notification_creation(gateway_response)
      NotificationCreationResult.new(Result.new(gateway_response), gateway_response)
    end

    def to_s
      return @result.to_s unless success?

      "#{@result}, notification_id: #{notification_id}, recipients: #{recipients}"
    end
  end
end
