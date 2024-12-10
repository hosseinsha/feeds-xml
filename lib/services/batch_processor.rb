# frozen_string_literal: true

class BatchProcessor
  attr_reader :batches

  DEFAULT_BATCH_SIZE = 5 * 1_048_576

  def initialize(batch_size_limit: DEFAULT_BATCH_SIZE)
    @batch_manager = BatchManager.new(size_limit: batch_size_limit)
    @batches = []
  end

  def add_product(product)
    return unless batch_manager.add_product(product) == :full

    save_current_batch
    batch_manager.create_new_batch
    batch_manager.add_product(product)
  end

  def flush
    save_current_batch if batch_manager.current_batch.products.any?
  end

  def current_batch_products
    batch_manager.products
  end

  private

  attr_reader :batch_manager

  def save_current_batch
    flushed_batch = batch_manager.flush_batch
    @batches << flushed_batch if flushed_batch
  end
end
