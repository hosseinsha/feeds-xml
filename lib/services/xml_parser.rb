# frozen_string_literal: true

require 'nokogiri'

class InvalidFileError < StandardError; end

class XMLParser
  def initialize(file_path:, namespace: { 'g' => 'http://base.google.com/ns/1.0' })
    @file_path = file_path
    @namespace = namespace
    @product_builder = ProductBuilder.new
  end

  def extract_products
    doc = parse_xml_file
    products = extract_valid_products(doc)

    puts "Extracted #{products.size} valid products from XML"
    products
  end

  private

  attr_reader :namespace

  def parse_xml_file
    Nokogiri::XML(File.read(@file_path), &:strict)
  rescue StandardError => e
    raise InvalidFileError, e.message
  end

  def extract_valid_products(doc)
    doc.xpath('//item').each_with_object([]) do |node, products|
      item_node = ItemNode.new(node: node, namespace: namespace)
      product = @product_builder.build(item_node)
      products << product if product
    rescue ArgumentError => e
      puts "Skipped invalid item: #{node.to_xml}, Error: #{e.message}"
    end
  end
end
