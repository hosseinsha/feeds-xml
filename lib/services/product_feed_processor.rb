# frozen_string_literal: true

class ProductFeedProcessor
  def initialize(parser:, sender:, batch_processor:)
    @parser = parser
    @batch_processor = batch_processor
    @sender = sender
  end

  def process
    process_products
    flush_and_send_batches
    log_processed_batches
  end

  private

  attr_reader :parser, :sender, :batch_processor

  def process_products
    products.each { |product| batch_processor.add_product(product) }
  end

  def products
    parser.extract_products
  end

  def flush_and_send_batches
    batch_processor.flush

    batch_processor.batches.each { |batch| sender.send_batch(batch) }
  end

  def log_processed_batches
    puts "Processed and sent #{batch_processor.batches.size} batches"
  end
end
