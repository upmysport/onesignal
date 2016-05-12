require 'spec_helper'

RSpec.describe Configuration do
  subject(:configuration) { described_class.new }

  specify 'Logger is the default logger' do
    expect(configuration.log).to be_a(Logger)
  end

  describe '#app_id=' do
    let(:app_id) { 1 }

    it 'sets the Onesignal app_id' do
      configuration.app_id = app_id
      expect(configuration.app_id).to eq(app_id)
    end
  end
end
