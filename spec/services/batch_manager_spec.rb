# frozen_string_literal: true

require 'rspec'

RSpec.describe BatchManager do
  let(:batch_manager) { described_class.new(size_limit: batch_size_limit) }
  let(:batch_size_limit) { 5 * 1_048_576 }
  let(:product) { double('Product', to_json: product_json) }
  let(:product_json) { '{"id":1,"name":"Product 1","price":100}' }

  describe '#add_product' do
    context 'when the product fits' do
      it 'returns :added' do
        expect(batch_manager.add_product(product)).to eq(:added)
      end

      it 'adds a product to the current batch' do
        batch_manager.add_product(product)
        expect(batch_manager.current_batch.products).to include(product)
      end
    end

    context "when the product doesn't fit" do
      let(:batch_size_limit) { 36 }

      it 'returns :full' do
        expect(batch_manager.add_product(product)).to eq(:full)
      end
    end
  end

  describe '#flush_batch' do
    before do
      batch_manager.add_product(product)
    end

    it 'returns the current batch and clears it' do
      expect(batch_manager.flush_batch).to eq([product])
      expect(batch_manager.current_batch.products).to be_empty
    end
  end

  describe '#create_new_batch' do
    before do
      batch_manager.add_product(product)
      batch_manager.create_new_batch
    end

    it 'creates a new batch' do
      expect(batch_manager.current_batch.products).to be_empty
    end
  end
end
