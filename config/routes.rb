Rails.application.routes.draw do
  get 'contacts/new'
  post 'contacts/create'
  # namespace :api do
  #   get 'user_typings/create'
  #   get 'user_typings/update'
  #   get 'user_typings/show'
  # end
  
  # namespace :api do
  #   get 'words/index'
  # end

  namespace :api, { format: 'json' } do
    # resources :likes, only: %i[index create destroy]
    resources :words, only: [:index]
    # resources :user_typings, only: %i[create update show]
  end

  # devise_for :users, controllers: {
  #   registrations: 'users/registrations',
  #   sessions: 'users/sessions',
  #   omniauth_callbacks: 'users/omniauth_callbacks',
  #   confirmations: 'users/confirmations'
  # }

  # devise :omniauthable: :omniauth_providers => [:google_oauth2]

  # devise_scope :user do
  #   get 'sign_in', to: 'users/sessions#new'
  #   get 'sign_out', to: 'users/sessions#destroy'
  # end

  # root 'static_pages#home'
  root 'static_pages#guest_game'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/game', to: 'static_pages#game'
  get '/guest_game', to: 'static_pages#guest_game'
  get '/privacy', to: 'static_pages#privacy'
  get '/terms', to: 'static_pages#terms'

  # resources :users, only: %i[show index destroy] do
  #   member do
  #     get :following, :followers, :game
  #   end
  
  # end

  # resources :relationships, only: %i[create destroy]

  # resources :blogs do
  #   resources :likes, only: %i[create destroy]
  # end

end
