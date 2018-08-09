Rails.application.routes.draw do

  resources :podcasts, only: [:index]

  match '/users/mobile_auth/google_oauth2/callback',
    to: 'google_oauth2#mobile_google_oauth2',
    via: [:get, :post]

  post '/users/mobile_auth/facebook_oauth2/callback',
    to: 'facebook_oauth2#mobile_facebook_oauth2'

  if Rails.env.development?
    require 'sidekiq/web'
    mount Sidekiq::Web, at: '/sidekiq'
    require 'sidetiq/web'

    mount LetterOpenerWeb::Engine, at: '/letter_opener'
    get 'preview/invitation_instructions'
  end

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, controllers: {
    registrations: 'registrations',
    confirmations: 'confirmations',
    invitations: 'invitations',
    passwords: 'passwords',
    omniauth_callbacks: 'omniauth_callbacks'
  }

  mount StripeEvent::Engine, at: '/webhooks/stripe'

  use_doorkeeper

  mount GymcloudAPI::API, at: '/'
  mount GrapeSwaggerRails::Engine, at: '/swagger'

  root to: 'devise/registrations#new'

end
