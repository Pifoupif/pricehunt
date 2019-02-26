Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :products, only: [:show] do
    resources :alert, only: [:new, :create]
  end

  resources :alerts, only: [:update, :edit, :destroy, :index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
