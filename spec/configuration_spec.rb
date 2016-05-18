require 'spec_helper'

RSpec.describe Configuration do
  subject(:configuration) { described_class.new }

  specify 'Logger is the default logger' do
    expect(configuration.log).to be_a(Logger)
  end

  describe '#ios_notification_params' do
    let(:expected_params) { { ios_badgeType: 'Increase', ios_badgeCount: 1 } }

    it 'returns a hash with the iOS notification default values' do
      expect(configuration.ios_notification_params).to eq(expected_params)
    end

    context 'when badge information is provided' do
      let(:badge_count) { 2 }
      let(:badge_type) { 'Test' }
      let(:expected_params) { { ios_badgeType: badge_type, ios_badgeCount: badge_count } }

      it 'returns the provided values' do
        configuration.ios_badge_type = badge_type
        configuration.ios_badge_count = badge_count

        expect(configuration.ios_notification_params).to eq(expected_params)
      end
    end
  end

  describe '#app_id=' do
    let(:app_id) { 1 }

    it 'sets the Onesignal app_id' do
      configuration.app_id = app_id
      expect(configuration.app_id).to eq(app_id)
    end
  end
end
