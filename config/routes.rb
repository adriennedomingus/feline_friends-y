Rails.application.routes.draw do
  resources :cats, only: [:index]

  resources :categories, only: [:show], param: :name
  resources :carts, only: [:create]
  get "/cart", to: "carts#show"
end
