require 'spec_helper'
require 'onesignal'

RSpec.describe Onesignal do
  describe '.configure' do
    let(:app_id) { 'test id' }

    before do
      Onesignal.configure do |config|
        config.app_id = app_id
      end
    end

    it 'sets the app_id value' do
      expect(Onesignal.app_id).to eq(app_id)
    end
  end
end
