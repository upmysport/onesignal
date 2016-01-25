module Onesignal
  # The Result class is responsible of exposing the status of an operation
  # @since 0.0.1
  class Result
    # @return [Array, Hash] List of errors
    attr_reader :errors

    def initialize(attributes = {})
      @errors = attributes.fetch(:errors, [])
    end

    # @return [Boolean]
    def success?
      errors.empty?
    end
  end
end
