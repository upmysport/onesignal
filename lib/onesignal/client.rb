require 'onesignal/gateway'
require 'onesignal/result'
require 'onesignal/notify_status'

module Onesignal
  # The Client is a class responsible of handling all the requests to Onesignal REST API
  # @since 0.0.1
  class Client
    attr_reader :gateway

    def initialize(gateway = Gateway.new)
      @gateway = gateway
    end

    # Registers a new device with Onesignal. If the device is already registered,
    # then this will update the existing device record instead of creating a new one.
    #
    # @example Add device to your Onesignal app
    #   status = Client.new.add_device(device_type: 0, identifier: 'ce777617da7f548fe7a9ab6febb56')
    #   status.success? #=> true
    #   status.id #=> 'ffffb794-ba37-11e3-8077-031d62f86ebf'
    #
    # @param device_type [Integer] nuber of device 0 = iOS, 1 = Android
    # @param identifier [String] Push notification identifier from Google or Apple
    # @return [AddDeviceStatus] The response object which holds the add device status
    def add_device(device_type:, identifier:)
      Result.from_device_creation(
        gateway.create_device(device_type: device_type, identifier: identifier)
      )
    end

    # Sends a notification to devices
    #
    # @example Sends a notification to a list of registered devices
    #   status = Clientj.notify(message: 'Test notification', devices_ids: ['1dd608f2-c6a1-11e3-851d-000c2940e62c'])
    #   status.success? #=> true
    #   status.recipients #=> 1
    #   status.id #=> '458dcec4-cf53-11e3-add2-000c2940e62c'
    #
    # @param message [String] message to send
    # @param devices_ids [Array<Sring>, String]
    # @param locale [Symbol] the message locale, `:en, :es, :de`
    # @return [NotifyStatus] The response objecte wich holds the push notification status
    def notify(message:, devices_ids:, locale: :en)
      contents = { locale => message }
      response = gateway.create_notification(contents: contents, include_player_ids: Array(devices_ids))
      NotifyStatus.new(response)
    end
  end
end
