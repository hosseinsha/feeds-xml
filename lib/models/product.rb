# frozen_string_literal: true

require 'json'

class Product
  attr_reader :id, :title, :description

  def initialize(id:, title:, description:)
    validate_presence(id, 'id')
    validate_presence(title, 'title')
    validate_presence(description, 'description')

    @id = id
    @title = title
    @description = description
  end

  def to_json(*_args)
    { id: id, title: title, description: description }.to_json
  end

  private

  def validate_presence(attribute, name)
    raise ArgumentError, "#{name} cannot be nil or empty" if attribute.nil? || attribute.to_s.strip.empty?
  end
end
