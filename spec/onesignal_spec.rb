require 'spec_helper'

RSpec.describe Onesignal do
  describe '.configure' do
    before { Onesignal.configure }

    it 'creates a new instance of Configuration' do
      expect(Onesignal.configuration).to be_a(Configuration)
    end

    context 'when configuration exists' do
      it 'does not create a new instance' do
        configuration = Onesignal.configuration
        Onesignal.configure
        expect(Onesignal.configuration).to eq(configuration)
      end
    end

    context 'when configuration block is given' do
      let(:logger) { 'test' }

      it 'yields the configuration object' do
        expect { |config| Onesignal.configure(&config) }.to yield_with_args(Configuration)
      end
    end
  end
end
