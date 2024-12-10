# frozen_string_literal: true

require 'rspec'

RSpec.describe ProductBuilder do
  let(:product_builder) { described_class.new }
  let(:item_node) { double('ItemNode', id: 1, title: 'Product 1', description: 'Description 1') }

  describe '#build' do
    context 'when the product is valid' do
      it 'builds the product' do
        expect { product_builder.build(item_node) }.not_to raise_error
      end
    end

    context 'when the product is invalid' do
      let(:item_node) { double('ItemNode', id: nil, title: 'Product 1', description: 'Description 1') }

      it 'logs an error' do
        expect { product_builder.build(item_node) }.to output(/Error building product/).to_stdout
      end
    end
  end
end
