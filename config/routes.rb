Rails.application.routes.draw do
  root 'home#index'
  namespace :api, { format: "json" } do
    namespace :v1 do
      resources :todos, :only => [:index, :create, :update, :destroy]
    end
  end
end
