Rails.application.routes.draw do
  root to: "items#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks:  "users/omniauth_callbacks"
  }

  devise_scope :user do
    get 'users/select' => 'users/registrations#select'
    get 'users/confirm_phone' => 'users/registrations#confirm_phone'    ## ③電話番号認証画面のアクション
    get 'users/new_address' => 'users/registrations#new_address'        ## ④addressのフォームのアクション
    post 'users/create_address' => 'users/registrations#create_address' ## ⑤addressをsaveするアクション
  end

  resources :users, only: [:show]

  resources :items, only: [:index, :new, :create, :show, :edit, :update, :destroy]  do
    resources :item_comments
    member do
      get "purchase_confirmation"
      post "purchase"
    end
    collection do
      get 'search'
    end
  end

  resources :categories, only: [:index, :show]
  resources :cards, only: [:index, :new, :create, :destroy]

  namespace :api do
    resources :categories, only: :index, defaults: { format: 'json' }
  end

end
