# frozen_string_literal: true

require 'rspec'

RSpec.describe XMLParser do
  let(:xml_parser) { described_class.new(file_path: file_path) }
  let(:file_path) { 'spec/fixtures/products.xml' }

  describe '#extract_products' do
    context 'when the file is empty' do
      let(:file_path) { 'spec/fixtures/empty.xml' }

      it 'returns an empty array' do
        expect(xml_parser.extract_products).to be_empty
      end
    end

    context 'when the file is not empty' do
      it 'extracts products from an XML file' do
        expect(xml_parser.extract_products.size).to eq(2)
      end
    end

    context 'when the file is invalid' do
      let(:file_path) { 'spec/fixtures/invalid.xml' }

      it 'raises an error' do
        expect { xml_parser.extract_products }.to raise_error(InvalidFileError)
      end
    end
  end
end
