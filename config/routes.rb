Rails.application.routes.draw do
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
  
  resources :users, only: [:show]
  resources :blogs



  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
