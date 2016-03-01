Rails.application.routes.draw do
  resources :cats, only: [:index]

  resources :categories, only: [:show], param: :name
end
