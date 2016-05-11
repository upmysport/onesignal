require 'onesignal/version'
require 'onesignal/client'
require 'forwardable'
require 'logger'

# The Onesignal module provides access to all the main operations
module Onesignal
  class << self
    extend Forwardable
    # @return [Configuration]
    attr_accessor :configuration

    def_delegators :configuration, :app_id, :ios_badge_type, :ios_badge_count, :log, :test_type

    # @see Client#add_device
    def_delegators :client, :add_device
    # @see Client#notify
    def_delegators :client, :notify
  end

  # @return [Client] The client builder
  def self.client
    Onesignal::Client.new
  end

  # Exists to allow for realistic testing of initialised configuration
  # @return [Configuration] The replaced configuration singleton
  def self.reset_configuration
    self.configuration = Configuration.new
    yield(configuration)
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
    # @return [String] the badge type, `None, SetTo, Increase`
    attr_accessor :ios_badge_type
    # @return [Integer] the amount to increase the badge
    attr_accessor :ios_badge_count
    # @return [Logger] the default logger for all onesignal instances
    attr_accessor :log
    # @return [Integer] the test type for all onesignal device creation
    attr_accessor :test_type

    def initialize
      @ios_badge_type = 'Increase'
      @ios_badge_count = 1
      @log = Logger.new($stderr)
    end
  end
end
