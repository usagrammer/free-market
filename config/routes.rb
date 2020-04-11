Rails.application.routes.draw do
  root to: "items#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks:  "users/omniauth_callbacks"
  }

  devise_scope :user do
    get 'users/select' => 'users/registrations#select'
    get 'users/confirm_phone' => 'users/registrations#confirm_phone'
    get 'users/new_address' => 'users/registrations#new_address'
    get 'users/completed' => 'users/registrations#completed'
  end

  resources :users, only: [:show]

  resources :items, only: [:index, :new, :create, :show, :edit]  do
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
