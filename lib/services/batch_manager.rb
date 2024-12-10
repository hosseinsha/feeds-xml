# frozen_string_literal: true

class BatchManager
  attr_reader :current_batch

  def initialize(size_limit:)
    @size_limit = size_limit
    @current_batch = Batch.new(size_limit: size_limit)
  end

  def add_product(product)
    if @current_batch.add_product(product)
      :added
    else
      :full
    end
  end

  def products
    @current_batch.products
  end

  def flush_batch
    return nil if products.empty?

    flushed_batch = products.dup
    @current_batch.clear
    flushed_batch
  end

  def create_new_batch
    @current_batch = Batch.new(size_limit: @size_limit)
  end
end
