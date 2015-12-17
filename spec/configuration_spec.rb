require 'spec_helper'
require 'one_signal'

RSpec.describe OneSignal do
  describe '.configure' do
    let(:app_id) { 'test id' }

    before do
      OneSignal.configure do |config|
        config.app_id = app_id
      end
    end

    it 'sets the app_id value' do
      expect(OneSignal.app_id).to eq(app_id)
    end
  end
end
