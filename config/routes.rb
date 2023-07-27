Rails.application.routes.draw do
  # Deviseのルート設定
  devise_for :users, controllers: {
    # コントローラーやオプションがある場合、ここに追記
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'application#guest_sign_in'
  end

  # Root URL設定
  root to: 'pages#home'

  # それぞれのリソースに関する標準のCRUDルート
  resources :meals do
    collection do
      get 'calorie_search'
    end
  end
  resources :exercises
  resources :badges, only: [:index, :show]
  resources :goals
  resources :posts
  resources :user_badges, only: [:create, :destroy]

  # ダッシュボード
  resource :dashboard, only: [:show]
  resource :profile, only: [:show, :edit, :update]
  get 'profile/:id', to: 'profiles#show', as: 'profile_show'

  get 'privacy', to: 'pages#privacy', as: 'privacy'
  get 'service', to: 'pages#service', as: 'service'

  resources :exercises do
    collection do
      get 'calculate_calories'
    end
  end

end

