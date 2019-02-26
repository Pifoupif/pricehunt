Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :product, only: [:show] do
    resources :alert, only: [:new, :create]
  end
  resources :alert, only: [:update, :edit, :destroy, :index, :show]

  resources :product, only: [:show] do
    resources :offers, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
