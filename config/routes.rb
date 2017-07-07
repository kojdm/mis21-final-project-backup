Rails.application.routes.draw do
    devise_for :admins
    devise_for :users, path_prefix: 'd'
    resources :users
      
    resources :products
    
    root 'products#index'
end
