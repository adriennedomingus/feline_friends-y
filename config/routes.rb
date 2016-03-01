Rails.application.routes.draw do
  root to: "landing#show"

  resources :cats, only: [:index]

  resources :categories, only: [:show], param: :name

  resources :carts, only: [:create]
  get "/cart", to: "carts#show"
end
