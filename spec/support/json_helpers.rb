module JsonHelpers
  # Abstract

  def resource_schema(type, attrs = {})
    {
      id: String,
      type: type,
      attributes: attrs
    }.ignore_extra_keys!
  end

  def resource_json(schema)
    {
      data: schema
    }.ignore_extra_keys!
  end

  def collection_json(schema)
    {
      data: [schema].ignore_extra_values!
    }.ignore_extra_keys!
  end

  def self.define_responses(type, attrs)
    define_method("#{type}_schema") { resource_schema(type.pluralize, attrs) }
    define_method("#{type}_json") { resource_json(public_send("#{type}_schema")) }
    define_method("#{type}_collection_json") { collection_json(public_send("#{type}_schema")) }
  end

  # Errors

  def errors_json
    {
      errors: [{
        title: String,
        detail: String
      }]
    }
  end

  def validation_errors_json
    {
      errors: [{
        source: { pointer: String },
        detail: String
      }].ignore_extra_values!
    }
  end

  # JSONAPI resources

  define_responses(
    'tournament',
    competitors_limit: Integer,
    description: String,
    name: String,
    result_names: Array,
    # starts_at: String,
    status: String
  )

  define_responses(
    'user',
    email: String,
    name: String
  )
end
