Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :users, only: [:index, :show, :new, :create, :destroy]
  get 'signup', to: 'users#new'
  post 'signup', to: 'users#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
