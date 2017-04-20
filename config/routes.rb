Rails.application.routes.draw do

	devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  get "lobby", to:"static_pages#lobby"

  # games
  resources :games

  # user profile
  resources :users, only: :show

  resources :pieces, only: [:update, :create]
end
