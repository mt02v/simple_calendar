Rails.application.routes.draw do
  get 'users/show'
  root to: "home#index"
  devise_for :users
  resources :users, :only => [:show]
  resources :reservations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
