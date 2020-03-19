Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show, :create, :update, :destroy]

      resources :merchants, only: [:index, :show, :create, :update, :destroy] do
        scope module: :merchant do
          resources :items, only: [:index]
        end
      end

      # scopes merchants for retrieval based on the items
      resources :items, only: [:index, :show, :create, :update, :destroy] do
        scope module: :item do
          resource :merchant, only: [:show]
        end
      end
    end
  end
end
