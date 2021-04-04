Rails.application.routes.draw do
  namespace :api do
    get 'user_typings/create'
    get 'user_typings/update'
    get 'user_typings/show'
  end
  namespace :api do
    get 'words/index'
  end
  namespace :api ,{ format: 'json' } do
    resources :likes, only: [:index, :create, :destroy]
    resources :words, only:[:index]
    resources :user_typings, only:[:create, :update, :show]
  end

  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :omniauth_callbacks => 'users/omniauth_callbacks',
    :confirmations => 'users/confirmations',
  }
  
  # devise :omniauthable: :omniauth_providers => [:google_oauth2]
  
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end

  root 'static_pages#home'
  get '/help' ,to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get 'users/show'
  # get ':username', to: 'users#show', as: :users
  
  
  resources :users do
    member do
      get :show, :following, :followers
    end
  end 

  resources :relationships, only: [:create, :destroy]

  resources :blogs do
    resources :likes, only: [:create, :destroy]  
  end



  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
