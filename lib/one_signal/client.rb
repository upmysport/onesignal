require 'one_signal/gateway'
require 'one_signal/add_device_status'

module OneSignal
  class Client
    attr_reader :gateway

    def initialize(gateway = Gateway.new)
      @gateway = gateway
    end

    def add_device(device_type:, identifier:)
      response = gateway.create_device(device_type: device_type, identifier: identifier)
      AddDeviceStatus.new(response)
    end
  end
end
