require 'rails_helper'

RSpec.describe 'OAuth', type: :request do
  describe 'POST /oauth/token' do
    let(:user) { users(:andrew) }

    it 'creates AccessToken' do
      expect do
        post oauth_token_path,
             params: {
               email: user.email,
               password: 'password',
               grant_type: 'password'
             }
      end.to change(Doorkeeper::AccessToken, :count).by(1)
      expect(response).to have_http_status(:ok)
      expect(response.body).to match_json_expression(access_token_json)
    end

    it 'returns error' do
      post oauth_token_path,
           params: {
             email: user.email,
             password: 'password',
             grant_type: 'invalid_grant'
           }
      expect(response).to have_http_status(:unauthorized)
      expect(response.body).to match_json_expression(error_json)
    end
  end

  describe 'GET /oauth/token/info' do
    it 'returns AccessToken details'
  end

  describe 'POST /oauth/revoke' do
    it 'revokes AccessToken'
  end
end
