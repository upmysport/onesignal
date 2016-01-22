module Onesignal
  class Result
    attr_reader :errors

    def initialize(attributes = {})
      @errors = attributes.fetch(:errors, [])
    end

    def success?
      errors.empty?
    end
  end
end
