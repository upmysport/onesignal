require 'spec_helper'
require 'onesignal'

RSpec.describe 'One Signal API client' do
  let(:device_type) { 0 }
  let(:identifier) { 'a4179573652efd80f11ace1496f84f6c96eb2928bedbd70c2329ad4e44537b25' }
  let(:message) { 'Leave a review for Pierre!' }
  let(:extra_data) do
    { type: 'review', listing_id: '337', username: 'pierreespenan0' }
  end

  before(:all) do
    WebMock.allow_net_connect!
    VCR.turn_off!
    Onesignal.configure do |config|
      config.app_id = ENV['TEST_APP_ID']
    end
  end

  after(:all) do
    VCR.turn_on!
  end

  it 'adds a device to a One Signal application' do
    result = Onesignal.add_device(device_type: device_type, identifier: identifier)

    expect(result).to be_success
    expect(result.device_id).to_not be_nil
  end

  it 'sends a notification to a device' do
    device_id = Onesignal.add_device(device_type: device_type, identifier: identifier).device_id
    result = Onesignal.notify(message: message, devices_ids: device_id, extra_data: extra_data)

    expect(result).to be_success
    expect(result.notification_id).to_not be_nil
    expect(result.recipients).to eq(1)
  end
end
