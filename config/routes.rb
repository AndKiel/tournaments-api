# == Route Map
#
#        Prefix Verb URI Pattern              Controller#Action
#          root GET  /                        application#ping
# sign_up_users POST /users/sign_up(.:format) users#sign_up
# 

Rails.application.routes.draw do
  # use_doorkeeper
  root 'application#ping'

  resources :users, only: :none do
    collection do
      post :sign_up
    end
  end
end
