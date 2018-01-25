module Meta
  extend ActiveSupport::Concern

  included do
    def pagination_meta(collection)
      {
        total_count: collection.total_count
      }
    end
  end
end
