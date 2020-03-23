Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"

  # devise_for :users

  resources :users, only: [:show] do
    collection do
      get "card"
      get "selling"
      get "selling_progress"
      get "sold"
      get "bought_progress"
      get "bought_past"
    end
  end

  resources :items, only: [:index, :new, :show, :edit]  do
    member do
      get "purchase_confirmation"
    end
    collection do
      get 'search'
    end
  end
  resources :categories, only: [:index, :show]
  resources :cards, only: [:new, :create, :show, :update, :destroy]

end
