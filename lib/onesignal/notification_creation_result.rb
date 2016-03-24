require 'onesignal/gateway'

module Onesignal
  # The NotificationCreationResult class is responsible of exposing the results of a notification creatino operation
  # @since 0.0.1
  class NotificationCreationResult
    # @return [String] Onesignal notification identifier
    attr_reader :notification_id
    # @return [Integer] Number of deviceces that have received the notification
    attr_reader :recipients
    # @return [Array] Array of error messages strings
    attr_reader :errors

    def initialize(attributes)
      @notification_id = attributes.fetch('id', '')
      @recipients = attributes.fetch('recipients', 0)
      @errors = attributes.fetch('errors', [])
    end

    # Builds a NotificationCreationResult from a gateway response
    # @return [NotificationCreationResult]
    def self.from_notification_creation(gateway_response)
      if Gateway::STATUSES_WITHOUT_BODY.include?(gateway_response.status)
        NotificationCreationResult.new('errors' => [''])
      else
        NotificationCreationResult.new(gateway_response.body)
      end
    end

    # @return [Boolean] Returns true when the operation was success
    def success?
      errors.empty?
    end

    def to_s
      return "Errors: #{errors}" unless success?

      "Success, notification_id: #{notification_id}, recipients: #{recipients}"
    end
  end
end
