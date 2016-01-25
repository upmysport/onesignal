require 'spec_helper'
require 'onesignal/client'

module Onesignal
  RSpec.describe Client do
    subject(:client) { described_class.new(gateway) }

    let(:onesignal_device_id) { 'ffffb794-ba37-11e3-8077-031d62f86ebf' }

    describe '#add_device' do
      let(:identifier) { 'ce777617da7f548fe7a9ab6febb56' }
      let(:type) { 0 }
      let(:onesignal_response) { { success: true, id: onesignal_device_id } }
      let(:gateway) { instance_double(Gateway, create_device: onesignal_response) }

      it 'sends the right message to the gateway' do
        client.add_device(device_type: type, identifier: identifier)

        expect(gateway).to have_received(:create_device).with(device_type: type, identifier: identifier)
      end

      it 'is success' do
        result = client.add_device(device_type: type, identifier: identifier)

        expect(result).to be_success
      end

      it 'returns a result object with the one signal device id' do
        result = client.add_device(device_type: type, identifier: identifier)

        expect(result.device_id).to eq(onesignal_device_id)
      end

      context 'when gateway returns errors' do
        let(:onesignal_response) { { errors: ['app_id not found'] } }
        let(:result) { client.add_device(identifier: '', device_type: '') }

        it 'is not success' do
          expect(result).to_not be_success
        end

        it 'returns a result object with an empty device_id' do
          expect(result.device_id).to be_empty
        end

        it 'returns a ressult object with an array of errors' do
          expect(result.errors).to eq(['app_id not found'])
        end
      end
    end

    describe '#notify' do
      let(:gateway) { instance_double(Gateway, create_notification: onesignal_response) }
      let(:number_of_recipients) { 1 }
      let(:response_id) { '458dcec4-cf53-11e3-add2-000c2940e62c' }
      let(:message) { 'Test notification' }
      let(:onesignal_response) { { id: response_id, recipients: number_of_recipients } }
      let(:data) { { foo: 'bar' } }
      let(:result) { client.notify(message: message, devices_ids: onesignal_device_id) }

      it 'sends the right message to the gateway' do
        client.notify(message: 'Test notification', devices_ids: onesignal_device_id, extra_data: data)

        expect(gateway).to have_received(:create_notification)
          .with(contents: { en: message }, include_player_ids: [onesignal_device_id], data: data)
      end

      it 'is success' do
        expect(result).to be_success
      end

      it 'returns a result object with the One Signal notification id' do
        expect(result.notification_id).to eq(response_id)
      end

      it 'returns a result object with the number of recipients' do
        expect(result.recipients).to eq(number_of_recipients)
      end

      context 'when the selected locale is :es' do
        let(:locale) { :es }

        it 'sends the right message to the gateway' do
          client.notify(message: message, devices_ids: onesignal_device_id, locale: :es)

          expect(gateway).to have_received(:create_notification)
            .with(contents: { es: message }, include_player_ids: [onesignal_device_id], data: {})
        end
      end

      context 'when gateway returns errors' do
        let(:onesignal_response) { { errors: ['app_id not found'] } }

        it 'is not success' do
          expect(result).to_not be_success
        end
        it 'returns an result object with an empty notification id' do
          expect(result.notification_id).to be_empty
        end
        it 'returns a status objects with 0 recipients' do
          expect(result.recipients).to eq(0)
        end
      end
    end
  end
end
