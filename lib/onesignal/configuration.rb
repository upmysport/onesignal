require 'logger'

# This class stores configuration data like Onesignal applicaiton id
class Configuration
  # @return [String] the Onesignal application id
  attr_accessor :app_id
  # set the value of ios_badge_type, `None, SetTo, Increase`
  attr_accessor :ios_badge_type
  # set the amount to increase the badge
  attr_accessor :ios_badge_count
  # set the iOS provisioning profile, '1 = Development, 2 = Ad-Hoc.Omit this field for App Store builds.
  attr_accessor :ios_device_test_type
  # @return [Logger] the default logger for all onesignal instances
  attr_accessor :log

  def initialize
    @ios_badge_type = 'Increase'
    @ios_badge_count = 1
    @log = Logger.new($stderr)
    @ios_device_test_type = nil
  end

  def ios_notification_params
    { ios_badgeType: ios_badge_type, ios_badgeCount: ios_badge_count }
  end

  def ios_device_params
    return {} if ios_device_test_type.nil?

    { test_type: ios_device_test_type }
  end
end
