class Mapping
  ATTRIBUTES = {
    id: 'g:id',
    title: 'title',
    description: 'description'
  }.freeze

  ATTRIBUTES.each do |method_name, value|
    define_method(method_name) { value }
  end
end
