# frozen_string_literal: true

ValidatesTimeliness.setup do |config|
  config.extend_orms = [:active_record]

  # Shorthand date and time symbols for restrictions
  # config.restriction_shorthand_symbols.update(
  #   :now   => lambda { Time.current },
  #   :today => lambda { Date.current }
  # )
end
