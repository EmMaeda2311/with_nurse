Rails.application.routes.draw do
  get 'users/show'
  devise_for :users, :controller => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions' 
  }
  
  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy"
  end
  
  root 'static_pages#home'
  get '/help' ,to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  
  resources :users, only: [:show]
  # get 'static_pages/home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
