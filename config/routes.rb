Rails.application.routes.draw do

  root 'v1/homepage#index'

  namespace :api do
    namespace :v1 do
      post 'users/create', to: 'users#create'
      delete 'users/destroy', to: 'users#destroy'
    end
  end

  # TODO: MUST implement auth for this route!! (https://github.com/mperham/sidekiq/wiki/Monitoring)
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
