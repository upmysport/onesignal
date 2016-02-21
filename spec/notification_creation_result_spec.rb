require 'spec_helper'
require 'onesignal/notification_creation_result'

module Onesignal
  RSpec.describe NotificationCreationResult do
    subject(:result) { described_class.from_notification_creation(response) }

    describe '.from_notification_creation' do
      let(:id) { '7c77ae44-b4eb-43cc-abfd-27cc4e4c23c7' }
      let(:recipients) { 1 }
      let(:response) { double(status: 200, body: { 'id' => id, 'recipients' => recipients }) }

      it 'maps the response body values' do
        expect(result.notification_id).to eq(id)
        expect(result.recipients).to eq(recipients)
        expect(result.errors).to be_empty
      end

      it 'maps the status to success' do
        expect(result).to be_success
      end

      context 'when response is not sucess' do
        let(:errors) { ['one error'] }
        let(:response) { double(status: 400, body: { 'errors' => errors }) }

        it 'sets the notification_id to empty' do
          expect(result.notification_id).to eq('')
        end

        it 'sets the number of recipients to 0' do
          expect(result.recipients).to eq(0)
        end

        it 'maps the errors' do
          expect(result.errors).to eq(errors)
        end

        it 'maps the status to not success' do
          expect(result).to_not be_success
        end
      end
    end

    describe 'to_s' do
      let(:response) { double(status: 200, body: { 'id' => '1234', 'recipients' => 1 }) }

      it 'returns a string with the result values' do
        expect(result.to_s).to eq('Success, notification_id: 1234, recipients: 1')
      end

      context 'when response has errors' do
        let(:response) { double(status: 400, body: { 'errors' => ['one error'] }) }

        it 'returns a string with the erros' do
          expect(result.to_s).to eq('Errors: one error')
        end
      end
    end
  end
end
