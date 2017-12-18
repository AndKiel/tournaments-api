require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'handling ActiveRecord::RecordNotFound' do
    define_anonymous_action do
      raise ActiveRecord::RecordNotFound
    end

    it 'returns nothing' do
      process :anon,
              method: :get
      expect(response).to have_http_status(:not_found)
      expect(response.body).to be_empty
    end
  end

  describe 'handling Pundit::NotAuthorizedError' do
    define_anonymous_action do
      raise Pundit::NotAuthorizedError
    end

    it 'returns error' do
      process :anon,
              method: :get
      expect(response).to have_http_status(:forbidden)
      expect(response.body).to match_json_expression(error_json)
    end
  end
end
