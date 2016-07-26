require 'onesignal/version'
require 'onesignal/client'
require 'onesignal/configuration'
require 'forwardable'

# The Onesignal module provides access to all the main operations
module Onesignal
  DEVICE_TYPES = { ios: 0, android: 1 }.freeze

  class << self
    extend Forwardable
    # @return [Configuration]
    attr_accessor :configuration
    protected :configuration=

    def_delegators :configuration, :app_id, :log

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
    yield(configuration) if block_given?
  end
end
