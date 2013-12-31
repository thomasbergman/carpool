Carpool::Application.routes.draw do
  
  root 'static_pages#home'
  
  match '/signup', 	to: 'users#new', via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/about',   to: 'static_pages#about',   via: 'get'
  match '/home', 		to: 'static_pages#home', 		via: 'get'

  resources :users
  
end
