# frozen_string_literal: true

module RequestMacros
  # Doorkeeper

  def authenticate
    let(:current_user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: current_user.id) }
    let(:auth_headers) { { 'Authorization': "Bearer #{access_token.token}" } }
  end
end
