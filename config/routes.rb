Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show, :create, :update, :destroy]
      resources :merchants, only: [:index, :show, :create, :update, :destroy]
      resources :items, only: [:index, :show, :create, :update]
    end
  end
end
