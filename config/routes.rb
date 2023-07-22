Rails.application.routes.draw do
  # Deviseのルート設定
  devise_for :users

  # Root URL設定
  root to: 'dashboard#show'

  # それぞれのリソースに関する標準のCRUDルート
  resources :meals
  resources :exercises
  resources :badges, only: [:index, :show]
  resources :goals
  resources :posts
  resources :user_badges, only: [:create, :destroy]

  # ダッシュボード
  resource :dashboard, only: [:show]
end

