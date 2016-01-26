require 'spec_helper'
require 'onesignal/notification_creation_result'

module Onesignal
  RSpec.describe NotificationCreationResult do
    subject(:result) { described_class.from_notification_creation(response) }

    describe 'to_s' do
      let(:response) { { id: '1234', recipients: 1 } }

      it 'returns a string with the result values' do
        expect(result.to_s).to eq('Success, notification_id: 1234, recipients: 1')
      end

      context 'when response has errors' do
        let(:response) { { errors: ['one error'] } }

        it 'returns a string with the erros' do
          expect(result.to_s).to eq('Errors: one error')
        end
      end
    end
  end
end
