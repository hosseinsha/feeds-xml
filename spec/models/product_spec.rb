# frozen_string_literal: true

require 'rspec'

RSpec.describe Product do
  let(:id) { 1 }
  let(:title) { 'Product 1' }
  let(:description) { 'Description 1' }
  let(:product) { described_class.new(id: id, title: title, description: description) }

  describe '#initialize' do
    context 'when id is nil' do
      let(:id) { nil }

      it 'raises an error' do
        expect { product }.to raise_error(ArgumentError, 'id cannot be nil or empty')
      end
    end

    context 'when title is nil' do
      let(:title) { nil }

      it 'raises an error' do
        expect { product }.to raise_error(ArgumentError, 'title cannot be nil or empty')
      end
    end

    context 'when description is nil' do
      let(:description) { nil }

      it 'raises an error' do
        expect { product }.to raise_error(ArgumentError, 'description cannot be nil or empty')
      end
    end
  end

  describe '#to_json' do
    it 'returns the product as a JSON string' do
      expect(product.to_json).to eq({ id: id, title: title, description: description }.to_json)
    end
  end
end
