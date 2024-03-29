require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  namespace :api, defaults: { format: 'json' }, path: '/', constraints: { subdomain: 'api' } do
    namespace :v1 do
      # USER ROUTES
      # =========================
      namespace :user do
        # /api/v1/user
        get    '/',                 to: 'user#me'
        # /api/v1/user/:username
        get    '/:username',        to: 'user#show'
        # /api/v1/user/username
        put    '/username',         to: 'user#update_username'
        # /api/v1/user/reset
        post   '/reset',            to: 'user#reset_user'
        # /api/v1/user/:username/transactions
        get    '/:username/transactions',        to: 'user#transactions'
        # /api/v1/user/login
        post   'login',             to: 'sessions#login',             as: 'login'
        # /api/v1/user/third-party-login
        post   'third-party-login', to: 'sessions#third_party_login', as: 'third_party_login'
        # /api/v1/user/logout
        delete 'logout',            to: 'sessions#logout',            as: 'logout'
        # /api/v1/user/signup
        post   'signup',            to: 'registrations#signup',       as: 'signup'
        # /api/v1/user/deactivate
        put '/deactivate',          to: 'user#deactivate'
        # /api/v1/user/reactivate
        put '/reactivate',          to: 'user#reactivate'
        # /api/v1/user
        delete '/',                 to: 'user#delete'
      end

      namespace :leaderboard do
        # /api/v1/leaderboard
        get    '/',       to: 'leaderboard#index'
      end

      # MEME ROUTES
      # =========================
      namespace :meme do

        # /api/v1/meme/:id
        get   '/:id',                    to: 'memes#show'
        # /api/v1/meme/:id/buy
        post  '/:id/buy',                to: 'memes#buy'
        # /api/v1/meme/:id/sell
        post  '/:id/sell',               to: 'memes#sell'
        # /api/v1/meme/:id/sell
        get  '/:id/sell',               to: 'memes#sell_info'

      end
    end
  end
end
