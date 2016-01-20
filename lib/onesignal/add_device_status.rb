module Onesignal
  # The AddDeviceStatus class is responsible of exposing the current status of the add device request
  # @since 0.0.1
  class AddDeviceStatus
    # @return [String] Onesignal device identifier
    attr_reader :id
    # @return [Array] List of errors
    attr_reader :errors

    def initialize(attributes = {})
      @id = attributes.fetch(:id, '')
      @errors = attributes.fetch(:errors, [])
      @success = attributes.fetch(:success, false)
    end

    # @return [Boolean]
    def success?
      @success
    end
  end
end
