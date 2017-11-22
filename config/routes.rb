# == Route Map
#
#           Prefix Verb URI Pattern                 Controller#Action
#             root GET  /                           application#ping
#      oauth_token POST /oauth/token(.:format)      doorkeeper/tokens#create
#     oauth_revoke POST /oauth/revoke(.:format)     doorkeeper/tokens#revoke
# oauth_token_info GET  /oauth/token/info(.:format) doorkeeper/token_info#show
#    sign_up_users POST /users/sign_up(.:format)    users#sign_up
#

Rails.application.routes.draw do
  root 'application#ping'

  use_doorkeeper do
    skip_controllers :applications, :authorizations, :authorized_applications
  end

  resources :users, only: :none do
    collection do
      post :sign_up
    end
  end
end
