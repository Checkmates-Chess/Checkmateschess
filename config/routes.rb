Rails.application.routes.draw do

	devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  get "lobby", to:"static_pages#lobby"
  get "board", to:"static_pages#board"

  # games
  resources :games

  # user profile
  resources :users, only: :show
end
