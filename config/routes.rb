Rails.application.routes.draw do

  root 'v1/homepage#index'
  scope :v1 do
    get 'users/create', to: 'v1/users#create'
    get 'users/destroy', to: 'v1/users#destroy'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
