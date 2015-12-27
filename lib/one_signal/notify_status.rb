module OneSignal
  class NotifyStatus
    attr_reader :id, :recipients, :errors

    def initialize(attributes = {})
      @id = attributes.fetch(:id, '')
      @recipients = attributes.fetch(:recipients, 0)
      @errors = attributes.fetch(:errors, [])
    end

    def success?
      errors.empty?
    end
  end
end
