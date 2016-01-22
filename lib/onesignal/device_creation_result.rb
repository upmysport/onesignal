require 'onesignal/result'

module Onesignal
  class DeviceCreationResult
    extend Forwardable

    attr_reader :device_id
    def_delegators :@result, :success?, :errors

    def initialize(result, gateway_response)
      @result = result
      @device_id = gateway_response.fetch(:id, '')
    end

    def self.from_device_creation(gateway_response)
      DeviceCreationResult.new(Result.new(gateway_response), gateway_response)
    end
  end
end
