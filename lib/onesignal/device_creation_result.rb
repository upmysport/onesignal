require 'onesignal/result'

module Onesignal
  # The DeviceCreationResult class is responsible of exposing the results of a device creatino operation
  # @since 0.0.1
  class DeviceCreationResult
    extend Forwardable

    # @return [String] Onesignal device identifier
    attr_reader :device_id
    def_delegators :@result, :success?, :errors

    def initialize(result, gateway_response)
      @result = result
      @device_id = gateway_response.fetch(:id, '')
    end

    # Builds a DeviceCreationResult from a gateway response
    # @return [DeviceCreationResult]
    def self.from_device_creation(gateway_response)
      DeviceCreationResult.new(Result.new(gateway_response), gateway_response)
    end
  end
end
