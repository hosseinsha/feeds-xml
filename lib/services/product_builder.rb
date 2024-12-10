# frozen_string_literal: true

class ProductBuilder
  def build(item_node)
    Product.new(
      id: item_node.id,
      title: item_node.title,
      description: item_node.description
    )
  rescue StandardError => e
    log_error(item_node, e)
    nil
  end

  private

  def log_error(item_node, error)
    puts "Error building product: #{error.message}, Item: #{item_node.inspect}"
  end
end
