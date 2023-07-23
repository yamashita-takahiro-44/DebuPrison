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
  resources :meals
  resources :exercises
  resources :badges, only: [:index, :show]
  resources :goals
  resources :posts
  resources :user_badges, only: [:create, :destroy]

  # ダッシュボード
  resource :dashboard, only: [:show]
  resource :profile, only: [:show, :edit, :update]

  get 'privacy', to: 'pages#privacy', as: 'privacy'
  get 'service', to: 'pages#service', as: 'service'
end

