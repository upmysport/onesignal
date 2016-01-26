require 'spec_helper'
require 'onesignal/device_creation_result'

module Onesignal
  RSpec.describe DeviceCreationResult do
    subject(:result) { described_class.from_device_creation(response) }

    describe '#to_s' do
      let(:response) { { id: '1234' } }

      it 'returns a string with the result values' do
        expect(result.to_s).to eq('Success, device_id: 1234')
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
