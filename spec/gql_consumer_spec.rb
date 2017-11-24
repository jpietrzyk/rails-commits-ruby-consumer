require 'spec_helper'

RSpec.describe GQLConsumer do
  it 'should have version' do
    expect(GQLConsumer::VERSION).to_not be_nil
  end
end
