require 'dotenv'
require 'onesignal'
require 'fileutils'
require 'codeclimate-test-reporter'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.disable_monkey_patching!
  config.warnings = true
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.profile_examples = 3
  config.order = :random
  Kernel.srand config.seed
  config.filter_run_excluding integration: true
end

Dotenv.load

FileUtils.mkdir_p 'tmp'

Onesignal.configure do |config|
  config.app_id = ENV['TEST_APP_ID']
  logger = Logger.new(File.new('tmp/test.log', 'w'))
  config.log = logger
  config.ios_device_test_type = 2
end

CodeClimate::TestReporter.start
