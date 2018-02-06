# based on JsonExpressions::WILDCARD_MATCHER
module JsonExpressions
  DATE_MATCHER = Object.new.tap do |matcher|
    def matcher.===(other)
      Date.parse(other) && true
    rescue ArgumentError, TypeError
      false
    end

    def to_s
      'DATE_MATCHER'
    end
  end

  def self.maybe(obj)
    matcher = Object.new
    matcher.define_singleton_method(:'===') { |other| other.is_a?(obj) || other.nil? }
    matcher
  end
end
