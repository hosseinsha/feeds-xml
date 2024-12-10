# frozen_string_literal: true

class Batch
  attr_reader :products

  def initialize(size_limit:)
    @size_limit = size_limit
    @products = []
    @current_size = 0
  end

  def add_product(product)
    raise ArgumentError, 'Product must respond to :to_json' unless product.respond_to?(:to_json)

    product_size = product.to_json.bytesize

    # Check if adding the product exceeds the size limit
    return false if @current_size + product_size > @size_limit

    # Add the product to the batch
    @products << product
    @current_size += product_size
    true
  end

  def clear
    @products = []
    @current_size = 0
  end
end
