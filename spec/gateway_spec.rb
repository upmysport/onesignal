require 'spec_helper'
require 'one_signal/gateway'
require 'dotenv'

module OneSignal
  RSpec.describe Gateway do
    subject(:gategay) { described_class.new(configuration) }
    let(:configuration) { double(app_id: ENV['TEST_APP_ID']) }

    before { Dotenv.load }

    describe '#create_device' do
      let(:identifier) { 'ce777617da7f548fe7a9ab6febb56cf39fba6d382000c0395666288d961ee566' }
      let(:device_type) { 0 }

      let(:response) do
        VCR.use_cassette('create_device') do
          gategay.create_device(identifier: identifier, device_type: device_type)
        end
      end

      it 'returns a successfull response' do
        expect(response).to include(success: true)
      end

      it 'returns the device id' do
        expect(response).to include(:id)
      end
    end
  end
end
