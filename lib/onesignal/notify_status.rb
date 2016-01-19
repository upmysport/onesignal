module Onesignal
  # The NotifyStatus class is responsible of exposing the current status of the notify request
  # @since 0.0.1
  class NotifyStatus
    # @return [String] Notification identifier
    attr_reader :id
    # @return [Integer] Number of devices to which the notification has been sent
    attr_reader :recipients
    # @return [Array, Hash] List of errors
    attr_reader :errors

    def initialize(attributes = {})
      @id = attributes.fetch(:id, '')
      @recipients = attributes.fetch(:recipients, 0)
      @errors = attributes.fetch(:errors, [])
    end

    # @return [Boolean] The state of the notification
    def success?
      errors.empty?
    end
  end
end
