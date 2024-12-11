# frozen_string_literal: true

require 'rspec'

RSpec.describe Mapping do
  describe '.ATTRIBUTES' do
    it 'returns a hash of attributes' do
      expect(described_class::ATTRIBUTES).to eq(
        id: 'g:id',
        title: 'title',
        description: 'description'
      )
    end
  end
end
