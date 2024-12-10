# frozen_string_literal: true

require 'rspec'

RSpec.describe BatchProcessor do
  let(:batch_size_limit) { 5 * 1_048_576 }
  let(:batch_processor) { described_class.new(batch_size_limit: batch_size_limit) }
  let(:product) { double('Product', to_json: product_json) }
  let(:product_json) { '{"id":1,"name":"Product 1","price":100}' }

  describe '#add_product' do
    context 'when it fits' do
      before do
        batch_processor.add_product(product)
      end
      it 'adds a product to the current batch' do
        expect(batch_processor.current_batch_products).to include(product)
      end
    end

    context "when it doesn't fit" do
      let(:batch_size_limit) { 40 }

      before do
        batch_processor.add_product(product)
        batch_processor.add_product(product)
      end
      it 'creates a new batch' do
        expect(batch_processor.batches.size).to eq(1)
        expect(batch_processor.current_batch_products).to include(product)
      end
    end
  end

  describe '#flush' do
    before do
      batch_processor.add_product(product)
      batch_processor.flush
    end

    it 'saves the remaining batch if not empty' do
      expect(batch_processor.batches.size).to eq(1)
      expect(batch_processor.batches.first).to eq([product])
    end
  end
end
