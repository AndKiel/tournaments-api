module RequestMacros
  # Doorkeeper

  def authenticate(user_sym)
    let(:current_user) { users(user_sym) }
    let!(:access_token) do
      Doorkeeper::AccessToken.create!(
        expires_in: 100,
        resource_owner_id: current_user.id,
        scopes: 'public'
      )
    end
    let!(:auth_headers) { { 'Authorization': "Bearer #{access_token.token}" } }
  end
end
