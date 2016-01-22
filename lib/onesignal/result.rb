module Onesignal
  class Result
    attr_reader :errors, :device_id, :notification_id, :recipients

    def initialize(attributes = {})
      @errors = attributes.fetch(:errors, [])
      @device_id = attributes.fetch(:device_id, '')
      @notification_id = attributes.fetch(:notification_id, '')
      @recipients = attributes.fetch(:recipients, 0)
    end

    def success?
      errors.empty?
    end

    def self.from_device_creation(gateway_response)
      gateway_response[:device_id] = gateway_response.delete(:id) || ''
      Result.new(gateway_response)
    end

    def self.from_notification_creation(gateway_response)
      gateway_response[:notification_id] = gateway_response.delete(:id) || ''
      Result.new(gateway_response)
    end
  end
end
