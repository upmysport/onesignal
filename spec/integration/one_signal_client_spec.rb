require 'spec_helper'
require 'one_signal'

RSpec.describe 'One Signal API client' do
  let(:device_type) { 0 }
  let(:identifier) { 'ce777617da7f548fe7a9ab6febb56cf39fba6d382000c0395666288d961ee566' }

  before(:all) do
    WebMock.allow_net_connect!
    VCR.turn_off!
    OneSignal.configure do |config|
      config.app_id = ENV['TEST_APP_ID']
    end
  end

  after(:all) do
    VCR.turn_on!
  end

  it 'adds a device to a One Signal application' do
    status = OneSignal.add_device(device_type: device_type, identifier: identifier)

    expect(status).to be_success
    expect(status.id).to_not be_nil
  end

  it 'sends a notification to a device' do
    device_id = OneSignal.add_device(device_type: device_type, identifier: identifier).id
    notification_status = OneSignal.notify(message: 'Test notification', devices_ids: device_id)

    expect(notification_status).to be_success
    expect(notification_status.id).to_not be_nil
    expect(notification_status.recipients).to eq(1)
  end
end
