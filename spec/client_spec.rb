require 'spec_helper'
require 'onesignal/client'

module Onesignal
  RSpec.describe Client do
    subject(:client) { described_class.new(gateway, configuration) }

    let(:onesignal_device_id) { 'ffffb794-ba37-11e3-8077-031d62f86ebf' }
    let(:data) { { foo: 'bar' } }

    describe '#add_device' do
      let(:identifier) { 'ce777617da7f548fe7a9ab6febb56' }
      let(:type) { 0 }
      let(:onesignal_response) { double(status: 200, body: {}) }
      let(:gateway) { instance_double(Gateway, create_device: onesignal_response) }
      let(:configuration) { instance_double(Configuration) }

      it 'sends the right message to the gateway' do
        client.add_device(device_type: type, identifier: identifier)

        expect(gateway).to have_received(:create_device).with(device_type: type, identifier: identifier)
      end
    end

    describe '#notify' do
      let(:gateway) { instance_double(Gateway, create_notification: onesignal_response) }
      let(:message) { 'Test notification' }
      let(:onesignal_response) { double(status: 200, body: {}) }
      let(:badge_type) { 'Increase' }
      let(:badge_count) { 1 }
      let(:ios_notification_params) { { ios_badgeType: badge_type, ios_badgeCount: badge_count } }
      let(:configuration) do
        instance_double(Configuration, ios_notification_params: ios_notification_params)
      end
      let(:expected_params) do
        { contents: { en: message }, include_player_ids: [onesignal_device_id], data: data,
          ios_badgeType: badge_type, ios_badgeCount: badge_count }
      end
      let(:result) { client.notify(message: message, devices_ids: onesignal_device_id) }

      it 'sends the right message to the gateway' do
        client.notify(message: 'Test notification', devices_ids: onesignal_device_id, extra_data: data)

        expect(gateway).to have_received(:create_notification).with(expected_params)
      end

      context 'when the selected locale is :es' do
        let(:locale) { :es }
        let(:expected_params) do
          { contents: { es: message }, include_player_ids: [onesignal_device_id], data: {},
            ios_badgeType: badge_type, ios_badgeCount: badge_count }
        end

        it 'sends the right message to the gateway' do
          client.notify(message: message, devices_ids: onesignal_device_id, locale: :es)

          expect(gateway).to have_received(:create_notification).with(expected_params)
        end
      end
    end
  end
end
