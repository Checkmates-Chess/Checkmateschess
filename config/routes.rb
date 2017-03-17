Rails.application.routes.draw do
  get 'games/new'

  get 'games/create'

  get 'games/show'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
end
