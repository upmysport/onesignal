require 'onesignal/result'
require 'forwardable'

module Onesignal
  # The DeviceCreationResult class is responsible of exposing the results of a device creatino operation
  # @since 0.0.1
  class DeviceCreationResult
    # @return [String] Onesignal device identifier
    attr_reader :device_id
    # @return [Array] Array of error messages
    attr_reader :errors

    def initialize(status, response_body)
      @success = (status == 200)
      @device_id = response_body.fetch('id', '')
      @errors = response_body.fetch('errors', [])
    end

    # Builds a DeviceCreationResult from a gateway response
    # @return [DeviceCreationResult]
    def self.from_device_creation(gateway_response)
      DeviceCreationResult.new(gateway_response.status, gateway_response.body)
    end

    # @return [Boolean] Returns true when the operation was success
    def success?
      @success
    end

    def to_s
      return "Errors: #{@errors.join(', ')}" unless success?

      "Success, device_id: #{device_id}"
    end
  end
end
