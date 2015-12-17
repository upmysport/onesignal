module OneSignal
  class AddDeviceStatus
    attr_reader :id, :errors

    def initialize(attributes = {})
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def success?
      !!@success
    end
  end
end
