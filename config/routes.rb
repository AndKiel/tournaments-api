# == Route Map
#
#               Prefix Verb   URI Pattern                                  Controller#Action
#                 root GET    /(:locale)(.:format)                         tournaments#index {:locale=>/en/}
#          oauth_token POST   (/:locale)/oauth/token(.:format)             doorkeeper/tokens#create {:locale=>/en/}
#         oauth_revoke POST   (/:locale)/oauth/revoke(.:format)            doorkeeper/tokens#revoke {:locale=>/en/}
#     oauth_token_info GET    (/:locale)/oauth/token/info(.:format)        doorkeeper/token_info#show {:locale=>/en/}
#        sign_up_users POST   (/:locale)/users/sign_up(.:format)           users#sign_up {:locale=>/en/}
#                 user GET    (/:locale)/user(.:format)                    users#show {:locale=>/en/}
#                      PATCH  (/:locale)/user(.:format)                    users#update {:locale=>/en/}
#                      PUT    (/:locale)/user(.:format)                    users#update {:locale=>/en/}
# enlisted_tournaments GET    (/:locale)/tournaments/enlisted(.:format)    tournaments#enlisted {:locale=>/en/}
#     start_tournament POST   (/:locale)/tournaments/:id/start(.:format)   tournaments#start {:locale=>/en/}
#       end_tournament POST   (/:locale)/tournaments/:id/end(.:format)     tournaments#end {:locale=>/en/}
#          tournaments GET    (/:locale)/tournaments(.:format)             tournaments#index {:locale=>/en/}
#                      POST   (/:locale)/tournaments(.:format)             tournaments#create {:locale=>/en/}
#           tournament GET    (/:locale)/tournaments/:id(.:format)         tournaments#show {:locale=>/en/}
#                      PATCH  (/:locale)/tournaments/:id(.:format)         tournaments#update {:locale=>/en/}
#                      PUT    (/:locale)/tournaments/:id(.:format)         tournaments#update {:locale=>/en/}
#                      DELETE (/:locale)/tournaments/:id(.:format)         tournaments#destroy {:locale=>/en/}
#              results GET    (/:locale)/results(.:format)                 results#index {:locale=>/en/}
#       add_competitor POST   (/:locale)/competitor/add(.:format)          competitors#add {:locale=>/en/}
#           competitor DELETE (/:locale)/competitor(.:format)              competitors#destroy {:locale=>/en/}
#                      POST   (/:locale)/competitor(.:format)              competitors#create {:locale=>/en/}
#    remove_competitor DELETE (/:locale)/competitors/:id/remove(.:format)  competitors#remove {:locale=>/en/}
#   confirm_competitor POST   (/:locale)/competitors/:id/confirm(.:format) competitors#confirm {:locale=>/en/}
#    reject_competitor POST   (/:locale)/competitors/:id/reject(.:format)  competitors#reject {:locale=>/en/}
#               rounds POST   (/:locale)/rounds(.:format)                  rounds#create {:locale=>/en/}
#                round PATCH  (/:locale)/rounds/:id(.:format)              rounds#update {:locale=>/en/}
#                      PUT    (/:locale)/rounds/:id(.:format)              rounds#update {:locale=>/en/}
#                      DELETE (/:locale)/rounds/:id(.:format)              rounds#destroy {:locale=>/en/}
#              players POST   (/:locale)/players(.:format)                 players#create {:locale=>/en/}
#               player PATCH  (/:locale)/players/:id(.:format)             players#update {:locale=>/en/}
#                      PUT    (/:locale)/players/:id(.:format)             players#update {:locale=>/en/}
#

Rails.application.routes.draw do
  scope '(:locale)',
        locale: /#{I18n.available_locales.join("|")}/,
        defaults: { locale: I18n.default_locale } do
    root 'tournaments#index'

    use_doorkeeper do
      skip_controllers :applications, :authorizations, :authorized_applications
    end

    resources :users, only: :none do
      collection do
        post :sign_up
      end
    end
    resource :user, only: %i[show update]

    resources :tournaments, only: %i[index show create update destroy] do
      collection do
        get :enlisted
      end
      member do
        post :start
        post :end
      end
    end

    resources :results, only: %i[index]

    resource :competitor, only: %i[create destroy] do
      member do
        post :add
      end
    end
    resources :competitors, only: :none do
      member do
        delete :remove
        post :confirm
        post :reject
      end
    end

    resources :rounds, only: %i[create update destroy]

    resource :players, only: :create
    resources :players, only: :update
  end
end
