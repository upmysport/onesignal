require 'spec_helper'
require 'onesignal/gateway'

module Onesignal
  RSpec.describe Gateway do
    subject(:gategay) { described_class.new(configuration) }
    let(:configuration) { double(app_id: ENV['TEST_APP_ID']) }
    let(:identifier) { 'ce777617da7f548fe7a9ab6febb56cf39fba6d382000c0395666288d961ee566' }
    let(:device_type) { 0 }

    describe '#create_device' do
      let(:response) do
        VCR.use_cassette('create_device') do
          gategay.create_device(identifier: identifier, device_type: device_type)
        end
      end

      it 'returns a successfull response' do
        expect(response.status).to eq(200)
      end

      specify 'response body contains the device id' do
        expect(response.body).to include('id')
      end
    end

    describe '#create_notification' do
      let(:contents) { { en: 'Test message' } }
      let(:data) { { foo: 'bar' } }
      let(:device_id) do
        VCR.use_cassette('create_device') do
          response = gategay.create_device(identifier: identifier, device_type: device_type)
          response.body['id']
        end
      end
      let(:response) do
        VCR.use_cassette('create_notification') do
          gategay.create_notification(contents: contents, include_player_ids: [device_id], data: data)
        end
      end

      it 'returns a successfull response' do
        expect(response.status).to eq(200)
      end

      specify 'response body contains the notification id' do
        expect(response.body).to include('id')
      end

      specify 'response body contains the number of recipients' do
        expect(response.body).to include('recipients' => 1)
      end

      context 'when request is invalid' do
        let(:response) do
          VCR.use_cassette('create_notification_invalid_request') do
            gategay.create_notification(contents: {}, include_player_ids: ['invalid_id'])
          end
        end

        it 'returns a bad request response' do
          expect(response.status).to eq(400)
        end

        specify 'response body contains errors' do
          expect(response.body).to include('errors')
        end
      end
    end
  end
end
