# frozen_string_literal: true

class ItemNode
  attr_reader :id, :title, :description

  def initialize(node:, namespace:)
    @id = extract_field(node, 'g:id', namespace)
    @title = extract_field(node, 'title', namespace)
    @description = extract_field(node, 'description', namespace)

    validate!
  end

  private

  def extract_field(node, xpath, namespace)
    node.at_xpath(xpath, namespace)&.text
  end

  def validate!
    validate_presence(:id, id)
    validate_presence(:title, title)
    validate_presence(:description, description)
  end

  def validate_presence(field_name, value)
    return unless value.nil? || value.strip.empty?

    raise ArgumentError, "#{field_name} is required and cannot be blank"
  end
end
