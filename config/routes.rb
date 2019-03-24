Rails.application.routes.draw do
  
  root 'static_pages#home'
  get 'chatroom', to: 'chatroom#index'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  post 'message', to: 'messages#create'
  get  '/signup',    to: 'users#new'
  post '/signup',    to: 'users#create'
  resources :users
  resources :relationships,   only: [:create, :destroy]
  
  
  mount ActionCable.server, at: '/cable'
 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
