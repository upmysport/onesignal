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

    def initialize(response)
      @success = (response.status == 200)
      response_body = response.body || {}
      @notification_id = response_body.fetch('id', '')
      @recipients = response_body.fetch('recipients', 0)
      @errors = response_body.fetch('errors', [])
    end

    # Builds a NotificationCreationResult from a gateway response
    # @return [NotificationCreationResult]
    def self.from_notification_creation(gateway_response)
      NotificationCreationResult.new(gateway_response)
    end

    # @return [Boolean] Returns true when the operation was success
    def success?
      @success
    end

    def to_s
      return "Errors: #{@errors.join(', ')}" unless success?

      "Success, notification_id: #{notification_id}, recipients: #{recipients}"
    end
  end
end
