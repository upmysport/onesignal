require 'one_signal/version'
require 'forwardable'

module OneSignal
  class << self
    extend Forwardable
    attr_accessor :configuration

    def_delegators :configuration, :app_id
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :app_id
  end
end
