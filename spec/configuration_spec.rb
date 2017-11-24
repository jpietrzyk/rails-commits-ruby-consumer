require 'spec_helper'

RSpec.describe 'GQLConsumer#configuration' do
  context 'Not initialized' do
    it 'should have default values' do
      expect(GQLConsumer.configuration.api_url).to eq('https://api.github.com/graphql')
    end
  end

  context 'Change configuration' do
    it 'Accepts block' do
      GQLConsumer.configure do |config|
        config.api_url = 'https://api.spotify.com'
      end
      expect(GQLConsumer.configuration.api_url).to eq('https://api.spotify.com')
    end
  end
end
