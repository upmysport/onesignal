require 'logger'

# This class stores configuration data like Onesignal applicaiton id
class Configuration
  # @return [String] the Onesignal application id
  attr_accessor :app_id
  # set the value of ios_badge_type, `None, SetTo, Increase`
  attr_writer :ios_badge_type
  # set the amount to increase the badge
  attr_writer :ios_badge_count
  # @return [Logger] the default logger for all onesignal instances
  attr_accessor :log

  def initialize
    @ios_badge_type = 'Increase'
    @ios_badge_count = 1
    @log = Logger.new($stderr)
  end

  def ios_notification_params
    { ios_badgeType: @ios_badge_type, ios_badgeCount: @ios_badge_count }
  end
end
