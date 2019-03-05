Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  post '/', to: 'pages#home'
  resources :products, only: [:show] do
    collection do
      post :search
      get :search_results
    end
    resources :alerts, only: [:create]
  end

  resources :alerts, only: [:update, :edit, :destroy, :index, :show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
