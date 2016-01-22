module Onesignal
  class DeviceCreationResult
    extend Forwardable

    attr_reader :device_id
    def_delegators :@result, :success?, :errors

    def initialize(result, gateway_response)
      @result = result
      @device_id = gateway_response.fetch(:id, '')
    end
  end
end
