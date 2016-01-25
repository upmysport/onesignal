require 'spec_helper'
require 'onesignal/result'

module Onesignal
  RSpec.describe Result do
    subject(:result) { Result.new(response) }

    describe '#to_s' do
      let(:response) { { errors: [] } }

      it "returns a 'sucess' string" do
        expect(result.to_s).to eq('Success')
      end
    end

    context 'when response has errors' do
      let(:response) { { errors: ["this doesn't work", 'neither this'] } }

      it 'shows the errors' do
        expect(result.to_s).to eq("Errors: this doesn't work, neither this")
      end
    end
  end
end
