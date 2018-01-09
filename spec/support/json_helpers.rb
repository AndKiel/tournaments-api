module JsonHelpers
  # Abstract

  def self.define_responses(type, attrs)
    plural_type = type.pluralize
    define_method("#{type}_json") { { "#{type}": attrs } }
    define_method("#{plural_type}_json") { { "#{plural_type}": [attrs].ignore_extra_values! } }
  end

  # Errors

  def error_json
    { error: String, error_description: String }
  end

  def validation_error_json
    { error: String, fields: Hash }
  end

  # Resources

  define_responses(
    'competitor',
    id: String,
    status: String
  )

  define_responses(
    'player',
    id: String,
    result_values: Array,
    table_number: Integer
  )

  define_responses(
    'round',
    competitors_limit: Integer,
    created_at: ::JsonExpressions::DATE_MATCHER,
    id: String,
    tables_count: Integer
  )

  define_responses(
    'tournament',
    competitors_limit: Integer,
    description: String,
    id: String,
    name: String,
    result_names: Array,
    starts_at: String,
    status: String
  )

  define_responses(
    'user',
    email: String,
    id: String,
    name: String
  )
end
