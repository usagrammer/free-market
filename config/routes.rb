Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"

  resources :users, only: [:show]

  resources :items, only: [:index, :new, :show, :edit]  do
    member do
      get "purchase_confirmation"
    end
    collection do
      get 'search'
    end
  end
  resources :categories, only: [:index, :show]
  resources :cards, only: [:new, :show]

end
