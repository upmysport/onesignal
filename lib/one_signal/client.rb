require 'one_signal/gateway'
require 'one_signal/add_device_status'

module OneSignal
  # The Client is a class responsible of handling all the requests to OneSignal REST API
  # @since 0.0.1
  class Client
    attr_reader :gateway

    def initialize(gateway = Gateway.new)
      @gateway = gateway
    end

    # Registers a new device with OneSignal. If the device is already registered,
    # then this will update the existing device record instead of creating a new one.
    #
    # @example Add device to your OneSignal app
    #   status = Client.new.add_device(device_type: 0, identifier: 'ce777617da7f548fe7a9ab6febb56')
    #   status.success? #=> true
    #   status.id #=> 'ffffb794-ba37-11e3-8077-031d62f86ebf'
    #
    # @param device_type [Integer] nuber of device 0 = iOS, 1 = Android
    # @param identifier [String] Push notification identifier from Google or Apple
    # @return [AddDeviceStatus] The response object which holds the add device status
    def add_device(device_type:, identifier:)
      response = gateway.create_device(device_type: device_type, identifier: identifier)
      AddDeviceStatus.new(response)
    end
  end
end
