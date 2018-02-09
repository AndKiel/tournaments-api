module JsonHelpers
  # Abstract

  def self.define_responses(type, attrs)
    plural_type = type.pluralize
    define_method("#{type}_json") { { "#{type}": attrs } }
    define_method("#{plural_type}_json") { { "#{plural_type}": [attrs].ignore_extra_values! }.ignore_extra_keys! }
  end

  # Errors

  def error_json
    { error: String, error_description: String }
  end

  def validation_error_json
    { error: String, fields: Hash }
  end

  # OAuth

  def access_token_json
    {
      access_token: String,
      created_at: Integer,
      expires_in: Integer,
      refresh_token: String,
      token_type: String
    }
  end

  def access_token_info_json
    {
      application: {
        uid: nil
      },
      created_at: Integer,
      expires_in_seconds: Integer,
      resource_owner_id: String,
      scopes: Array
    }
  end

  # Resources

  define_responses(
    'competitor',
    created_at: ::JsonExpressions::DATE_MATCHER,
    id: String,
    name: String,
    status: String,
    user_id: ::JsonExpressions.maybe(String)
  )

  define_responses(
    'player',
    competitor_id: String,
    id: String,
    result_values: Array,
    table_number: Integer
  )

  define_responses(
    'result',
    competitor_id: String,
    total: Array
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
    organiser_id: String,
    result_names: Array,
    starts_at: String,
    status: String
  )

  define_responses(
    'user',
    email: String,
    id: String
  )

  # Meta

  def pagination_meta_json
    {
      meta: {
        total_count: Integer
      }
    }.ignore_extra_keys!
  end
end
