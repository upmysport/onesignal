require 'spec_helper'
require 'onesignal'

RSpec.describe Onesignal do
  describe '.configure' do
    let(:app_id) { 'test id' }

    it 'sets default ios badge type to Increment' do
      expect(Onesignal.ios_badge_type).to eq('Increase')
    end

    it 'sets default ios count type to 1' do
      expect(Onesignal.ios_badge_count).to eq(1)
    end

    it 'sets the app_id value' do
      expect(Onesignal.app_id).to_not be_nil
    end

    it 'sets the default logger' do
      expect(Onesignal.log).to be_a(Logger)
    end

    context 'when badge information is provided' do
      let(:ios_badge_type) { 'SetTo' }
      let(:ios_badge_count) { 1 }

      before do
        Onesignal.configure do |config|
          config.ios_badge_type = ios_badge_type
          config.ios_badge_count = ios_badge_count
        end
      end

      it 'set default ios badge type is Increment' do
        expect(Onesignal.ios_badge_type).to eq(ios_badge_type)
      end

      it 'set default ios count type to 1' do
        expect(Onesignal.ios_badge_count).to eq(ios_badge_count)
      end
    end
  end

  describe '.test_type' do
    subject { Onesignal.test_type }

    before do
      old_config = Onesignal.configuration
      Onesignal.reset_configuration do |config|
        [:app_id, :log].each do |attr|
          config.send("#{attr}=".to_sym, old_config.send(attr))
        end
      end
    end

    context 'default value' do
      it { is_expected.to be_nil }
    end

    context 'when test type is set' do
      before do
        Onesignal.configure do |config|
          config.test_type = 1
        end
      end

      it { is_expected.to eq(1) }
    end
  end
end
