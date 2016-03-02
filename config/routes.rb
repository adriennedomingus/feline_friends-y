Rails.application.routes.draw do
  root to: "landing#show"

  resources :cats, only: [:index, :show]

  resources :categories, only: [:show], param: :name

  resources :carts, only: [:create]
  resources :users, only: [:new, :create]
  resources :orders, only: [:index, :show]

  get "/cart", to: "carts#show"
  delete "/cart", to: "carts#destroy"
  get "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/dashboard", to: "dashboard#show"
end
