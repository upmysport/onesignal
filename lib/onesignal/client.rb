require 'onesignal/gateway'
require 'onesignal/notification_creation_result'
require 'onesignal/device_creation_result'

module Onesignal
  # The Client is a class responsible of handling all the requests to Onesignal REST API
  # @since 0.0.1
  class Client
    attr_reader :gateway

    def initialize(gateway = Gateway.new, configuration = Onesignal.configuration)
      @gateway = gateway
      @configuration = configuration
    end

    # Registers a new device with Onesignal. If the device is already registered,
    # then this will update the existing device record instead of creating a new one.
    #
    # @example Add device to your Onesignal app
    #   result = Client.new.add_device(device_type: 0, identifier: 'ce777617da7f548fe7a9ab6febb56')
    #   result.success? #=> true
    #   result.device_id #=> 'ffffb794-ba37-11e3-8077-031d62f86ebf'
    #
    # @param device_type [Integer] nuber of device 0 = iOS, 1 = Android
    # @param identifier [String] Push notification identifier from Google or Apple
    # @return [DeviceCreationResult] The response object which holds the add device status
    def add_device(device_type:, identifier:)
      DeviceCreationResult.from_device_creation(
        gateway.create_device(environment_params.merge(device_type: device_type, identifier: identifier))
      )
    end

    # Sends a notification to devices
    #
    # @example Sends a notification to a list of registered devices
    #   result = Client.notify(message: 'Test notification', devices_ids: ['1dd608f2-c6a1-11e3-851d-000c2940e62c'])
    #   result.success? #=> true
    #   result.recipients #=> 1
    #   result.notification_id #=> '458dcec4-cf53-11e3-add2-000c2940e62c'
    #
    # @param message [String] message to send
    # @param devices_ids [Array<Sring>, String]
    # @param locale [Symbol] the message locale, `:en, :es, :de`
    # @param extra_data[Hash] Custom key value pair hash that you can programmaticallyin your app
    # @return [NotificationCreationResult] The response objecte wich holds the push notification status
    def notify(message:, devices_ids:, locale: :en, extra_data: {})
      params = {
        contents: { locale => message },
        include_player_ids: Array(devices_ids),
        data: extra_data
      }.merge(ios_params)

      NotificationCreationResult.from_notification_creation(gateway.create_notification(params))
    end

    private

    def environment_params
      return {} if @configuration.test_type.nil?

      { test_type: @configuration.test_type }
    end

    def ios_params
      { ios_badgeType: @configuration.ios_badge_type, ios_badgeCount: @configuration.ios_badge_count }
    end
  end
end
