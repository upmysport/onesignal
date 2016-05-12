require 'logger'

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

  def initialize
    @ios_badge_type = 'Increase'
    @ios_badge_count = 1
    @log = Logger.new($stderr)
  end
end
