require 'spec_helper'
require 'one_signal'

RSpec.describe 'Add player/device to one signal applicaion' do
  subject(:add_device_status) do
    WebMock.allow_net_connect!
    VCR.turned_off do
      OneSignal.add_device(device_type: device_type, identifier: identifier)
    end
  end

  let(:device_type) { 0 }
  let(:identifier) { 'ce777617da7f548fe7a9ab6febb56cf39fba6d382000c0395666288d961ee566' }

  before do
    OneSignal.configure do |config|
      config.app_id = ENV['TEST_APP_ID']
    end
  end

  it 'returns a success response' do
    expect(add_device_status).to be_success
  end

  it 'returns device/player id' do
    expect(add_device_status.id).to_not be_nil
  end
end
