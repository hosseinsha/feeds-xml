# frozen_string_literal: true

require 'rspec'

RSpec.describe Batch do
  let(:batch_size_limit) { 5 * 1_048_576 }
  let(:batch) { described_class.new(size_limit: batch_size_limit) }
  let(:product) { double('Product', to_json: product_json) }
  let(:product_json) { '{"id":1,"name":"Product 1","price":100}' }

  describe '#add_product' do
    context 'when the product fits' do
      before do
        batch.add_product(product)
      end

      it 'adds a product to the current batch' do
        expect(batch.products).to include(product)
      end
    end

    context "when the product doesn't fit" do
      let(:batch_size_limit) { 40 }

      before do
        batch.add_product(product)
        batch.add_product(product)
      end

      it 'creates a new batch' do
        expect(batch.products.size).to eq(1)
        expect(batch.products).to include(product)
      end
    end
  end

  describe '#clear' do
    before do
      batch.add_product(product)
      batch.clear
    end

    it 'clears the current batch' do
      expect(batch.products).to be_empty
    end
  end
end
