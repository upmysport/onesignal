require 'onesignal/gateway'

module Onesignal
  # The DeviceCreationResult class is responsible of exposing the results of a device creatino operation
  # @since 0.0.1
  class DeviceCreationResult
    # @return [String] Onesignal device identifier
    attr_reader :device_id
    # @return [Array] Array of error messages
    attr_reader :errors

    def initialize(attributes)
      @device_id = attributes.fetch('id', '')
      @errors = attributes.fetch('errors', [])
    end

    # Builds a DeviceCreationResult from a gateway response
    # @return [DeviceCreationResult]
    def self.from_device_creation(gateway_response)
      if Gateway::STATUSES_WITHOUT_BODY.include?(gateway_response.status)
        DeviceCreationResult.new('errors' => [''])
      else
        DeviceCreationResult.new(gateway_response.body)
      end
    end

    # @return [Boolean] Returns true when the operation was success
    def success?
      @errors.empty?
    end

    def to_s
      return "Errors: #{@errors}" unless success?

      "Success, device_id: #{device_id}"
    end
  end
end
