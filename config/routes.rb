Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  resources :pets, only: %i[index show new create]
end
