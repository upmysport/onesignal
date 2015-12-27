require 'one_signal/version'
require 'one_signal/client'
require 'forwardable'

# The OneSignal module provides access to all the main operations
module OneSignal
  class << self
    extend Forwardable
    # @return [Configuration]
    attr_accessor :configuration

    # @see Configuration#app_id
    def_delegators :configuration, :app_id

    # @see Client#add_device
    def_delegators :client, :add_device
    def_delegators :client, :notify
  end

  # @return [Client] The client builder
  def self.client
    OneSignal::Client.new
  end

  # @return [Configuration] The configuration singleton
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # This class stores configuration data like OneSignal applicaiton id
  class Configuration
    # @return [String] the OneSignal application id
    attr_accessor :app_id
  end
end
