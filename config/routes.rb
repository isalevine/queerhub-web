Rails.application.routes.draw do

  # namespace :v1 do
  #   get 'homepage/index'
  # end
  root 'v1/homepage#index'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
