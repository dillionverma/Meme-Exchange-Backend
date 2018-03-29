Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      # USER ROUTES
      # =========================
      namespace :user do
        # /api/v1/user
        get '/',                    to: 'user#show'
        # /api/v1/user/login
        post   'login',             to: 'sessions#login',             as: 'login'
        # /api/v1/user/third-party-login
        post   'third-party-login', to: 'sessions#third_party_login', as: 'third_party_login'
        # /api/v1/user/logout
        delete 'logout',            to: 'sessions#logout',            as: 'logout'
        # /api/v1/user/sign_up
        post   'signup',            to: 'registrations#sign_up',      as: 'sign_up'
      end
    end
  end
end
