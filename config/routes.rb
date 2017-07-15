Rails.application.routes.draw do
    devise_for :admins
    devise_for :users, path_prefix: 'd'
    resources :users do
        post :deactivate, on: :member
        post :activate, on: :member
    end
      
    resources :products do
        post :deactivate, on: :member
        post :activate, on: :member
    end
    
    resources :orders
    resources :messages
    
    get '/report', to: "reports#index"
    post '/report', to: "reports#create"
    
    
    root 'welcome#index'
end
