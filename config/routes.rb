Rails.application.routes.draw do

  root 'v1/homepage#index'

  namespace :api do
    namespace :v1 do
      post 'users/create', to: 'users#create'
      get 'users/destroy', to: 'users#destroy'
    end
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
