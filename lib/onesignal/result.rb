module Onesignal
  class Result
    attr_reader :errors, :device_id

    def initialize(attributes = {})
      @errors = attributes.fetch(:errors, [])
      @device_id = attributes.fetch(:id, '')
    end

    def success?
      errors.empty?
    end

    def self.from_device_creation(gateway_response)
      Result.new(gateway_response)
    end
  end
end
