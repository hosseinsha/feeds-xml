# frozen_string_literal: true

require 'rspec'

RSpec.describe ItemNode do
  let(:namespace) { { 'g' => 'http://base.google.com/ns/1.0' } }
  let(:node) { Nokogiri::XML(File.read('spec/fixtures/products.xml')).at_xpath('//item') }

  describe '#initialize' do
    context 'when the item is valid' do
      it 'initializes the item node' do
        expect { described_class.new(node: node, namespace: namespace) }.not_to raise_error
      end
    end

    context 'when the item is invalid' do
      let(:invalid_node) { Nokogiri::XML(File.read('spec/fixtures/invalid.xml')).at_xpath('//item') }

      it 'raises an error' do
        expect { described_class.new(node: invalid_node, namespace: namespace) }.to raise_error(ArgumentError)
      end
    end
  end
end
