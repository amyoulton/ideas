Rails.application.routes.draw do
  
resources :ideas
resources :users, only: [:new, :create]
resource :session, only: [:new, :create, :destroy] do
  resources :reviews, only: [:create, :destroy]
end

end
