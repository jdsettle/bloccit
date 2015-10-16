Rails.application.routes.draw do

  devise_for :users
  resources :users, only: [:update]
  
  resources :questions

  resources :topics do
    resources :posts, except: [:index] do
      resources :comments, only: [:create, :destroy]
    end
  end

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end