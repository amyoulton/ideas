Rails.application.routes.draw do
  
  root 'ideas#index'

resources :users, only: [:new, :create]

resource :session, only: [:new, :create, :destroy] 

resources :ideas do
  resources :likes, shallow: true, only: [:create, :destroy]
  resources :reviews, only: [:create, :destroy]

end

end
