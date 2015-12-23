module OneSignal
  # The AddDeviceStatus class is responsible of exposing the current status of the add device request
  # @since 0.0.1
  class AddDeviceStatus
    # @return [String] OneSignal device identifier
    attr_reader :id
    # @return [Array] List of errors
    attr_reader :errors

    def initialize(attributes = {})
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    # @return [Boolean]
    def success?
      !!@success
    end
  end
end
