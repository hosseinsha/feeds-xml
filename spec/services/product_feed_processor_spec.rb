# frozen_string_literal: true

require 'rspec'

RSpec.describe ProductFeedProcessor do
  let(:parser) { instance_double(XMLParser) }
  let(:sender) { instance_double(BatchSender) }
  let(:batch_processor) { instance_double(BatchProcessor, batches: []) }
  let(:product_feed_processor) { described_class.new(parser: parser, sender: sender, batch_processor: batch_processor) }

  describe '#process' do
    let(:products) { [double('Product1'), double('Product2')] }

    before do
      allow(parser).to receive(:extract_products).and_return(products)
      allow(batch_processor).to receive(:add_product)
      allow(batch_processor).to receive(:flush)
      allow(sender).to receive(:send_batch)
    end

    it 'processes and sends batches of products' do
      product_feed_processor.process

      products.each do |product|
        expect(batch_processor).to have_received(:add_product).with(product)
      end

      expect(batch_processor).to have_received(:flush)
      expect(sender).to have_received(:send_batch).exactly(batch_processor.batches.size).times
    end

    it 'prints the number of processed batches' do
      expect { product_feed_processor.process }.to output(/Processed and sent \d+ batches/).to_stdout
    end
  end
end
