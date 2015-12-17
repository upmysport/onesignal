require 'spec_helper'
require 'one_signal/client'

module OneSignal
  RSpec.describe Client do
    subject(:client) { described_class.new(gateway) }
    let(:gateway) { instance_double(Gateway, create_device: one_signal_response) }

    describe '#add_device' do
      let(:identifier) { 'ce777617da7f548fe7a9ab6febb56' }
      let(:type) { 0 }
      let(:one_signal_device_id) { 'ffffb794-ba37-11e3-8077-031d62f86ebf' }
      let(:one_signal_response) { { success: true, id: one_signal_device_id } }

      it 'sends the right message to the gateway' do
        client.add_device(device_type: type, identifier: identifier)

        expect(gateway).to have_received(:create_device).with(device_type: type, identifier: identifier)
      end

      it 'is success' do
        status = client.add_device(device_type: type, identifier: identifier)

        expect(status).to be_success
      end

      it 'returns a status object with the one signal device id' do
        status = client.add_device(device_type: type, identifier: identifier)

        expect(status.id).to eq(one_signal_device_id)
      end

      context 'when gateway returns errors' do
        let(:one_signal_response) { { errors: ['app_id not found'] } }
        let(:status) { client.add_device(identifier: '', device_type: '') }

        it 'is not success' do
          expect(status).to_not be_success
        end

        it 'returns a status object with no id' do
          expect(status.id).to be_nil
        end

        it 'returns a sttus object with an array of errors' do
          expect(status.errors).to eq(['app_id not found'])
        end
      end
    end
  end
end
