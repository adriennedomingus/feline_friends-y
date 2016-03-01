Rails.application.routes.draw do
  root to: "landing#show"

  resources :cats, only: [:index, :show]

  resources :categories, only: [:show], param: :name

  resources :carts, only: [:create]
  get "/cart", to: "carts#show"
  delete "/cart", to: "carts#destroy"
end
