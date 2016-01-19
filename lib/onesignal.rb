require 'onesignal/version'
require 'onesignal/client'
require 'forwardable'

# The Onesignal module provides access to all the main operations
module Onesignal
  class << self
    extend Forwardable
    # @return [Configuration]
    attr_accessor :configuration

    # @see Configuration#app_id
    def_delegators :configuration, :app_id

    # @see Client#add_device
    def_delegators :client, :add_device
    # @see Client#notify
    def_delegators :client, :notify
  end

  # @return [Client] The client builder
  def self.client
    Onesignal::Client.new
  end

  # @return [Configuration] The configuration singleton
  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  # This class stores configuration data like Onesignal applicaiton id
  class Configuration
    # @return [String] the Onesignal application id
    attr_accessor :app_id
  end
end
